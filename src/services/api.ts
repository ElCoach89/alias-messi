// ============================================================
// El Coach — API Service Layer
// ============================================================

import { supabase } from './supabase';
import {
  UserProfile,
  OneRepMax,
  Session,
  WorkoutBlock,
  WorkoutLog,
  ExerciseLog,
  WodLog,
  SessionFeedback,
  AdaptiveScores,
} from '../types';

// --- Auth ---

export async function signUp(email: string, password: string) {
  const { data, error } = await supabase.auth.signUp({ email, password });
  if (error) throw error;
  return data;
}

export async function signIn(email: string, password: string) {
  const { data, error } = await supabase.auth.signInWithPassword({ email, password });
  if (error) throw error;
  return data;
}

export async function signOut() {
  const { error } = await supabase.auth.signOut();
  if (error) throw error;
}

export async function getCurrentUser() {
  const { data: { user } } = await supabase.auth.getUser();
  return user;
}

// --- Profile ---

export async function getProfile(userId: string): Promise<UserProfile | null> {
  const { data, error } = await supabase
    .from('user_profiles')
    .select('*')
    .eq('id', userId)
    .single();
  if (error) throw error;
  return data;
}

export async function updateProfile(userId: string, updates: Partial<UserProfile>) {
  const { data, error } = await supabase
    .from('user_profiles')
    .update(updates)
    .eq('id', userId)
    .select()
    .single();
  if (error) throw error;
  return data;
}

// --- 1RM ---

export async function getOneRepMaxes(userId: string): Promise<OneRepMax[]> {
  const { data, error } = await supabase
    .from('one_rep_maxes')
    .select('*')
    .eq('user_id', userId)
    .order('recorded_at', { ascending: false });
  if (error) throw error;
  return data || [];
}

export async function getLatestOneRepMax(userId: string, exerciseName: string): Promise<OneRepMax | null> {
  const { data, error } = await supabase
    .from('one_rep_maxes')
    .select('*')
    .eq('user_id', userId)
    .eq('exercise_name', exerciseName)
    .order('recorded_at', { ascending: false })
    .limit(1)
    .single();
  if (error && error.code !== 'PGRST116') throw error;
  return data;
}

export async function upsertOneRepMax(userId: string, exerciseName: string, weightKg: number) {
  const { data, error } = await supabase
    .from('one_rep_maxes')
    .insert({ user_id: userId, exercise_name: exerciseName, weight_kg: weightKg })
    .select()
    .single();
  if (error) throw error;
  return data;
}

// --- Programs & Sessions ---

export async function getActiveProgram(userId: string) {
  const { data, error } = await supabase
    .from('user_programs')
    .select('*, programs(*)')
    .eq('user_id', userId)
    .eq('is_active', true)
    .single();
  if (error && error.code !== 'PGRST116') throw error;
  return data;
}

export async function getProgramWeeks(programId: string) {
  const { data, error } = await supabase
    .from('program_weeks')
    .select('*')
    .eq('program_id', programId)
    .order('week_number');
  if (error) throw error;
  return data || [];
}

export async function getSessionsForWeek(weekId: string): Promise<Session[]> {
  const { data, error } = await supabase
    .from('sessions')
    .select('*')
    .eq('week_id', weekId)
    .order('day_number');
  if (error) throw error;
  return data || [];
}

export async function getSessionWithBlocks(sessionId: string) {
  const { data: session, error: sErr } = await supabase
    .from('sessions')
    .select('*')
    .eq('id', sessionId)
    .single();
  if (sErr) throw sErr;

  const { data: blocks, error: bErr } = await supabase
    .from('workout_blocks')
    .select('*, block_exercises(*)')
    .eq('session_id', sessionId)
    .order('order_index');
  if (bErr) throw bErr;

  return { session, blocks: blocks || [] };
}

// --- Workout Logs ---

export async function startWorkout(userId: string, sessionId: string, weekId: string): Promise<WorkoutLog> {
  const { data, error } = await supabase
    .from('workout_logs')
    .insert({
      user_id: userId,
      session_id: sessionId,
      program_week_id: weekId,
      status: 'in_progress',
    })
    .select()
    .single();
  if (error) throw error;
  return data;
}

export async function completeWorkout(workoutLogId: string) {
  const { data, error } = await supabase
    .from('workout_logs')
    .update({ status: 'completed', completed_at: new Date().toISOString() })
    .eq('id', workoutLogId)
    .select()
    .single();
  if (error) throw error;
  return data;
}

export async function getRecentWorkoutLogs(userId: string, limit = 10): Promise<WorkoutLog[]> {
  const { data, error } = await supabase
    .from('workout_logs')
    .select('*')
    .eq('user_id', userId)
    .order('started_at', { ascending: false })
    .limit(limit);
  if (error) throw error;
  return data || [];
}

// --- Exercise Logs ---

export async function logExerciseSet(log: Omit<ExerciseLog, 'id'>) {
  const { data, error } = await supabase
    .from('exercise_logs')
    .insert(log)
    .select()
    .single();
  if (error) throw error;
  return data;
}

export async function getExerciseHistory(userId: string, exerciseName: string, limit = 20) {
  const { data, error } = await supabase
    .from('exercise_logs')
    .select('*, workout_logs!inner(user_id, started_at)')
    .eq('workout_logs.user_id', userId)
    .eq('exercise_name', exerciseName)
    .order('workout_logs(started_at)', { ascending: false })
    .limit(limit);
  if (error) throw error;
  return data || [];
}

// --- WOD Logs ---

export async function logWod(log: Omit<WodLog, 'id'>) {
  const { data, error } = await supabase
    .from('wod_logs')
    .insert(log)
    .select()
    .single();
  if (error) throw error;
  return data;
}

// --- Feedback ---

export async function submitFeedback(feedback: Omit<SessionFeedback, 'id' | 'created_at'>) {
  const { data, error } = await supabase
    .from('session_feedback')
    .insert(feedback)
    .select()
    .single();
  if (error) throw error;
  return data;
}

export async function getRecentFeedback(userId: string, limit = 3): Promise<SessionFeedback[]> {
  const { data, error } = await supabase
    .from('session_feedback')
    .select('*')
    .eq('user_id', userId)
    .order('created_at', { ascending: false })
    .limit(limit);
  if (error) throw error;
  return data || [];
}

// --- Adaptive Scores ---

export async function saveAdaptiveScores(userId: string, scores: AdaptiveScores) {
  const { data, error } = await supabase
    .from('adaptive_scores')
    .insert({ user_id: userId, ...scores })
    .select()
    .single();
  if (error) throw error;
  return data;
}

export async function getLatestAdaptiveScores(userId: string): Promise<AdaptiveScores | null> {
  const { data, error } = await supabase
    .from('adaptive_scores')
    .select('*')
    .eq('user_id', userId)
    .order('computed_at', { ascending: false })
    .limit(1)
    .single();
  if (error && error.code !== 'PGRST116') throw error;
  return data;
}

// --- Stats ---

export async function getCompletedSessionCount(userId: string): Promise<number> {
  const { count, error } = await supabase
    .from('workout_logs')
    .select('*', { count: 'exact', head: true })
    .eq('user_id', userId)
    .eq('status', 'completed');
  if (error) throw error;
  return count || 0;
}

export async function getPersonalRecords(userId: string) {
  const { data, error } = await supabase
    .from('exercise_logs')
    .select('exercise_name, weight_kg, workout_logs!inner(user_id)')
    .eq('workout_logs.user_id', userId)
    .not('weight_kg', 'is', null)
    .order('weight_kg', { ascending: false });
  if (error) throw error;

  // Group by exercise and get max
  const prMap = new Map<string, number>();
  for (const log of data || []) {
    const current = prMap.get(log.exercise_name) || 0;
    if (log.weight_kg && log.weight_kg > current) {
      prMap.set(log.exercise_name, log.weight_kg);
    }
  }

  return Array.from(prMap.entries()).map(([name, weight]) => ({
    exercise_name: name,
    max_weight_kg: weight,
  }));
}
