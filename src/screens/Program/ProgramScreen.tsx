// ============================================================
// El Coach — Program Screen (6-Week Cycle Overview)
// ============================================================

import React, { useState } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { Colors, Spacing, FontSize, BorderRadius } from '../../constants/theme';
import Card from '../../components/Card';
import { ProgramStackParamList } from '../../types';

type Props = {
  navigation: NativeStackNavigationProp<ProgramStackParamList, 'ProgramOverview'>;
};

// Mock 6-week program
const WEEKS = Array.from({ length: 6 }, (_, i) => ({
  id: `week-${i + 1}`,
  number: i + 1,
  theme: ['Foundation', 'Build', 'Intensity', 'Peak', 'Deload', 'Test'][i],
  intensity: [0.85, 0.9, 0.95, 1.0, 0.8, 1.05][i],
  completed: i < 2,
  current: i === 2,
}));

export default function ProgramScreen({ navigation }: Props) {
  const [activeModule] = useState<string>('CrossFit');

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView showsVerticalScrollIndicator={false} contentContainerStyle={styles.scroll}>
        <Text style={styles.title}>Program</Text>
        <Text style={styles.subtitle}>{activeModule} — 6 Week Cycle</Text>

        {/* Progress Bar */}
        <View style={styles.progressContainer}>
          <View style={styles.progressBar}>
            <View style={[styles.progressFill, { width: `${(2 / 6) * 100}%` }]} />
          </View>
          <Text style={styles.progressText}>Week 3 of 6</Text>
        </View>

        {/* Weeks */}
        {WEEKS.map((week) => (
          <TouchableOpacity
            key={week.id}
            activeOpacity={0.7}
            onPress={() =>
              navigation.navigate('WeekDetail', {
                weekId: week.id,
                weekNumber: week.number,
              })
            }
          >
            <Card
              style={{
                ...styles.weekCard,
                ...(week.current ? styles.weekCardCurrent : {}),
                ...(week.completed ? styles.weekCardCompleted : {}),
              }}
            >
              <View style={styles.weekHeader}>
                <View style={styles.weekLeft}>
                  <View
                    style={[
                      styles.weekBadge,
                      {
                        backgroundColor: week.completed
                          ? Colors.success
                          : week.current
                            ? Colors.primary
                            : Colors.surfaceLight,
                      },
                    ]}
                  >
                    {week.completed ? (
                      <Ionicons name="checkmark" size={16} color={Colors.white} />
                    ) : (
                      <Text style={styles.weekBadgeText}>{week.number}</Text>
                    )}
                  </View>
                  <View>
                    <Text style={styles.weekTitle}>Week {week.number}</Text>
                    <Text style={styles.weekTheme}>{week.theme}</Text>
                  </View>
                </View>
                <View style={styles.weekRight}>
                  <Text style={styles.intensityLabel}>
                    {Math.round(week.intensity * 100)}%
                  </Text>
                  <Ionicons name="chevron-forward" size={18} color={Colors.textMuted} />
                </View>
              </View>
              {week.current && (
                <View style={styles.currentTag}>
                  <Text style={styles.currentTagText}>CURRENT</Text>
                </View>
              )}
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
  progressContainer: {
    marginBottom: Spacing.lg,
  },
  progressBar: {
    height: 6,
    backgroundColor: Colors.surfaceLight,
    borderRadius: 3,
    overflow: 'hidden',
  },
  progressFill: {
    height: '100%',
    backgroundColor: Colors.primary,
    borderRadius: 3,
  },
  progressText: {
    color: Colors.textMuted,
    fontSize: FontSize.xs,
    marginTop: 4,
    textAlign: 'right',
  },
  weekCard: {
    position: 'relative',
    overflow: 'hidden',
  },
  weekCardCurrent: {
    borderColor: Colors.primary,
    borderWidth: 1,
  },
  weekCardCompleted: {
    opacity: 0.7,
  },
  weekHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  weekLeft: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.md,
  },
  weekBadge: {
    width: 36,
    height: 36,
    borderRadius: 18,
    alignItems: 'center',
    justifyContent: 'center',
  },
  weekBadgeText: {
    color: Colors.text,
    fontWeight: '700',
    fontSize: FontSize.base,
  },
  weekTitle: {
    color: Colors.text,
    fontSize: FontSize.base,
    fontWeight: '700',
  },
  weekTheme: {
    color: Colors.textSecondary,
    fontSize: FontSize.sm,
  },
  weekRight: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.sm,
  },
  intensityLabel: {
    color: Colors.textMuted,
    fontSize: FontSize.sm,
    fontWeight: '600',
  },
  currentTag: {
    position: 'absolute',
    top: 0,
    right: 0,
    backgroundColor: Colors.primary,
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderBottomLeftRadius: BorderRadius.sm,
  },
  currentTagText: {
    color: Colors.white,
    fontSize: 9,
    fontWeight: '800',
    letterSpacing: 1,
  },
});
