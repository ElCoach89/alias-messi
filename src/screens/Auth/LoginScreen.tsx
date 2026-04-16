// ============================================================
// El Coach — Login Screen (brutalist design)
// ============================================================

import React, { useState } from 'react';
import {
  View,
  Text,
  TextInput,
  StyleSheet,
  TouchableOpacity,
  KeyboardAvoidingView,
  Platform,
  Alert,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Colors, Spacing, FontSize } from '../../constants/theme';
import Button from '../../components/Button';
import { useAuth } from '../../contexts/AuthContext';

interface Props {
  onSwitchToSignUp: () => void;
}

export default function LoginScreen({ onSwitchToSignUp }: Props) {
  const { signIn } = useAuth();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);

  async function handleLogin() {
    if (!email.trim() || !password.trim()) {
      Alert.alert('Erreur', 'Remplis tous les champs.');
      return;
    }

    setLoading(true);
    const { error } = await signIn(email.trim(), password);
    setLoading(false);

    if (error) {
      Alert.alert('Connexion impossible', error);
    }
  }

  return (
    <SafeAreaView style={styles.container}>
      <KeyboardAvoidingView
        behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
        style={styles.inner}
      >
        {/* Logo */}
        <View style={styles.header}>
          <View style={styles.logoMark}>
            <View style={styles.logoInner} />
          </View>
          <Text style={styles.title}>EL COACH</Text>
          <Text style={styles.subtitle}>SYSTEME D'ENTRAINEMENT</Text>
        </View>

        {/* Formulaire */}
        <View style={styles.form}>
          <Text style={styles.fieldLabel}>EMAIL</Text>
          <View style={styles.inputContainer}>
            <TextInput
              style={styles.input}
              placeholder="ton@email.com"
              placeholderTextColor={Colors.textMuted}
              value={email}
              onChangeText={setEmail}
              autoCapitalize="none"
              keyboardType="email-address"
              autoComplete="email"
            />
          </View>

          <Text style={styles.fieldLabel}>MOT DE PASSE</Text>
          <View style={styles.inputContainer}>
            <TextInput
              style={styles.input}
              placeholder="6+ caracteres"
              placeholderTextColor={Colors.textMuted}
              value={password}
              onChangeText={setPassword}
              secureTextEntry={!showPassword}
              autoComplete="password"
            />
            <TouchableOpacity onPress={() => setShowPassword(!showPassword)} style={styles.eyeButton}>
              <Text style={styles.eyeText}>{showPassword ? 'CACHER' : 'VOIR'}</Text>
            </TouchableOpacity>
          </View>

          <Button title="Se connecter" onPress={handleLogin} loading={loading} size="lg" />
        </View>

        {/* Lien inscription */}
        <View style={styles.footer}>
          <Text style={styles.footerText}>Pas encore de compte ?</Text>
          <TouchableOpacity onPress={onSwitchToSignUp}>
            <Text style={styles.footerLink}> CREER UN COMPTE</Text>
          </TouchableOpacity>
        </View>

        {/* Separator */}
        <View style={styles.separator} />
        <Text style={styles.version}>V1 / PROD</Text>
      </KeyboardAvoidingView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  inner: {
    flex: 1,
    justifyContent: 'center',
    padding: Spacing.lg,
  },
  header: {
    alignItems: 'center',
    marginBottom: Spacing.xxl,
  },
  logoMark: {
    width: 48,
    height: 48,
    borderWidth: 2,
    borderColor: Colors.white,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: Spacing.md,
  },
  logoInner: {
    width: 12,
    height: 12,
    borderRadius: 6,
    backgroundColor: Colors.white,
  },
  title: {
    fontSize: FontSize.xxl,
    fontWeight: '800',
    color: Colors.text,
    letterSpacing: 6,
    fontFamily: 'monospace',
  },
  subtitle: {
    fontFamily: 'monospace',
    fontSize: FontSize.xs,
    color: Colors.mute,
    letterSpacing: 3,
    marginTop: Spacing.sm,
  },
  form: {
    gap: Spacing.sm,
  },
  fieldLabel: {
    fontFamily: 'monospace',
    fontSize: FontSize.xs,
    color: Colors.mute,
    letterSpacing: 2,
    marginTop: Spacing.sm,
    marginBottom: Spacing.xs,
  },
  inputContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: Colors.ash,
    borderWidth: 1,
    borderColor: Colors.line,
    paddingHorizontal: Spacing.md,
  },
  input: {
    flex: 1,
    color: Colors.text,
    fontSize: FontSize.base,
    fontFamily: 'monospace',
    paddingVertical: Spacing.md,
  },
  eyeButton: {
    padding: Spacing.sm,
  },
  eyeText: {
    fontFamily: 'monospace',
    fontSize: FontSize.xs,
    color: Colors.mute,
    letterSpacing: 1,
  },
  footer: {
    flexDirection: 'row',
    justifyContent: 'center',
    marginTop: Spacing.xl,
  },
  footerText: {
    color: Colors.textMuted,
    fontSize: FontSize.md,
  },
  footerLink: {
    color: Colors.white,
    fontSize: FontSize.md,
    fontWeight: '700',
    fontFamily: 'monospace',
    letterSpacing: 1,
  },
  separator: {
    height: 1,
    backgroundColor: Colors.line,
    marginTop: Spacing.xxl,
    marginBottom: Spacing.md,
  },
  version: {
    fontFamily: 'monospace',
    fontSize: FontSize.xs,
    color: Colors.textMuted,
    letterSpacing: 2,
    textAlign: 'center',
  },
});
