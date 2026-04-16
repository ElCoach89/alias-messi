// ============================================================
// El Coach — Design System
// ============================================================

export const Colors = {
  // Primary
  primary: '#FF6B35',
  primaryDark: '#E85A2A',
  primaryLight: '#FF8A5C',

  // Backgrounds
  background: '#0D0D0D',
  surface: '#1A1A1A',
  surfaceLight: '#2A2A2A',
  card: '#1E1E1E',

  // Text
  text: '#FFFFFF',
  textSecondary: '#A0A0A0',
  textMuted: '#666666',

  // Accent
  success: '#4CAF50',
  warning: '#FFC107',
  error: '#F44336',
  info: '#2196F3',

  // Classification colors
  performer: '#4CAF50',
  stable: '#2196F3',
  fatigued: '#FFC107',
  struggling: '#F44336',

  // Misc
  border: '#333333',
  overlay: 'rgba(0,0,0,0.7)',
  white: '#FFFFFF',
  black: '#000000',
} as const;

export const Spacing = {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32,
  xxl: 48,
} as const;

export const FontSize = {
  xs: 10,
  sm: 12,
  md: 14,
  base: 16,
  lg: 18,
  xl: 22,
  xxl: 28,
  hero: 36,
} as const;

export const BorderRadius = {
  sm: 6,
  md: 12,
  lg: 16,
  xl: 24,
  full: 9999,
} as const;
