// ============================================================
// El Coach — App Entry Point
// ============================================================

import React, { useState } from 'react';
import { StatusBar } from 'expo-status-bar';
import { NavigationContainer } from '@react-navigation/native';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { View, ActivityIndicator, StyleSheet } from 'react-native';
import { AuthProvider, useAuth } from './src/contexts/AuthContext';
import { Colors } from './src/constants/theme';
import RootNavigator from './src/navigation/RootNavigator';
import LoginScreen from './src/screens/Auth/LoginScreen';
import SignUpScreen from './src/screens/Auth/SignUpScreen';
import OnboardingScreen from './src/screens/Onboarding/OnboardingScreen';

function AppContent() {
  const { session, isLoading, needsOnboarding } = useAuth();
  const [authScreen, setAuthScreen] = useState<'login' | 'signup'>('login');

  // Ecran de chargement
  if (isLoading) {
    return (
      <View style={styles.loading}>
        <ActivityIndicator size="large" color={Colors.primary} />
      </View>
    );
  }

  // Pas connecte → Login ou Signup
  if (!session) {
    if (authScreen === 'login') {
      return <LoginScreen onSwitchToSignUp={() => setAuthScreen('signup')} />;
    }
    return <SignUpScreen onSwitchToLogin={() => setAuthScreen('login')} />;
  }

  // Connecte mais pas de profil → Onboarding
  if (needsOnboarding) {
    return <OnboardingScreen />;
  }

  // Connecte + profil → App principale
  return (
    <NavigationContainer>
      <RootNavigator />
    </NavigationContainer>
  );
}

export default function App() {
  return (
    <SafeAreaProvider>
      <StatusBar style="light" />
      <AuthProvider>
        <AppContent />
      </AuthProvider>
    </SafeAreaProvider>
  );
}

const styles = StyleSheet.create({
  loading: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: Colors.background,
  },
});
