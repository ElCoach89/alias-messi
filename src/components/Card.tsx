import React from 'react';
import { View, StyleSheet, ViewStyle } from 'react-native';
import { Colors, Spacing } from '../constants/theme';

interface CardProps {
  children: React.ReactNode;
  style?: ViewStyle;
}

export default function Card({ children, style }: CardProps) {
  return <View style={[styles.card, style]}>{children}</View>;
}

const styles = StyleSheet.create({
  card: {
    backgroundColor: Colors.ash,
    borderWidth: 1,
    borderColor: Colors.line,
    padding: Spacing.md,
    marginBottom: Spacing.md,
  },
});
