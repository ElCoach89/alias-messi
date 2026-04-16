import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { Colors, Spacing, FontSize } from '../constants/theme';

interface FeedbackSliderProps {
  label: string;
  value: number;
  min?: number;
  max?: number;
  onChange: (value: number) => void;
}

export default function FeedbackSlider({
  label,
  value,
  min = 1,
  max = 10,
  onChange,
}: FeedbackSliderProps) {
  const values = Array.from({ length: max - min + 1 }, (_, i) => min + i);

  return (
    <View style={styles.container}>
      <Text style={styles.label}>
        {label.toUpperCase()}  <Text style={styles.value}>{value}</Text>
      </Text>
      <View style={styles.row}>
        {values.map((v) => (
          <TouchableOpacity
            key={v}
            onPress={() => onChange(v)}
            style={[styles.dot, v === value && styles.dotActive]}
          >
            <Text style={[styles.dotText, v === value && styles.dotTextActive]}>{v}</Text>
          </TouchableOpacity>
        ))}
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    marginBottom: Spacing.lg,
  },
  label: {
    fontFamily: 'monospace',
    color: Colors.mute,
    fontSize: FontSize.xs,
    letterSpacing: 2,
    marginBottom: Spacing.sm,
  },
  value: {
    color: Colors.white,
    fontWeight: '700',
  },
  row: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  dot: {
    width: 30,
    height: 30,
    borderWidth: 1,
    borderColor: Colors.line,
    backgroundColor: Colors.ash,
    alignItems: 'center',
    justifyContent: 'center',
  },
  dotActive: {
    backgroundColor: Colors.white,
    borderColor: Colors.white,
  },
  dotText: {
    color: Colors.textMuted,
    fontSize: FontSize.xs,
    fontFamily: 'monospace',
    fontWeight: '600',
  },
  dotTextActive: {
    color: Colors.black,
  },
});
