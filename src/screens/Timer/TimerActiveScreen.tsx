// ============================================================
// El Coach — Active Timer Screen
// ============================================================

import React, { useState, useEffect, useRef, useCallback } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, Vibration } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { RouteProp } from '@react-navigation/native';
import { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { Colors, Spacing, FontSize, BorderRadius } from '../../constants/theme';
import { TimerStackParamList } from '../../types';

type Props = {
  navigation: NativeStackNavigationProp<TimerStackParamList, 'TimerActive'>;
  route: RouteProp<TimerStackParamList, 'TimerActive'>;
};

function formatTime(seconds: number): string {
  const mins = Math.floor(seconds / 60);
  const secs = seconds % 60;
  return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
}

export default function TimerActiveScreen({ navigation, route }: Props) {
  const { config } = route.params;
  const { mode, duration_seconds, emom_interval_seconds, countdown_seconds = 10 } = config;

  const [phase, setPhase] = useState<'countdown' | 'active' | 'done'>('countdown');
  const [countdownValue, setCountdownValue] = useState(countdown_seconds);
  const [elapsed, setElapsed] = useState(0);
  const [isPaused, setIsPaused] = useState(false);
  const [currentRound, setCurrentRound] = useState(1);

  const intervalRef = useRef<ReturnType<typeof setInterval> | null>(null);

  const remaining = duration_seconds - elapsed;
  const emomIntervalRemaining = emom_interval_seconds
    ? emom_interval_seconds - (elapsed % emom_interval_seconds)
    : 0;

  const clearTimer = useCallback(() => {
    if (intervalRef.current) {
      clearInterval(intervalRef.current);
      intervalRef.current = null;
    }
  }, []);

  // Countdown phase
  useEffect(() => {
    if (phase !== 'countdown') return;

    intervalRef.current = setInterval(() => {
      setCountdownValue((prev) => {
        if (prev <= 1) {
          setPhase('active');
          return 0;
        }
        if (prev <= 4) Vibration.vibrate(50);
        return prev - 1;
      });
    }, 1000);

    return clearTimer;
  }, [phase, clearTimer]);

  // Active phase
  useEffect(() => {
    if (phase !== 'active' || isPaused) return;

    intervalRef.current = setInterval(() => {
      setElapsed((prev) => {
        const next = prev + 1;

        // EMOM round change
        if (mode === 'emom' && emom_interval_seconds && next % emom_interval_seconds === 0) {
          setCurrentRound((r) => r + 1);
          Vibration.vibrate(200);
        }

        // Time's up
        if (next >= duration_seconds) {
          setPhase('done');
          Vibration.vibrate([0, 500, 200, 500]);
          return duration_seconds;
        }

        // Warning beeps at 3, 2, 1
        if (duration_seconds - next <= 3) {
          Vibration.vibrate(100);
        }

        return next;
      });
    }, 1000);

    return clearTimer;
  }, [phase, isPaused, mode, duration_seconds, emom_interval_seconds, clearTimer]);

  function togglePause() {
    setIsPaused((p) => !p);
  }

  function reset() {
    clearTimer();
    setPhase('countdown');
    setCountdownValue(countdown_seconds);
    setElapsed(0);
    setIsPaused(false);
    setCurrentRound(1);
  }

  // --- Render ---

  if (phase === 'countdown') {
    return (
      <SafeAreaView style={styles.container}>
        <View style={styles.center}>
          <Text style={styles.countdownLabel}>GET READY</Text>
          <Text style={styles.countdownNumber}>{countdownValue}</Text>
          <Text style={styles.modeLabel}>{mode.toUpperCase().replace('_', ' ')}</Text>
        </View>
      </SafeAreaView>
    );
  }

  if (phase === 'done') {
    return (
      <SafeAreaView style={styles.container}>
        <View style={styles.center}>
          <Ionicons name="checkmark-circle" size={80} color={Colors.success} />
          <Text style={styles.doneTitle}>TIME!</Text>
          <Text style={styles.doneTime}>{formatTime(elapsed)}</Text>
          {mode === 'emom' && (
            <Text style={styles.roundsCompleted}>{currentRound - 1} rounds completed</Text>
          )}
          <View style={styles.doneActions}>
            <TouchableOpacity onPress={reset} style={styles.actionButton}>
              <Ionicons name="refresh" size={24} color={Colors.text} />
              <Text style={styles.actionText}>Again</Text>
            </TouchableOpacity>
            <TouchableOpacity onPress={() => navigation.goBack()} style={styles.actionButton}>
              <Ionicons name="close" size={24} color={Colors.text} />
              <Text style={styles.actionText}>Exit</Text>
            </TouchableOpacity>
          </View>
        </View>
      </SafeAreaView>
    );
  }

  // Active phase
  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.activeContainer}>
        {/* Mode badge */}
        <View style={styles.modeBadge}>
          <Text style={styles.modeBadgeText}>{mode.toUpperCase().replace('_', ' ')}</Text>
        </View>

        {/* Main timer */}
        <Text style={styles.timerText}>
          {mode === 'for_time' ? formatTime(elapsed) : formatTime(remaining)}
        </Text>

        {/* EMOM interval */}
        {mode === 'emom' && (
          <View style={styles.emomInfo}>
            <Text style={styles.roundLabel}>Round {currentRound}</Text>
            <Text style={styles.intervalTime}>{formatTime(emomIntervalRemaining)}</Text>
          </View>
        )}

        {/* Progress bar */}
        <View style={styles.progressBar}>
          <View
            style={[
              styles.progressFill,
              { width: `${Math.min(100, (elapsed / duration_seconds) * 100)}%` },
            ]}
          />
        </View>

        {/* Controls */}
        <View style={styles.controls}>
          <TouchableOpacity onPress={reset} style={styles.controlButton}>
            <Ionicons name="refresh" size={28} color={Colors.textSecondary} />
          </TouchableOpacity>
          <TouchableOpacity onPress={togglePause} style={styles.pauseButton}>
            <Ionicons
              name={isPaused ? 'play' : 'pause'}
              size={36}
              color={Colors.white}
            />
          </TouchableOpacity>
          <TouchableOpacity onPress={() => navigation.goBack()} style={styles.controlButton}>
            <Ionicons name="stop" size={28} color={Colors.textSecondary} />
          </TouchableOpacity>
        </View>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  center: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: Spacing.md,
  },
  // Countdown
  countdownLabel: {
    fontSize: FontSize.lg,
    fontWeight: '700',
    color: Colors.textSecondary,
    letterSpacing: 4,
    marginBottom: Spacing.md,
  },
  countdownNumber: {
    fontSize: 120,
    fontWeight: '800',
    color: Colors.primary,
  },
  modeLabel: {
    fontSize: FontSize.lg,
    color: Colors.textMuted,
    fontWeight: '600',
    marginTop: Spacing.md,
    letterSpacing: 2,
  },
  // Done
  doneTitle: {
    fontSize: FontSize.hero,
    fontWeight: '800',
    color: Colors.text,
    marginTop: Spacing.md,
  },
  doneTime: {
    fontSize: FontSize.xxl,
    color: Colors.textSecondary,
    fontWeight: '600',
    marginTop: Spacing.sm,
  },
  roundsCompleted: {
    fontSize: FontSize.base,
    color: Colors.textMuted,
    marginTop: Spacing.sm,
  },
  doneActions: {
    flexDirection: 'row',
    gap: Spacing.xl,
    marginTop: Spacing.xxl,
  },
  actionButton: {
    alignItems: 'center',
    gap: Spacing.xs,
  },
  actionText: {
    color: Colors.text,
    fontSize: FontSize.sm,
  },
  // Active
  activeContainer: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: Spacing.md,
  },
  modeBadge: {
    backgroundColor: Colors.primary + '20',
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.full,
    marginBottom: Spacing.lg,
  },
  modeBadgeText: {
    color: Colors.primary,
    fontWeight: '800',
    fontSize: FontSize.sm,
    letterSpacing: 2,
  },
  timerText: {
    fontSize: 80,
    fontWeight: '800',
    color: Colors.text,
    fontVariant: ['tabular-nums'],
  },
  emomInfo: {
    alignItems: 'center',
    marginTop: Spacing.md,
  },
  roundLabel: {
    fontSize: FontSize.lg,
    color: Colors.primary,
    fontWeight: '700',
  },
  intervalTime: {
    fontSize: FontSize.xxl,
    color: Colors.textSecondary,
    fontWeight: '600',
    fontVariant: ['tabular-nums'],
  },
  progressBar: {
    width: '80%',
    height: 4,
    backgroundColor: Colors.surfaceLight,
    borderRadius: 2,
    marginTop: Spacing.xl,
    overflow: 'hidden',
  },
  progressFill: {
    height: '100%',
    backgroundColor: Colors.primary,
    borderRadius: 2,
  },
  controls: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.xl,
    marginTop: Spacing.xxl,
  },
  controlButton: {
    width: 56,
    height: 56,
    borderRadius: 28,
    backgroundColor: Colors.surfaceLight,
    alignItems: 'center',
    justifyContent: 'center',
  },
  pauseButton: {
    width: 72,
    height: 72,
    borderRadius: 36,
    backgroundColor: Colors.primary,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
