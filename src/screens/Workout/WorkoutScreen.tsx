// ============================================================
// El Coach — Workout Screen
// ============================================================
// Displays: Warm-up → Strength → WOD → Finisher → Feedback
// Each block is a step the user progresses through.
// ============================================================

import React, { useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  TextInput,
  Alert,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { Colors, Spacing, FontSize, BorderRadius } from '../../constants/theme';
import Card from '../../components/Card';
import Button from '../../components/Button';
import FeedbackSlider from '../../components/FeedbackSlider';
import SegmentedControl from '../../components/SegmentedControl';
import {
  EnergyLevel,
  FeelingLevel,
  ExhaustionLevel,
} from '../../types';

type WorkoutStep = 'warmup' | 'strength' | 'wod' | 'finisher' | 'feedback' | 'complete';

const STEPS: WorkoutStep[] = ['warmup', 'strength', 'wod', 'finisher', 'feedback'];
const STEP_LABELS: Record<WorkoutStep, string> = {
  warmup: 'Warm-up',
  strength: 'Strength',
  wod: 'WOD',
  finisher: 'Finisher',
  feedback: 'Feedback',
  complete: 'Done',
};

// Mock workout data
const MOCK_WARMUP = [
  '400m Row',
  '10 Arm Circles (each direction)',
  '10 Leg Swings (each side)',
  '10 PVC Pass-throughs',
  '5 Inch Worms',
];

const MOCK_STRENGTH = {
  name: 'Back Squat',
  sets: [
    { set: 1, reps: 5, targetWeight: 80, percentage: 70 },
    { set: 2, reps: 5, targetWeight: 85, percentage: 75 },
    { set: 3, reps: 3, targetWeight: 92.5, percentage: 80 },
    { set: 4, reps: 3, targetWeight: 97.5, percentage: 85 },
    { set: 5, reps: 1, targetWeight: 105, percentage: 90 },
  ],
};

const MOCK_WOD = {
  name: 'MetCon Madness',
  format: 'AMRAP 12 min',
  exercises: ['12 Wall Balls (9/6kg)', '9 Box Jumps (24/20")', '6 Burpee Pull-ups'],
};

const MOCK_FINISHER = {
  name: 'Core Blast',
  exercises: ['30s Plank', '15 V-ups', '20 Russian Twists', '30s Side Plank (each)'],
  rounds: 3,
};

export default function WorkoutScreen({ navigation }: any) {
  const [currentStep, setCurrentStep] = useState<WorkoutStep>('warmup');
  const [warmupChecked, setWarmupChecked] = useState<boolean[]>(MOCK_WARMUP.map(() => false));

  // Strength tracking
  const [strengthLogs, setStrengthLogs] = useState(
    MOCK_STRENGTH.sets.map((s) => ({ weight: s.targetWeight.toString(), reps: s.reps.toString() })),
  );

  // WOD tracking
  const [wodScore, setWodScore] = useState('');

  // Feedback state
  const [warmupFeeling, setWarmupFeeling] = useState<EnergyLevel>('normal');
  const [strengthDifficulty, setStrengthDifficulty] = useState<FeelingLevel>('ok');
  const [strengthRpe, setStrengthRpe] = useState(7);
  const [wodFeeling, setWodFeeling] = useState<ExhaustionLevel>('tired');
  const [finisherFeeling, setFinisherFeeling] = useState<ExhaustionLevel>('tired');
  const [globalFatigue, setGlobalFatigue] = useState(5);
  const [motivation, setMotivation] = useState(7);

  const currentIndex = STEPS.indexOf(currentStep);

  function nextStep() {
    if (currentIndex < STEPS.length - 1) {
      setCurrentStep(STEPS[currentIndex + 1]);
    } else {
      setCurrentStep('complete');
    }
  }

  function prevStep() {
    if (currentIndex > 0) {
      setCurrentStep(STEPS[currentIndex - 1]);
    }
  }

  function submitWorkout() {
    Alert.alert('Workout Complete!', 'Great session. Your data has been saved.', [
      { text: 'OK', onPress: () => navigation.goBack() },
    ]);
  }

  function toggleWarmup(index: number) {
    setWarmupChecked((prev) => {
      const next = [...prev];
      next[index] = !next[index];
      return next;
    });
  }

  // --- Render Steps ---

  function renderWarmup() {
    return (
      <View>
        <Text style={styles.blockTitle}>Warm-up</Text>
        <Text style={styles.blockSubtitle}>Complete each movement</Text>
        {MOCK_WARMUP.map((item, i) => (
          <TouchableOpacity key={i} onPress={() => toggleWarmup(i)} style={styles.checkItem}>
            <Ionicons
              name={warmupChecked[i] ? 'checkbox' : 'square-outline'}
              size={24}
              color={warmupChecked[i] ? Colors.success : Colors.textMuted}
            />
            <Text style={[styles.checkText, warmupChecked[i] && styles.checkTextDone]}>{item}</Text>
          </TouchableOpacity>
        ))}
      </View>
    );
  }

  function renderStrength() {
    return (
      <View>
        <Text style={styles.blockTitle}>{MOCK_STRENGTH.name}</Text>
        <Text style={styles.blockSubtitle}>Log your sets</Text>
        {MOCK_STRENGTH.sets.map((set, i) => (
          <Card key={i} style={styles.setCard}>
            <View style={styles.setHeader}>
              <Text style={styles.setLabel}>Set {set.set}</Text>
              <Text style={styles.setTarget}>
                {set.reps} reps @ {set.percentage}%
              </Text>
            </View>
            <View style={styles.setInputs}>
              <View style={styles.inputGroup}>
                <Text style={styles.inputLabel}>kg</Text>
                <TextInput
                  style={styles.input}
                  keyboardType="numeric"
                  value={strengthLogs[i].weight}
                  onChangeText={(v) => {
                    const next = [...strengthLogs];
                    next[i] = { ...next[i], weight: v };
                    setStrengthLogs(next);
                  }}
                  placeholderTextColor={Colors.textMuted}
                />
              </View>
              <View style={styles.inputGroup}>
                <Text style={styles.inputLabel}>reps</Text>
                <TextInput
                  style={styles.input}
                  keyboardType="numeric"
                  value={strengthLogs[i].reps}
                  onChangeText={(v) => {
                    const next = [...strengthLogs];
                    next[i] = { ...next[i], reps: v };
                    setStrengthLogs(next);
                  }}
                  placeholderTextColor={Colors.textMuted}
                />
              </View>
            </View>
          </Card>
        ))}
      </View>
    );
  }

  function renderWod() {
    return (
      <View>
        <Text style={styles.blockTitle}>{MOCK_WOD.name}</Text>
        <View style={styles.wodFormatBadge}>
          <Text style={styles.wodFormatText}>{MOCK_WOD.format}</Text>
        </View>
        <Card style={styles.wodCard}>
          {MOCK_WOD.exercises.map((ex, i) => (
            <Text key={i} style={styles.wodExercise}>
              {ex}
            </Text>
          ))}
        </Card>
        <View style={styles.wodScoreSection}>
          <Text style={styles.inputLabel}>Your Score (rounds + reps)</Text>
          <TextInput
            style={[styles.input, styles.wodInput]}
            placeholder="e.g. 8+6"
            placeholderTextColor={Colors.textMuted}
            value={wodScore}
            onChangeText={setWodScore}
          />
        </View>
        <Button
          title="Open Timer"
          variant="secondary"
          onPress={() => {}}
          style={{ marginTop: Spacing.sm }}
        />
      </View>
    );
  }

  function renderFinisher() {
    return (
      <View>
        <Text style={styles.blockTitle}>{MOCK_FINISHER.name}</Text>
        <Text style={styles.blockSubtitle}>{MOCK_FINISHER.rounds} rounds</Text>
        <Card>
          {MOCK_FINISHER.exercises.map((ex, i) => (
            <Text key={i} style={styles.finisherExercise}>
              {ex}
            </Text>
          ))}
        </Card>
      </View>
    );
  }

  function renderFeedback() {
    return (
      <View>
        <Text style={styles.blockTitle}>Session Feedback</Text>
        <Text style={styles.blockSubtitle}>Help your coach adapt</Text>

        <SegmentedControl
          label="Warm-up feeling"
          options={[
            { value: 'tired', label: 'Tired' },
            { value: 'normal', label: 'Normal' },
            { value: 'good', label: 'Good' },
          ]}
          selected={warmupFeeling}
          onChange={setWarmupFeeling}
        />

        <SegmentedControl
          label="Strength difficulty"
          options={[
            { value: 'easy', label: 'Easy' },
            { value: 'ok', label: 'OK' },
            { value: 'hard', label: 'Hard' },
          ]}
          selected={strengthDifficulty}
          onChange={setStrengthDifficulty}
        />

        <FeedbackSlider label="Strength RPE" value={strengthRpe} onChange={setStrengthRpe} />

        <SegmentedControl
          label="WOD feeling"
          options={[
            { value: 'fresh', label: 'Fresh' },
            { value: 'tired', label: 'Tired' },
            { value: 'exhausted', label: 'Exhausted' },
          ]}
          selected={wodFeeling}
          onChange={setWodFeeling}
        />

        <SegmentedControl
          label="Finisher feeling"
          options={[
            { value: 'fresh', label: 'Fresh' },
            { value: 'tired', label: 'Tired' },
            { value: 'exhausted', label: 'Exhausted' },
          ]}
          selected={finisherFeeling}
          onChange={setFinisherFeeling}
        />

        <FeedbackSlider label="Global Fatigue" value={globalFatigue} onChange={setGlobalFatigue} />
        <FeedbackSlider label="Motivation" value={motivation} onChange={setMotivation} />
      </View>
    );
  }

  function renderComplete() {
    return (
      <View style={styles.completeContainer}>
        <Ionicons name="trophy" size={64} color={Colors.primary} />
        <Text style={styles.completeTitle}>Workout Complete!</Text>
        <Text style={styles.completeSubtitle}>Great job showing up today.</Text>
        <Button title="Save & Exit" onPress={submitWorkout} style={{ marginTop: Spacing.lg }} />
      </View>
    );
  }

  const stepRenderers: Record<WorkoutStep, () => React.ReactNode> = {
    warmup: renderWarmup,
    strength: renderStrength,
    wod: renderWod,
    finisher: renderFinisher,
    feedback: renderFeedback,
    complete: renderComplete,
  };

  return (
    <SafeAreaView style={styles.container}>
      {/* Step Indicator */}
      {currentStep !== 'complete' && (
        <View style={styles.stepIndicator}>
          {STEPS.map((step, i) => (
            <View key={step} style={styles.stepDotContainer}>
              <View
                style={[
                  styles.stepDot,
                  i <= currentIndex ? styles.stepDotActive : styles.stepDotInactive,
                ]}
              />
              <Text
                style={[
                  styles.stepLabel,
                  i === currentIndex && styles.stepLabelActive,
                ]}
              >
                {STEP_LABELS[step]}
              </Text>
            </View>
          ))}
        </View>
      )}

      <ScrollView
        showsVerticalScrollIndicator={false}
        contentContainerStyle={styles.scroll}
        keyboardShouldPersistTaps="handled"
      >
        {stepRenderers[currentStep]()}
      </ScrollView>

      {/* Navigation */}
      {currentStep !== 'complete' && (
        <View style={styles.navBar}>
          <TouchableOpacity
            onPress={currentIndex === 0 ? () => navigation.goBack() : prevStep}
            style={styles.navButton}
          >
            <Ionicons name="arrow-back" size={20} color={Colors.text} />
            <Text style={styles.navText}>
              {currentIndex === 0 ? 'Exit' : 'Back'}
            </Text>
          </TouchableOpacity>
          <Button
            title={currentStep === 'feedback' ? 'Complete' : 'Next'}
            onPress={nextStep}
            size="sm"
          />
        </View>
      )}
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  scroll: {
    padding: Spacing.md,
    paddingBottom: 120,
  },
  stepIndicator: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderBottomWidth: 0.5,
    borderBottomColor: Colors.border,
  },
  stepDotContainer: {
    alignItems: 'center',
    gap: 4,
  },
  stepDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
  },
  stepDotActive: {
    backgroundColor: Colors.primary,
  },
  stepDotInactive: {
    backgroundColor: Colors.surfaceLight,
  },
  stepLabel: {
    fontSize: 9,
    color: Colors.textMuted,
    fontWeight: '600',
  },
  stepLabelActive: {
    color: Colors.primary,
  },
  blockTitle: {
    fontSize: FontSize.xl,
    fontWeight: '800',
    color: Colors.text,
    marginBottom: 4,
  },
  blockSubtitle: {
    fontSize: FontSize.md,
    color: Colors.textSecondary,
    marginBottom: Spacing.lg,
  },
  // Warmup
  checkItem: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.md,
    paddingVertical: Spacing.sm,
  },
  checkText: {
    color: Colors.text,
    fontSize: FontSize.base,
  },
  checkTextDone: {
    textDecorationLine: 'line-through',
    color: Colors.textMuted,
  },
  // Strength
  setCard: {
    marginBottom: Spacing.sm,
  },
  setHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: Spacing.sm,
  },
  setLabel: {
    color: Colors.primary,
    fontWeight: '700',
    fontSize: FontSize.md,
  },
  setTarget: {
    color: Colors.textMuted,
    fontSize: FontSize.sm,
  },
  setInputs: {
    flexDirection: 'row',
    gap: Spacing.md,
  },
  inputGroup: {
    flex: 1,
  },
  inputLabel: {
    color: Colors.textSecondary,
    fontSize: FontSize.xs,
    marginBottom: 4,
  },
  input: {
    backgroundColor: Colors.surfaceLight,
    borderRadius: BorderRadius.sm,
    color: Colors.text,
    padding: Spacing.sm,
    fontSize: FontSize.base,
    fontWeight: '600',
  },
  // WOD
  wodFormatBadge: {
    backgroundColor: Colors.primary + '20',
    alignSelf: 'flex-start',
    paddingHorizontal: Spacing.sm,
    paddingVertical: 4,
    borderRadius: BorderRadius.sm,
    marginBottom: Spacing.md,
  },
  wodFormatText: {
    color: Colors.primary,
    fontWeight: '700',
    fontSize: FontSize.sm,
  },
  wodCard: {
    gap: Spacing.sm,
  },
  wodExercise: {
    color: Colors.text,
    fontSize: FontSize.base,
    fontWeight: '500',
  },
  wodScoreSection: {
    marginTop: Spacing.md,
  },
  wodInput: {
    marginTop: 4,
  },
  // Finisher
  finisherExercise: {
    color: Colors.text,
    fontSize: FontSize.base,
    paddingVertical: 4,
  },
  // Complete
  completeContainer: {
    alignItems: 'center',
    justifyContent: 'center',
    paddingTop: Spacing.xxl * 2,
  },
  completeTitle: {
    fontSize: FontSize.xxl,
    fontWeight: '800',
    color: Colors.text,
    marginTop: Spacing.md,
  },
  completeSubtitle: {
    fontSize: FontSize.base,
    color: Colors.textSecondary,
    marginTop: Spacing.sm,
  },
  // Nav
  navBar: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderTopWidth: 0.5,
    borderTopColor: Colors.border,
    backgroundColor: Colors.surface,
  },
  navButton: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.xs,
    padding: Spacing.sm,
  },
  navText: {
    color: Colors.text,
    fontSize: FontSize.base,
  },
});
