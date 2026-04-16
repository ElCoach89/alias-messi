import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { Colors, Spacing, FontSize } from '../constants/theme';

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
      <Text style={styles.label}>{label.toUpperCase()}</Text>
      <View style={styles.row}>
        {options.map((opt) => (
          <TouchableOpacity
            key={opt.value}
            onPress={() => onChange(opt.value)}
            style={[styles.segment, opt.value === selected && styles.segmentActive]}
          >
            <Text style={[styles.segmentText, opt.value === selected && styles.segmentTextActive]}>
              {opt.label.toUpperCase()}
            </Text>
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
  row: {
    flexDirection: 'row',
    gap: 1, // hairline gap
  },
  segment: {
    flex: 1,
    paddingVertical: Spacing.sm + 2,
    backgroundColor: Colors.ash,
    borderWidth: 1,
    borderColor: Colors.line,
    alignItems: 'center',
  },
  segmentActive: {
    backgroundColor: Colors.white,
    borderColor: Colors.white,
  },
  segmentText: {
    color: Colors.mute,
    fontSize: FontSize.xs,
    fontFamily: 'monospace',
    fontWeight: '600',
    letterSpacing: 1,
  },
  segmentTextActive: {
    color: Colors.black,
  },
});
