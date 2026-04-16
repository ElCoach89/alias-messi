// ============================================================
// El Coach — Week Detail Screen
// ============================================================

import React from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { RouteProp } from '@react-navigation/native';
import { Colors, Spacing, FontSize, BorderRadius } from '../../constants/theme';
import Card from '../../components/Card';
import { ProgramStackParamList, FinisherType } from '../../types';

type Props = {
  navigation: NativeStackNavigationProp<ProgramStackParamList, 'WeekDetail'>;
  route: RouteProp<ProgramStackParamList, 'WeekDetail'>;
};

const FINISHER_LABELS: Record<FinisherType, string> = {
  core: 'Core',
  cardio: 'Cardio',
  mixed: 'Mixed',
  none: 'Recovery',
};

// Mock sessions for a week
const MOCK_SESSIONS = [
  { id: 's1', day: 1, name: 'Upper Strength + MetCon', duration: 55, finisher: 'core' as FinisherType, completed: true },
  { id: 's2', day: 2, name: 'Lower Body + Intervals', duration: 50, finisher: 'cardio' as FinisherType, completed: true },
  { id: 's3', day: 3, name: 'Gymnastics + AMRAP', duration: 60, finisher: 'core' as FinisherType, completed: false },
  { id: 's4', day: 4, name: 'Push/Pull + EMOM', duration: 55, finisher: 'cardio' as FinisherType, completed: false },
  { id: 's5', day: 5, name: 'Full Body + For Time', duration: 65, finisher: 'mixed' as FinisherType, completed: false },
  { id: 's6', day: 6, name: 'Active Recovery', duration: 30, finisher: 'none' as FinisherType, completed: false },
];

export default function WeekDetailScreen({ navigation, route }: Props) {
  const { weekNumber } = route.params;

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView showsVerticalScrollIndicator={false} contentContainerStyle={styles.scroll}>
        {/* Back Button */}
        <TouchableOpacity onPress={() => navigation.goBack()} style={styles.backButton}>
          <Ionicons name="arrow-back" size={24} color={Colors.text} />
          <Text style={styles.backText}>Program</Text>
        </TouchableOpacity>

        <Text style={styles.title}>Week {weekNumber}</Text>
        <Text style={styles.subtitle}>5 sessions + 1 recovery</Text>

        {MOCK_SESSIONS.map((session) => (
          <TouchableOpacity
            key={session.id}
            activeOpacity={0.7}
            onPress={() => navigation.navigate('Workout', { sessionId: session.id })}
          >
            <Card style={{ ...styles.sessionCard, ...(session.completed ? styles.sessionCompleted : {}) }}>
              <View style={styles.sessionRow}>
                <View style={styles.dayBadge}>
                  <Text style={styles.dayText}>D{session.day}</Text>
                </View>
                <View style={styles.sessionInfo}>
                  <Text style={styles.sessionName}>{session.name}</Text>
                  <View style={styles.sessionMeta}>
                    <Ionicons name="time-outline" size={12} color={Colors.textMuted} />
                    <Text style={styles.metaText}>{session.duration}min</Text>
                    <View style={styles.finisherBadge}>
                      <Text style={styles.finisherText}>
                        {FINISHER_LABELS[session.finisher]}
                      </Text>
                    </View>
                  </View>
                </View>
                {session.completed ? (
                  <Ionicons name="checkmark-circle" size={24} color={Colors.success} />
                ) : (
                  <Ionicons name="chevron-forward" size={20} color={Colors.textMuted} />
                )}
              </View>
            </Card>
          </TouchableOpacity>
        ))}
      </ScrollView>
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
    paddingBottom: Spacing.xxl,
  },
  backButton: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.sm,
    marginBottom: Spacing.md,
  },
  backText: {
    color: Colors.text,
    fontSize: FontSize.base,
  },
  title: {
    fontSize: FontSize.xxl,
    fontWeight: '800',
    color: Colors.text,
  },
  subtitle: {
    fontSize: FontSize.md,
    color: Colors.textSecondary,
    marginTop: 2,
    marginBottom: Spacing.lg,
  },
  sessionCard: {},
  sessionCompleted: {
    opacity: 0.6,
  },
  sessionRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.md,
  },
  dayBadge: {
    width: 40,
    height: 40,
    borderRadius: BorderRadius.sm,
    backgroundColor: Colors.surfaceLight,
    alignItems: 'center',
    justifyContent: 'center',
  },
  dayText: {
    color: Colors.primary,
    fontWeight: '800',
    fontSize: FontSize.sm,
  },
  sessionInfo: {
    flex: 1,
  },
  sessionName: {
    color: Colors.text,
    fontSize: FontSize.base,
    fontWeight: '600',
  },
  sessionMeta: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
    marginTop: 4,
  },
  metaText: {
    color: Colors.textMuted,
    fontSize: FontSize.xs,
    marginRight: Spacing.sm,
  },
  finisherBadge: {
    backgroundColor: Colors.surfaceLight,
    paddingHorizontal: 6,
    paddingVertical: 2,
    borderRadius: BorderRadius.sm,
  },
  finisherText: {
    color: Colors.textSecondary,
    fontSize: 10,
    fontWeight: '600',
  },
});
