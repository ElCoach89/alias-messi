// ============================================================
// El Coach — Sign Up Screen (brutalist design)
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
  onSwitchToLogin: () => void;
}

export default function SignUpScreen({ onSwitchToLogin }: Props) {
  const { signUp, signIn } = useAuth();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);

  async function handleSignUp() {
    if (!email.trim() || !password.trim() || !confirmPassword.trim()) {
      Alert.alert('Erreur', 'Remplis tous les champs.');
      return;
    }

    if (password !== confirmPassword) {
      Alert.alert('Erreur', 'Les mots de passe ne correspondent pas.');
      return;
    }

    if (password.length < 6) {
      Alert.alert('Erreur', 'Le mot de passe doit faire au moins 6 caracteres.');
      return;
    }

    setLoading(true);
    const { error } = await signUp(email.trim(), password);

    if (error) {
      setLoading(false);
      Alert.alert('Inscription impossible', error);
    } else {
      // Auto-login apres inscription (si confirm email desactive)
      const loginResult = await signIn(email.trim(), password);
      setLoading(false);
      if (loginResult.error) {
        Alert.alert(
          'Compte cree',
          'Verifie ta boite mail puis connecte-toi.',
          [{ text: 'OK', onPress: onSwitchToLogin }],
        );
      }
    }
  }

  return (
    <SafeAreaView style={styles.container}>
      <KeyboardAvoidingView
        behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
        style={styles.inner}
      >
        {/* Header */}
        <View style={styles.header}>
          <Text style={styles.sectionLabel}>[ 01 ] INSCRIPTION</Text>
          <Text style={styles.title}>CREER UN COMPTE</Text>
          <Text style={styles.subtitle}>7 JOURS D'ESSAI GRATUIT</Text>
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
              autoComplete="new-password"
            />
            <TouchableOpacity onPress={() => setShowPassword(!showPassword)} style={styles.eyeButton}>
              <Text style={styles.eyeText}>{showPassword ? 'CACHER' : 'VOIR'}</Text>
            </TouchableOpacity>
          </View>

          <Text style={styles.fieldLabel}>CONFIRMER</Text>
          <View style={styles.inputContainer}>
            <TextInput
              style={styles.input}
              placeholder="Meme mot de passe"
              placeholderTextColor={Colors.textMuted}
              value={confirmPassword}
              onChangeText={setConfirmPassword}
              secureTextEntry={!showPassword}
              autoComplete="new-password"
            />
          </View>

          <View style={{ height: Spacing.sm }} />
          <Button title="S'inscrire" onPress={handleSignUp} loading={loading} size="lg" />
        </View>

        {/* Lien login */}
        <View style={styles.footer}>
          <Text style={styles.footerText}>Deja un compte ?</Text>
          <TouchableOpacity onPress={onSwitchToLogin}>
            <Text style={styles.footerLink}> SE CONNECTER</Text>
          </TouchableOpacity>
        </View>
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
    marginBottom: Spacing.xxl,
  },
  sectionLabel: {
    fontFamily: 'monospace',
    fontSize: FontSize.xs,
    color: Colors.mute,
    letterSpacing: 2,
    marginBottom: Spacing.sm,
  },
  title: {
    fontSize: FontSize.xxl,
    fontWeight: '800',
    color: Colors.text,
    letterSpacing: 2,
  },
  subtitle: {
    fontFamily: 'monospace',
    fontSize: FontSize.sm,
    color: Colors.success,
    letterSpacing: 2,
    marginTop: Spacing.xs,
  },
  form: {
    gap: Spacing.xs,
  },
  fieldLabel: {
    fontFamily: 'monospace',
    fontSize: FontSize.xs,
    color: Colors.mute,
    letterSpacing: 2,
    marginTop: Spacing.md,
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
});
