// ============================================================
// El Coach — Auth Context
// ============================================================
// Gere l'etat d'authentification global de l'app.
// Ecoute les changements de session Supabase et redirige
// automatiquement vers Login ou App.
// ============================================================

import React, { createContext, useContext, useEffect, useState } from 'react';
import { Session, User } from '@supabase/supabase-js';
import { supabase } from '../services/supabase';
import { UserProfile } from '../types';

interface AuthState {
  session: Session | null;
  user: User | null;
  profile: UserProfile | null;
  isLoading: boolean;
  needsOnboarding: boolean;
}

interface AuthContextValue extends AuthState {
  signUp: (email: string, password: string) => Promise<{ error: string | null }>;
  signIn: (email: string, password: string) => Promise<{ error: string | null }>;
  signOut: () => Promise<void>;
  refreshProfile: () => Promise<void>;
  completeOnboarding: (data: OnboardingData) => Promise<{ error: string | null }>;
}

export interface OnboardingData {
  display_name: string;
  fitness_level: 'beginner' | 'intermediate' | 'advanced';
  goal: 'performance' | 'weight_loss' | 'general_fitness' | 'muscle_gain';
  body_weight_kg?: number;
  gender?: 'male' | 'female' | 'other';
}

const AuthContext = createContext<AuthContextValue | null>(null);

export function useAuth(): AuthContextValue {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error('useAuth must be used within AuthProvider');
  return ctx;
}

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [state, setState] = useState<AuthState>({
    session: null,
    user: null,
    profile: null,
    isLoading: true,
    needsOnboarding: false,
  });

  // Charger le profil utilisateur
  async function fetchProfile(userId: string): Promise<UserProfile | null> {
    const { data, error } = await supabase
      .from('user_profiles')
      .select('*')
      .eq('id', userId)
      .single();

    if (error && error.code !== 'PGRST116') {
      console.error('Error fetching profile:', error);
    }
    return data;
  }

  // Ecouter les changements de session
  useEffect(() => {
    // Recuperer la session actuelle
    supabase.auth.getSession().then(async ({ data: { session } }) => {
      if (session?.user) {
        const profile = await fetchProfile(session.user.id);
        setState({
          session,
          user: session.user,
          profile,
          isLoading: false,
          needsOnboarding: !profile || !profile.display_name,
        });
      } else {
        setState({
          session: null,
          user: null,
          profile: null,
          isLoading: false,
          needsOnboarding: false,
        });
      }
    });

    // Ecouter les changements
    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      async (event, session) => {
        if (session?.user) {
          const profile = await fetchProfile(session.user.id);
          setState({
            session,
            user: session.user,
            profile,
            isLoading: false,
            needsOnboarding: !profile || !profile.display_name,
          });
        } else {
          setState({
            session: null,
            user: null,
            profile: null,
            isLoading: false,
            needsOnboarding: false,
          });
        }
      },
    );

    return () => subscription.unsubscribe();
  }, []);

  // --- Actions ---

  async function signUp(email: string, password: string) {
    const { error } = await supabase.auth.signUp({ email, password });
    if (error) return { error: error.message };
    return { error: null };
  }

  async function signIn(email: string, password: string) {
    const { error } = await supabase.auth.signInWithPassword({ email, password });
    if (error) return { error: error.message };
    return { error: null };
  }

  async function signOut() {
    await supabase.auth.signOut();
  }

  async function refreshProfile() {
    if (!state.user) return;
    const profile = await fetchProfile(state.user.id);
    setState((prev) => ({
      ...prev,
      profile,
      needsOnboarding: !profile || !profile.display_name,
    }));
  }

  async function completeOnboarding(data: OnboardingData) {
    if (!state.user) return { error: 'Non connecte' };

    const now = new Date();
    const trialExpires = new Date(now.getTime() + 7 * 24 * 60 * 60 * 1000); // +7 jours

    const { error } = await supabase.from('user_profiles').upsert({
      id: state.user.id,
      email: state.user.email || '',
      display_name: data.display_name,
      fitness_level: data.fitness_level,
      goal: data.goal,
      body_weight_kg: data.body_weight_kg || null,
      gender: data.gender || null,
      subscription_tier: 'free_trial',
      trial_expires_at: trialExpires.toISOString(),
    });

    if (error) return { error: error.message };

    // Inscrire au programme CrossFit par defaut
    await supabase.from('user_programs').insert({
      user_id: state.user.id,
      program_id: '00000000-0000-0000-0000-000000000001',
      current_week: 1,
      current_day: 1,
      is_active: true,
    });

    await refreshProfile();
    return { error: null };
  }

  return (
    <AuthContext.Provider
      value={{
        ...state,
        signUp,
        signIn,
        signOut,
        refreshProfile,
        completeOnboarding,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
}
