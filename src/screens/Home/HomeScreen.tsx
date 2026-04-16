// ============================================================
// El Coach — Home Screen
// ============================================================

import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { Colors, Spacing, FontSize, BorderRadius } from '../../constants/theme';
import Card from '../../components/Card';
import Button from '../../components/Button';
import { HomeStackParamList, UserClassification, AdaptiveScores } from '../../types';

type Props = {
  navigation: NativeStackNavigationProp<HomeStackParamList, 'Home'>;
};

// Mock data for initial development
const MOCK_TODAY = {
  sessionName: 'Day 3 — Strength & MetCon',
  weekNumber: 3,
  dayNumber: 3,
  sessionId: 'mock-session-1',
  blocks: ['Warm-up', 'Back Squat 5x3', 'AMRAP 12min', 'Core Finisher'],
};

const MOCK_SCORES: AdaptiveScores = {
  fatigue_score: 18,
  performance_score: 28,
  consistency_score: 16,
  total_score: 62,
  classification: 'stable',
  computed_at: new Date().toISOString(),
};

const CLASSIFICATION_CONFIG: Record<
  UserClassification,
  { color: string; icon: string; message: string }
> = {
  performer: {
    color: Colors.performer,
    icon: 'rocket',
    message: "You're on fire! Let's push harder today.",
  },
  stable: {
    color: Colors.stable,
    icon: 'thumbs-up',
    message: "Solid rhythm. Let's keep building.",
  },
  fatigued: {
    color: Colors.fatigued,
    icon: 'alert-circle',
    message: "We're scaling back today. Recovery matters.",
  },
  struggling: {
    color: Colors.struggling,
    icon: 'heart',
    message: "Let's take it easy. Showing up counts.",
  },
};

export default function HomeScreen({ navigation }: Props) {
  const [scores] = useState(MOCK_SCORES);
  const config = CLASSIFICATION_CONFIG[scores.classification];

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView showsVerticalScrollIndicator={false} contentContainerStyle={styles.scroll}>
        {/* Header */}
        <View style={styles.header}>
          <View>
            <Text style={styles.greeting}>Hello, Athlete</Text>
            <Text style={styles.subtitle}>Week {MOCK_TODAY.weekNumber} — Day {MOCK_TODAY.dayNumber}</Text>
          </View>
          <View style={[styles.statusBadge, { backgroundColor: config.color + '20' }]}>
            <Ionicons name={config.icon as any} size={16} color={config.color} />
            <Text style={[styles.statusText, { color: config.color }]}>
              {scores.classification}
            </Text>
          </View>
        </View>

        {/* Coach Message */}
        <Card style={{ ...styles.coachCard, borderLeftColor: config.color }}>
          <View style={styles.coachRow}>
            <Ionicons name="fitness" size={20} color={config.color} />
            <Text style={styles.coachMessage}>{config.message}</Text>
          </View>
        </Card>

        {/* Today's Workout */}
        <Text style={styles.sectionTitle}>Today's Workout</Text>
        <Card>
          <Text style={styles.sessionName}>{MOCK_TODAY.sessionName}</Text>
          <View style={styles.blockList}>
            {MOCK_TODAY.blocks.map((block, i) => (
              <View key={i} style={styles.blockItem}>
                <View style={[styles.blockDot, { backgroundColor: i === 0 ? Colors.primary : Colors.textMuted }]} />
                <Text style={styles.blockText}>{block}</Text>
              </View>
            ))}
          </View>
          <Button
            title="Start Workout"
            onPress={() => navigation.navigate('Workout', { sessionId: MOCK_TODAY.sessionId })}
            style={{ marginTop: Spacing.md }}
          />
        </Card>

        {/* Quick Stats */}
        <Text style={styles.sectionTitle}>Quick Stats</Text>
        <View style={styles.statsRow}>
          <Card style={styles.statCard}>
            <Ionicons name="flame" size={24} color={Colors.primary} />
            <Text style={styles.statValue}>{scores.fatigue_score}/40</Text>
            <Text style={styles.statLabel}>Fatigue</Text>
          </Card>
          <Card style={styles.statCard}>
            <Ionicons name="trending-up" size={24} color={Colors.success} />
            <Text style={styles.statValue}>{scores.performance_score}/40</Text>
            <Text style={styles.statLabel}>Performance</Text>
          </Card>
          <Card style={styles.statCard}>
            <Ionicons name="checkmark-circle" size={24} color={Colors.info} />
            <Text style={styles.statValue}>{scores.consistency_score}/20</Text>
            <Text style={styles.statLabel}>Consistency</Text>
          </Card>
        </View>

        {/* Last Session Summary */}
        <Text style={styles.sectionTitle}>Last Session</Text>
        <Card>
          <View style={styles.lastSessionRow}>
            <View>
              <Text style={styles.lastSessionTitle}>Day 2 — Upper Body</Text>
              <Text style={styles.lastSessionDate}>Yesterday</Text>
            </View>
            <View style={styles.completedBadge}>
              <Ionicons name="checkmark" size={14} color={Colors.success} />
              <Text style={styles.completedText}>Done</Text>
            </View>
          </View>
        </Card>
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
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: Spacing.lg,
  },
  greeting: {
    fontSize: FontSize.xxl,
    fontWeight: '800',
    color: Colors.text,
  },
  subtitle: {
    fontSize: FontSize.md,
    color: Colors.textSecondary,
    marginTop: 2,
  },
  statusBadge: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
    paddingHorizontal: Spacing.sm,
    paddingVertical: 4,
    borderRadius: BorderRadius.full,
  },
  statusText: {
    fontSize: FontSize.xs,
    fontWeight: '700',
    textTransform: 'uppercase',
  },
  coachCard: {
    borderLeftWidth: 3,
    marginBottom: Spacing.lg,
  },
  coachRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.sm,
  },
  coachMessage: {
    color: Colors.text,
    fontSize: FontSize.base,
    fontWeight: '500',
    flex: 1,
  },
  sectionTitle: {
    fontSize: FontSize.lg,
    fontWeight: '700',
    color: Colors.text,
    marginBottom: Spacing.sm,
  },
  sessionName: {
    fontSize: FontSize.lg,
    fontWeight: '700',
    color: Colors.text,
    marginBottom: Spacing.md,
  },
  blockList: {
    gap: Spacing.sm,
  },
  blockItem: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.sm,
  },
  blockDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
  },
  blockText: {
    color: Colors.textSecondary,
    fontSize: FontSize.md,
  },
  statsRow: {
    flexDirection: 'row',
    gap: Spacing.sm,
  },
  statCard: {
    flex: 1,
    alignItems: 'center',
    gap: 4,
  },
  statValue: {
    fontSize: FontSize.lg,
    fontWeight: '700',
    color: Colors.text,
  },
  statLabel: {
    fontSize: FontSize.xs,
    color: Colors.textMuted,
  },
  lastSessionRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  lastSessionTitle: {
    color: Colors.text,
    fontSize: FontSize.base,
    fontWeight: '600',
  },
  lastSessionDate: {
    color: Colors.textMuted,
    fontSize: FontSize.sm,
    marginTop: 2,
  },
  completedBadge: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
    backgroundColor: Colors.success + '20',
    paddingHorizontal: Spacing.sm,
    paddingVertical: 4,
    borderRadius: BorderRadius.full,
  },
  completedText: {
    color: Colors.success,
    fontSize: FontSize.xs,
    fontWeight: '600',
  },
});
