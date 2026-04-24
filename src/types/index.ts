// ============================================================
// El Coach — Core Type Definitions
// ============================================================

// --- User & Profile ---

export type TrainingModule = 'crossfit' | 'hyrox' | 'strength' | 'home' | 'hybrid';
export type CooldownActivity = 'walk' | 'run' | 'boxe' | 'swim' | 'rest_complete';
export type SubscriptionTier = 'free_trial' | 'base' | 'premium';
export type UserClassification = 'performer' | 'stable' | 'fatigued' | 'struggling';

export interface UserProfile {
  id: string;
  email: string;
  display_name: string;
  avatar_url?: string;
  date_of_birth?: string;
  gender?: 'male' | 'female' | 'other';
  body_weight_kg?: number;
  height_cm?: number;
  fitness_level: 'beginner' | 'intermediate' | 'advanced';
  goal: 'performance' | 'weight_loss' | 'general_fitness' | 'muscle_gain';
  active_modules: TrainingModule[];
  subscription_tier: SubscriptionTier;
  trial_expires_at?: string;
  created_at: string;
  updated_at: string;
}

// --- 1RM Records ---

export interface OneRepMax {
  id: string;
  user_id: string;
  exercise_name: string;
  weight_kg: number;
  recorded_at: string;
}

// --- Program & Sessions ---

export interface Program {
  id: string;
  module: TrainingModule;
  name: string;
  description: string;
  duration_weeks: number;
  level: 'beginner' | 'intermediate' | 'advanced';
  created_at: string;
}

export interface ProgramWeek {
  id: string;
  program_id: string;
  week_number: number;
  theme: string;
  intensity_modifier: number; // 0.8 to 1.2
}

export type SessionType = 'crossfit' | 'hyrox' | 'strength' | 'home' | 'mixed' | 'hybrid' | 'cooldown';
export type FinisherType = 'core' | 'cardio' | 'mixed' | 'none';

export interface Session {
  id: string;
  week_id: string;
  day_number: number; // 1-7 (day 7 = adaptive cooldown for Hybride)
  session_type: SessionType;
  name: string;
  description?: string;
  estimated_duration_min: number;
  finisher_type: FinisherType;
  is_adaptive_cooldown?: boolean;
  default_cooldown_activity?: CooldownActivity;
}

// --- Workout Blocks ---

export type BlockType = 'warmup' | 'strength' | 'skill' | 'wod' | 'finisher' | 'cooldown';
export type WodFormat = 'amrap' | 'emom' | 'for_time' | 'tabata';

export interface WorkoutBlock {
  id: string;
  session_id: string;
  block_type: BlockType;
  order_index: number;
  name: string;
  instructions: string;
  wod_format?: WodFormat;
  time_cap_seconds?: number;
  target_rounds?: number;
  exercises: BlockExercise[];
}

export interface BlockExercise {
  id: string;
  block_id: string;
  exercise_id?: string; // optional FK to exercises reference table
  exercise_name: string;
  sets?: number;
  reps?: number | string; // "max" or number
  weight_percentage?: number; // percentage of 1RM
  rest_seconds?: number;
  order_index: number;
  notes?: string;
}

// --- Exercises Reference ---

export type ExerciseCategory = 'monostructural' | 'weightlifting' | 'gymnastics' | 'odd_object' | 'accessory';
export type ScoringUnit = 'reps' | 'time_s' | 'distance_m' | 'calories' | 'weight_kg';

export interface Exercise {
  id: string;
  slug: string;
  name: string;
  category: ExerciseCategory;
  subcategory: string;
  equipment: string[];
  modules: TrainingModule[];
  is_unilateral: boolean;
  is_bodyweight: boolean;
  scoring_unit?: ScoringUnit;
  notes?: string;
  created_at: string;
}

// --- Weekly Fatigue Snapshots (feeds adaptive cooldown) ---

export interface WeeklyFatigueSnapshot {
  user_id: string;
  iso_year: number;
  iso_week: number;
  avg_fatigue_score: number;
  avg_performance_score: number;
  sessions_completed: number;
  suggested_cooldown: CooldownActivity;
  computed_at: string;
}

// --- Workout Logs ---

export interface WorkoutLog {
  id: string;
  user_id: string;
  session_id: string;
  program_week_id: string;
  started_at: string;
  completed_at?: string;
  status: 'in_progress' | 'completed' | 'skipped';
}

export interface ExerciseLog {
  id: string;
  workout_log_id: string;
  block_exercise_id: string;
  exercise_name: string;
  set_number: number;
  reps_completed: number;
  weight_kg?: number;
  rpe?: number; // 1-10
  notes?: string;
}

export interface WodLog {
  id: string;
  workout_log_id: string;
  block_id: string;
  wod_format: WodFormat;
  score: number; // rounds for AMRAP, time in seconds for ForTime
  score_detail?: string; // e.g. "12 rounds + 5 reps"
  rx: boolean;
}

// --- Feedback ---

export type FeelingLevel = 'easy' | 'ok' | 'hard';
export type EnergyLevel = 'tired' | 'normal' | 'good';
export type ExhaustionLevel = 'fresh' | 'tired' | 'exhausted';

export interface SessionFeedback {
  id: string;
  workout_log_id: string;
  user_id: string;
  session_id: string;
  warmup_feeling: EnergyLevel;
  strength_difficulty: FeelingLevel;
  strength_rpe: number; // 1-10
  wod_feeling: ExhaustionLevel;
  finisher_feeling: ExhaustionLevel;
  global_fatigue: number; // 1-10
  motivation: number; // 1-10
  notes?: string;
  created_at: string;
}

// --- Adaptive Engine ---

export interface AdaptiveScores {
  fatigue_score: number; // 0-40
  performance_score: number; // 0-40
  consistency_score: number; // 0-20
  total_score: number; // 0-100
  classification: UserClassification;
  computed_at: string;
}

export interface AdaptiveAdjustment {
  weight_modifier: number; // e.g. 0.9 = -10%, 1.05 = +5%
  volume_modifier: number; // affects reps/sets
  duration_modifier: number; // affects time caps
  finisher_intensity: 'reduced' | 'normal' | 'increased';
  coach_message: string;
}

// --- Timer ---

export type TimerMode = 'amrap' | 'emom' | 'for_time';

export interface TimerConfig {
  mode: TimerMode;
  duration_seconds: number;
  emom_interval_seconds?: number;
  rounds?: number;
  countdown_seconds?: number;
}

// --- Navigation ---

export type RootTabParamList = {
  HomeTab: undefined;
  ProgramTab: undefined;
  TimerTab: undefined;
  ProgressTab: undefined;
  ProfileTab: undefined;
};

export type HomeStackParamList = {
  Home: undefined;
  Workout: { sessionId: string; workoutLogId?: string };
};

export type ProgramStackParamList = {
  ProgramOverview: undefined;
  WeekDetail: { weekId: string; weekNumber: number };
  Workout: { sessionId: string; workoutLogId?: string };
};

export type TimerStackParamList = {
  TimerHome: undefined;
  TimerActive: { config: TimerConfig };
};

export type ProgressStackParamList = {
  ProgressHome: undefined;
  ExerciseDetail: { exerciseName: string };
};

export type ProfileStackParamList = {
  ProfileHome: undefined;
  EditProfile: undefined;
  OneRepMaxes: undefined;
  Settings: undefined;
};
