// ============================================================
// El Coach — Design System
// Aligne sur le design web (dark brutalist/minimal)
// ============================================================

export const Colors = {
  // Core palette
  ink: '#000000',
  paper: '#ffffff',
  ash: '#0a0a0a',
  smoke: '#161616',
  line: '#1f1f1f',
  mute: '#8a8a8a',

  // Semantic
  primary: '#ffffff',
  primaryDark: '#e0e0e0',
  primaryLight: '#ffffff',

  // Backgrounds
  background: '#000000',
  surface: '#0a0a0a',
  surfaceLight: '#161616',
  card: '#0a0a0a',

  // Text
  text: '#ffffff',
  textSecondary: '#8a8a8a',
  textMuted: '#555555',

  // Status
  success: '#22c55e',
  warning: '#eab308',
  error: '#ef4444',
  info: '#8a8a8a',

  // Classification
  performer: '#22c55e',
  stable: '#ffffff',
  fatigued: '#eab308',
  struggling: '#ef4444',

  // Misc
  border: '#1f1f1f',
  overlay: 'rgba(0,0,0,0.8)',
  white: '#ffffff',
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
  sm: 11,
  md: 13,
  base: 15,
  lg: 18,
  xl: 22,
  xxl: 28,
  hero: 36,
} as const;

export const BorderRadius = {
  sm: 0,
  md: 0,
  lg: 0,
  xl: 0,
  full: 9999,
} as const;
