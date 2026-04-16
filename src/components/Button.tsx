import React from 'react';
import { TouchableOpacity, Text, StyleSheet, ViewStyle, ActivityIndicator } from 'react-native';
import { Colors, BorderRadius, Spacing, FontSize } from '../constants/theme';

interface ButtonProps {
  title: string;
  onPress: () => void;
  variant?: 'primary' | 'secondary' | 'ghost';
  size?: 'sm' | 'md' | 'lg';
  disabled?: boolean;
  loading?: boolean;
  style?: ViewStyle;
}

export default function Button({
  title,
  onPress,
  variant = 'primary',
  size = 'md',
  disabled = false,
  loading = false,
  style,
}: ButtonProps) {
  const bgColor =
    variant === 'primary'
      ? Colors.primary
      : variant === 'secondary'
        ? Colors.surfaceLight
        : 'transparent';

  const textColor = variant === 'ghost' ? Colors.primary : Colors.white;
  const height = size === 'sm' ? 36 : size === 'lg' ? 56 : 46;
  const fontSize = size === 'sm' ? FontSize.sm : size === 'lg' ? FontSize.lg : FontSize.base;

  return (
    <TouchableOpacity
      onPress={onPress}
      disabled={disabled || loading}
      activeOpacity={0.7}
      style={[
        styles.button,
        {
          backgroundColor: disabled ? Colors.surfaceLight : bgColor,
          height,
          borderWidth: variant === 'ghost' ? 1 : 0,
          borderColor: Colors.primary,
        },
        style,
      ]}
    >
      {loading ? (
        <ActivityIndicator color={textColor} />
      ) : (
        <Text style={[styles.text, { color: disabled ? Colors.textMuted : textColor, fontSize }]}>
          {title}
        </Text>
      )}
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  button: {
    borderRadius: BorderRadius.md,
    alignItems: 'center',
    justifyContent: 'center',
    paddingHorizontal: Spacing.lg,
  },
  text: {
    fontWeight: '700',
  },
});
