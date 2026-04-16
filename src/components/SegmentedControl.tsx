import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { Colors, Spacing, FontSize, BorderRadius } from '../constants/theme';

interface SegmentedControlProps<T extends string> {
  label: string;
  options: { value: T; label: string }[];
  selected: T;
  onChange: (value: T) => void;
}

export default function SegmentedControl<T extends string>({
  label,
  options,
  selected,
  onChange,
}: SegmentedControlProps<T>) {
  return (
    <View style={styles.container}>
      <Text style={styles.label}>{label}</Text>
      <View style={styles.row}>
        {options.map((opt) => (
          <TouchableOpacity
            key={opt.value}
            onPress={() => onChange(opt.value)}
            style={[styles.segment, opt.value === selected && styles.segmentActive]}
          >
            <Text style={[styles.segmentText, opt.value === selected && styles.segmentTextActive]}>
              {opt.label}
            </Text>
          </TouchableOpacity>
        ))}
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    marginBottom: Spacing.md,
  },
  label: {
    color: Colors.textSecondary,
    fontSize: FontSize.md,
    marginBottom: Spacing.sm,
  },
  row: {
    flexDirection: 'row',
    gap: Spacing.sm,
  },
  segment: {
    flex: 1,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.sm,
    backgroundColor: Colors.surfaceLight,
    alignItems: 'center',
  },
  segmentActive: {
    backgroundColor: Colors.primary,
  },
  segmentText: {
    color: Colors.textMuted,
    fontSize: FontSize.sm,
    fontWeight: '600',
  },
  segmentTextActive: {
    color: Colors.white,
  },
});
