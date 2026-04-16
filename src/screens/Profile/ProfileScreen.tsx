// ============================================================
// El Coach — Profile Screen
// ============================================================

import React, { useState } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { Colors, Spacing, FontSize, BorderRadius } from '../../constants/theme';
import Card from '../../components/Card';

// Mock profile
const MOCK_PROFILE = {
  displayName: 'Athlete',
  email: 'athlete@elcoach.app',
  fitnessLevel: 'Intermediate',
  goal: 'Performance',
  bodyWeight: 78,
  subscription: 'Base Plan',
  modules: ['CrossFit'],
  memberSince: 'March 2026',
};

const MOCK_1RM = [
  { exercise: 'Back Squat', weight: 110 },
  { exercise: 'Deadlift', weight: 140 },
  { exercise: 'Clean & Jerk', weight: 85 },
  { exercise: 'Snatch', weight: 67.5 },
  { exercise: 'Bench Press', weight: 90 },
  { exercise: 'Overhead Press', weight: 60 },
];

interface MenuItemProps {
  icon: string;
  label: string;
  value?: string;
  onPress?: () => void;
}

function MenuItem({ icon, label, value, onPress }: MenuItemProps) {
  return (
    <TouchableOpacity style={styles.menuItem} onPress={onPress} activeOpacity={0.7}>
      <View style={styles.menuLeft}>
        <Ionicons name={icon as any} size={20} color={Colors.primary} />
        <Text style={styles.menuLabel}>{label}</Text>
      </View>
      <View style={styles.menuRight}>
        {value && <Text style={styles.menuValue}>{value}</Text>}
        <Ionicons name="chevron-forward" size={16} color={Colors.textMuted} />
      </View>
    </TouchableOpacity>
  );
}

export default function ProfileScreen() {
  return (
    <SafeAreaView style={styles.container}>
      <ScrollView showsVerticalScrollIndicator={false} contentContainerStyle={styles.scroll}>
        <Text style={styles.title}>Profile</Text>

        {/* Avatar & Name */}
        <View style={styles.avatarSection}>
          <View style={styles.avatar}>
            <Ionicons name="person" size={40} color={Colors.textMuted} />
          </View>
          <Text style={styles.name}>{MOCK_PROFILE.displayName}</Text>
          <Text style={styles.email}>{MOCK_PROFILE.email}</Text>
          <View style={styles.badgeRow}>
            <View style={styles.levelBadge}>
              <Text style={styles.levelText}>{MOCK_PROFILE.fitnessLevel}</Text>
            </View>
            <View style={styles.goalBadge}>
              <Text style={styles.goalText}>{MOCK_PROFILE.goal}</Text>
            </View>
          </View>
        </View>

        {/* Info Section */}
        <Card>
          <MenuItem icon="body" label="Body Weight" value={`${MOCK_PROFILE.bodyWeight} kg`} />
          <MenuItem icon="fitness" label="Fitness Level" value={MOCK_PROFILE.fitnessLevel} />
          <MenuItem icon="flag" label="Goal" value={MOCK_PROFILE.goal} />
          <MenuItem icon="card" label="Subscription" value={MOCK_PROFILE.subscription} />
          <MenuItem
            icon="grid"
            label="Active Modules"
            value={MOCK_PROFILE.modules.join(', ')}
          />
        </Card>

        {/* 1RM Records */}
        <Text style={styles.sectionTitle}>1RM Records</Text>
        <Card>
          {MOCK_1RM.map((item, i) => (
            <View key={i} style={[styles.rmRow, i < MOCK_1RM.length - 1 && styles.rmBorder]}>
              <Text style={styles.rmExercise}>{item.exercise}</Text>
              <Text style={styles.rmWeight}>{item.weight} kg</Text>
            </View>
          ))}
        </Card>

        {/* Settings */}
        <Text style={styles.sectionTitle}>Settings</Text>
        <Card>
          <MenuItem icon="notifications-outline" label="Notifications" />
          <MenuItem icon="moon-outline" label="Dark Mode" value="On" />
          <MenuItem icon="language-outline" label="Language" value="English" />
          <MenuItem icon="log-out-outline" label="Sign Out" />
        </Card>

        <Text style={styles.memberSince}>Member since {MOCK_PROFILE.memberSince}</Text>
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
    marginBottom: Spacing.lg,
  },
  avatarSection: {
    alignItems: 'center',
    marginBottom: Spacing.lg,
  },
  avatar: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: Colors.surfaceLight,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: Spacing.sm,
  },
  name: {
    fontSize: FontSize.xl,
    fontWeight: '700',
    color: Colors.text,
  },
  email: {
    fontSize: FontSize.sm,
    color: Colors.textMuted,
    marginTop: 2,
  },
  badgeRow: {
    flexDirection: 'row',
    gap: Spacing.sm,
    marginTop: Spacing.sm,
  },
  levelBadge: {
    backgroundColor: Colors.primary + '20',
    paddingHorizontal: Spacing.sm,
    paddingVertical: 4,
    borderRadius: BorderRadius.full,
  },
  levelText: {
    color: Colors.primary,
    fontSize: FontSize.xs,
    fontWeight: '700',
  },
  goalBadge: {
    backgroundColor: Colors.info + '20',
    paddingHorizontal: Spacing.sm,
    paddingVertical: 4,
    borderRadius: BorderRadius.full,
  },
  goalText: {
    color: Colors.info,
    fontSize: FontSize.xs,
    fontWeight: '700',
  },
  menuItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: Spacing.sm + 2,
  },
  menuLeft: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.md,
  },
  menuLabel: {
    color: Colors.text,
    fontSize: FontSize.base,
  },
  menuRight: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.xs,
  },
  menuValue: {
    color: Colors.textMuted,
    fontSize: FontSize.sm,
  },
  sectionTitle: {
    fontSize: FontSize.lg,
    fontWeight: '700',
    color: Colors.text,
    marginTop: Spacing.md,
    marginBottom: Spacing.sm,
  },
  rmRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingVertical: Spacing.sm,
  },
  rmBorder: {
    borderBottomWidth: 0.5,
    borderBottomColor: Colors.border,
  },
  rmExercise: {
    color: Colors.text,
    fontSize: FontSize.base,
  },
  rmWeight: {
    color: Colors.primary,
    fontSize: FontSize.base,
    fontWeight: '700',
  },
  memberSince: {
    color: Colors.textMuted,
    fontSize: FontSize.xs,
    textAlign: 'center',
    marginTop: Spacing.lg,
  },
});
