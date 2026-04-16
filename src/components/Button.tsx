import React from 'react';
import { TouchableOpacity, Text, StyleSheet, ViewStyle, ActivityIndicator } from 'react-native';
import { Colors, Spacing, FontSize } from '../constants/theme';

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
  const isPrimary = variant === 'primary';
  const isGhost = variant === 'ghost';
  const bgColor = isPrimary ? Colors.white : isGhost ? 'transparent' : Colors.smoke;
  const textColor = isPrimary ? Colors.black : Colors.white;
  const height = size === 'sm' ? 36 : size === 'lg' ? 52 : 44;

  return (
    <TouchableOpacity
      onPress={onPress}
      disabled={disabled || loading}
      activeOpacity={0.8}
      style={[
        styles.button,
        {
          backgroundColor: disabled ? Colors.smoke : bgColor,
          height,
          borderWidth: isGhost ? 1 : 0,
          borderColor: Colors.line,
        },
        style,
      ]}
    >
      {loading ? (
        <ActivityIndicator color={textColor} />
      ) : (
        <Text
          style={[
            styles.text,
            { color: disabled ? Colors.textMuted : textColor },
          ]}
        >
          {title.toUpperCase()}
        </Text>
      )}
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  button: {
    alignItems: 'center',
    justifyContent: 'center',
    paddingHorizontal: Spacing.lg,
  },
  text: {
    fontFamily: 'monospace',
    fontWeight: '600',
    fontSize: FontSize.sm,
    letterSpacing: 1.5,
  },
});
