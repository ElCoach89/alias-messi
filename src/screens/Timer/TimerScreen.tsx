// ============================================================
// El Coach — Timer Selection Screen
// ============================================================

import React, { useState } from 'react';
import { View, Text, StyleSheet, TextInput } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { Colors, Spacing, FontSize, BorderRadius } from '../../constants/theme';
import Card from '../../components/Card';
import Button from '../../components/Button';
import SegmentedControl from '../../components/SegmentedControl';
import { TimerStackParamList, TimerMode, TimerConfig } from '../../types';

type Props = {
  navigation: NativeStackNavigationProp<TimerStackParamList, 'TimerHome'>;
};

export default function TimerScreen({ navigation }: Props) {
  const [mode, setMode] = useState<TimerMode>('amrap');
  const [minutes, setMinutes] = useState('12');
  const [emomInterval, setEmomInterval] = useState('60');
  const [rounds, setRounds] = useState('10');

  function startTimer() {
    const config: TimerConfig = {
      mode,
      duration_seconds: parseInt(minutes, 10) * 60 || 720,
      emom_interval_seconds: mode === 'emom' ? parseInt(emomInterval, 10) || 60 : undefined,
      rounds: mode === 'emom' ? parseInt(rounds, 10) || 10 : undefined,
      countdown_seconds: 10,
    };
    navigation.navigate('TimerActive', { config });
  }

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.content}>
        <Text style={styles.title}>Timer</Text>

        <SegmentedControl
          label="Mode"
          options={[
            { value: 'amrap', label: 'AMRAP' },
            { value: 'emom', label: 'EMOM' },
            { value: 'for_time', label: 'For Time' },
          ]}
          selected={mode}
          onChange={setMode}
        />

        <Card>
          <View style={styles.configRow}>
            <Ionicons name="time-outline" size={20} color={Colors.primary} />
            <Text style={styles.configLabel}>
              {mode === 'for_time' ? 'Time Cap (min)' : 'Duration (min)'}
            </Text>
            <TextInput
              style={styles.configInput}
              keyboardType="numeric"
              value={minutes}
              onChangeText={setMinutes}
              placeholderTextColor={Colors.textMuted}
            />
          </View>

          {mode === 'emom' && (
            <>
              <View style={styles.configRow}>
                <Ionicons name="repeat" size={20} color={Colors.primary} />
                <Text style={styles.configLabel}>Interval (sec)</Text>
                <TextInput
                  style={styles.configInput}
                  keyboardType="numeric"
                  value={emomInterval}
                  onChangeText={setEmomInterval}
                  placeholderTextColor={Colors.textMuted}
                />
              </View>
              <View style={styles.configRow}>
                <Ionicons name="layers-outline" size={20} color={Colors.primary} />
                <Text style={styles.configLabel}>Rounds</Text>
                <TextInput
                  style={styles.configInput}
                  keyboardType="numeric"
                  value={rounds}
                  onChangeText={setRounds}
                  placeholderTextColor={Colors.textMuted}
                />
              </View>
            </>
          )}
        </Card>

        {/* Mode descriptions */}
        <Card style={styles.infoCard}>
          <Ionicons name="information-circle" size={18} color={Colors.info} />
          <Text style={styles.infoText}>
            {mode === 'amrap'
              ? 'As Many Rounds As Possible — complete as many rounds as you can before time runs out.'
              : mode === 'emom'
                ? 'Every Minute On the Minute — perform the prescribed reps at the start of each minute.'
                : 'For Time — complete the workout as fast as possible within the time cap.'}
          </Text>
        </Card>

        <Button title="Start Timer" onPress={startTimer} size="lg" />
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  content: {
    flex: 1,
    padding: Spacing.md,
  },
  title: {
    fontSize: FontSize.xxl,
    fontWeight: '800',
    color: Colors.text,
    marginBottom: Spacing.lg,
  },
  configRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.md,
    paddingVertical: Spacing.sm,
  },
  configLabel: {
    flex: 1,
    color: Colors.text,
    fontSize: FontSize.base,
  },
  configInput: {
    width: 70,
    backgroundColor: Colors.surfaceLight,
    borderRadius: BorderRadius.sm,
    color: Colors.text,
    padding: Spacing.sm,
    fontSize: FontSize.base,
    fontWeight: '700',
    textAlign: 'center',
  },
  infoCard: {
    flexDirection: 'row',
    gap: Spacing.sm,
    alignItems: 'flex-start',
    marginBottom: Spacing.lg,
  },
  infoText: {
    flex: 1,
    color: Colors.textSecondary,
    fontSize: FontSize.sm,
    lineHeight: 20,
  },
});
