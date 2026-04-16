// ============================================================
// El Coach — Onboarding Screen
// ============================================================
// S'affiche une seule fois apres la premiere inscription.
// Collecte : prenom, niveau, objectif, poids, genre.
// ============================================================

import React, { useState } from 'react';
import {
  View,
  Text,
  TextInput,
  StyleSheet,
  ScrollView,
  Alert,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { Colors, Spacing, FontSize, BorderRadius } from '../../constants/theme';
import Button from '../../components/Button';
import SegmentedControl from '../../components/SegmentedControl';
import Card from '../../components/Card';
import { useAuth, OnboardingData } from '../../contexts/AuthContext';

export default function OnboardingScreen() {
  const { completeOnboarding } = useAuth();
  const [step, setStep] = useState(0);
  const [loading, setLoading] = useState(false);

  // Form data
  const [displayName, setDisplayName] = useState('');
  const [fitnessLevel, setFitnessLevel] = useState<'beginner' | 'intermediate' | 'advanced'>('intermediate');
  const [goal, setGoal] = useState<'performance' | 'weight_loss' | 'general_fitness' | 'muscle_gain'>('general_fitness');
  const [bodyWeight, setBodyWeight] = useState('');
  const [gender, setGender] = useState<'male' | 'female' | 'other'>('male');

  async function handleComplete() {
    if (!displayName.trim()) {
      Alert.alert('Erreur', 'Entre ton prenom.');
      return;
    }

    setLoading(true);
    const data: OnboardingData = {
      display_name: displayName.trim(),
      fitness_level: fitnessLevel,
      goal,
      body_weight_kg: bodyWeight ? parseFloat(bodyWeight) : undefined,
      gender,
    };

    const { error } = await completeOnboarding(data);
    setLoading(false);

    if (error) {
      Alert.alert('Erreur', error);
    }
  }

  function nextStep() {
    if (step === 0 && !displayName.trim()) {
      Alert.alert('Erreur', 'Entre ton prenom.');
      return;
    }
    setStep((s) => Math.min(s + 1, 3));
  }

  // --- Step 0: Prenom ---
  function renderNameStep() {
    return (
      <View>
        <Ionicons name="person" size={48} color={Colors.primary} style={styles.stepIcon} />
        <Text style={styles.stepTitle}>Comment tu t'appelles ?</Text>
        <Text style={styles.stepSubtitle}>On va personnaliser ton experience</Text>
        <View style={styles.inputContainer}>
          <TextInput
            style={styles.input}
            placeholder="Ton prenom"
            placeholderTextColor={Colors.textMuted}
            value={displayName}
            onChangeText={setDisplayName}
            autoCapitalize="words"
            autoFocus
          />
        </View>
      </View>
    );
  }

  // --- Step 1: Niveau ---
  function renderLevelStep() {
    return (
      <View>
        <Ionicons name="barbell" size={48} color={Colors.primary} style={styles.stepIcon} />
        <Text style={styles.stepTitle}>Ton niveau ?</Text>
        <Text style={styles.stepSubtitle}>On adapte le programme a ton experience</Text>

        <Card style={styles.optionCard}>
          <OptionButton
            icon="leaf"
            title="Debutant"
            description="Moins d'1 an de training"
            selected={fitnessLevel === 'beginner'}
            onPress={() => setFitnessLevel('beginner')}
          />
          <OptionButton
            icon="flame"
            title="Intermediaire"
            description="1 a 3 ans de training"
            selected={fitnessLevel === 'intermediate'}
            onPress={() => setFitnessLevel('intermediate')}
          />
          <OptionButton
            icon="rocket"
            title="Avance"
            description="3+ ans de training"
            selected={fitnessLevel === 'advanced'}
            onPress={() => setFitnessLevel('advanced')}
          />
        </Card>
      </View>
    );
  }

  // --- Step 2: Objectif ---
  function renderGoalStep() {
    return (
      <View>
        <Ionicons name="flag" size={48} color={Colors.primary} style={styles.stepIcon} />
        <Text style={styles.stepTitle}>Ton objectif ?</Text>
        <Text style={styles.stepSubtitle}>On oriente tes seances en fonction</Text>

        <Card style={styles.optionCard}>
          <OptionButton
            icon="trending-up"
            title="Performance"
            description="Devenir plus fort et plus rapide"
            selected={goal === 'performance'}
            onPress={() => setGoal('performance')}
          />
          <OptionButton
            icon="body"
            title="Perte de poids"
            description="Bruler du gras, se dessiner"
            selected={goal === 'weight_loss'}
            onPress={() => setGoal('weight_loss')}
          />
          <OptionButton
            icon="heart"
            title="Forme generale"
            description="Etre en bonne sante"
            selected={goal === 'general_fitness'}
            onPress={() => setGoal('general_fitness')}
          />
          <OptionButton
            icon="barbell"
            title="Prise de muscle"
            description="Gagner en volume et en force"
            selected={goal === 'muscle_gain'}
            onPress={() => setGoal('muscle_gain')}
          />
        </Card>
      </View>
    );
  }

  // --- Step 3: Infos physiques ---
  function renderBodyStep() {
    return (
      <View>
        <Ionicons name="body" size={48} color={Colors.primary} style={styles.stepIcon} />
        <Text style={styles.stepTitle}>Quelques infos (optionnel)</Text>
        <Text style={styles.stepSubtitle}>Pour mieux calibrer tes charges</Text>

        <SegmentedControl
          label="Genre"
          options={[
            { value: 'male', label: 'Homme' },
            { value: 'female', label: 'Femme' },
            { value: 'other', label: 'Autre' },
          ]}
          selected={gender}
          onChange={setGender}
        />

        <Text style={styles.fieldLabel}>Poids (kg)</Text>
        <View style={styles.inputContainer}>
          <TextInput
            style={styles.input}
            placeholder="ex: 78"
            placeholderTextColor={Colors.textMuted}
            value={bodyWeight}
            onChangeText={setBodyWeight}
            keyboardType="numeric"
          />
        </View>
      </View>
    );
  }

  const steps = [renderNameStep, renderLevelStep, renderGoalStep, renderBodyStep];
  const isLastStep = step === steps.length - 1;

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView
        showsVerticalScrollIndicator={false}
        contentContainerStyle={styles.scroll}
        keyboardShouldPersistTaps="handled"
      >
        {/* Progress dots */}
        <View style={styles.dots}>
          {steps.map((_, i) => (
            <View key={i} style={[styles.dot, i <= step && styles.dotActive]} />
          ))}
        </View>

        {/* Current step */}
        {steps[step]()}
      </ScrollView>

      {/* Navigation */}
      <View style={styles.navBar}>
        {step > 0 ? (
          <Button title="Retour" variant="ghost" onPress={() => setStep((s) => s - 1)} />
        ) : (
          <View />
        )}
        <Button
          title={isLastStep ? "C'est parti !" : 'Suivant'}
          onPress={isLastStep ? handleComplete : nextStep}
          loading={loading}
        />
      </View>
    </SafeAreaView>
  );
}

// --- Option Button Component ---

interface OptionButtonProps {
  icon: string;
  title: string;
  description: string;
  selected: boolean;
  onPress: () => void;
}

function OptionButton({ icon, title, description, selected, onPress }: OptionButtonProps) {
  return (
    <View
      style={[styles.option, selected && styles.optionSelected]}
      onTouchEnd={onPress}
    >
      <Ionicons
        name={icon as any}
        size={22}
        color={selected ? Colors.primary : Colors.textMuted}
      />
      <View style={styles.optionText}>
        <Text style={[styles.optionTitle, selected && styles.optionTitleSelected]}>
          {title}
        </Text>
        <Text style={styles.optionDesc}>{description}</Text>
      </View>
      {selected && <Ionicons name="checkmark-circle" size={22} color={Colors.primary} />}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  scroll: {
    padding: Spacing.lg,
    paddingBottom: 120,
  },
  dots: {
    flexDirection: 'row',
    justifyContent: 'center',
    gap: Spacing.sm,
    marginBottom: Spacing.xxl,
  },
  dot: {
    width: 8,
    height: 8,
    borderRadius: 4,
    backgroundColor: Colors.surfaceLight,
  },
  dotActive: {
    backgroundColor: Colors.primary,
    width: 24,
  },
  stepIcon: {
    alignSelf: 'center',
    marginBottom: Spacing.md,
  },
  stepTitle: {
    fontSize: FontSize.xl,
    fontWeight: '800',
    color: Colors.text,
    textAlign: 'center',
  },
  stepSubtitle: {
    fontSize: FontSize.md,
    color: Colors.textSecondary,
    textAlign: 'center',
    marginTop: Spacing.xs,
    marginBottom: Spacing.xl,
  },
  inputContainer: {
    backgroundColor: Colors.surface,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
    borderColor: Colors.border,
    paddingHorizontal: Spacing.md,
  },
  input: {
    color: Colors.text,
    fontSize: FontSize.lg,
    paddingVertical: Spacing.md,
    textAlign: 'center',
  },
  fieldLabel: {
    color: Colors.textSecondary,
    fontSize: FontSize.md,
    marginBottom: Spacing.sm,
    marginTop: Spacing.md,
  },
  optionCard: {
    gap: Spacing.sm,
  },
  option: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.md,
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    backgroundColor: Colors.surfaceLight,
  },
  optionSelected: {
    backgroundColor: Colors.primary + '15',
    borderWidth: 1,
    borderColor: Colors.primary,
  },
  optionText: {
    flex: 1,
  },
  optionTitle: {
    color: Colors.text,
    fontSize: FontSize.base,
    fontWeight: '600',
  },
  optionTitleSelected: {
    color: Colors.primary,
  },
  optionDesc: {
    color: Colors.textMuted,
    fontSize: FontSize.sm,
    marginTop: 2,
  },
  navBar: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: Spacing.md,
    borderTopWidth: 0.5,
    borderTopColor: Colors.border,
    backgroundColor: Colors.surface,
  },
});
