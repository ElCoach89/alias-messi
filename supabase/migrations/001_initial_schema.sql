-- ============================================================
-- El Coach — Database Schema
-- ============================================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- -----------------------------------------------------------
-- USERS & PROFILES
-- -----------------------------------------------------------

CREATE TABLE user_profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL,
  display_name TEXT NOT NULL DEFAULT '',
  avatar_url TEXT,
  date_of_birth DATE,
  gender TEXT CHECK (gender IN ('male', 'female', 'other')),
  body_weight_kg NUMERIC(5,1),
  height_cm NUMERIC(5,1),
  fitness_level TEXT NOT NULL DEFAULT 'beginner' CHECK (fitness_level IN ('beginner', 'intermediate', 'advanced')),
  goal TEXT NOT NULL DEFAULT 'general_fitness' CHECK (goal IN ('performance', 'weight_loss', 'general_fitness', 'muscle_gain')),
  active_modules TEXT[] NOT NULL DEFAULT ARRAY['crossfit'],
  subscription_tier TEXT NOT NULL DEFAULT 'free_trial' CHECK (subscription_tier IN ('free_trial', 'base', 'premium')),
  trial_expires_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- -----------------------------------------------------------
-- 1RM RECORDS
-- -----------------------------------------------------------

CREATE TABLE one_rep_maxes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
  exercise_name TEXT NOT NULL,
  weight_kg NUMERIC(6,2) NOT NULL,
  recorded_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(user_id, exercise_name, recorded_at)
);

CREATE INDEX idx_1rm_user ON one_rep_maxes(user_id, exercise_name);

-- -----------------------------------------------------------
-- PROGRAMS
-- -----------------------------------------------------------

CREATE TABLE programs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  module TEXT NOT NULL CHECK (module IN ('crossfit', 'hyrox', 'strength', 'home')),
  name TEXT NOT NULL,
  description TEXT,
  duration_weeks INTEGER NOT NULL DEFAULT 6,
  level TEXT NOT NULL DEFAULT 'intermediate' CHECK (level IN ('beginner', 'intermediate', 'advanced')),
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- -----------------------------------------------------------
-- PROGRAM WEEKS
-- -----------------------------------------------------------

CREATE TABLE program_weeks (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  program_id UUID NOT NULL REFERENCES programs(id) ON DELETE CASCADE,
  week_number INTEGER NOT NULL CHECK (week_number BETWEEN 1 AND 6),
  theme TEXT NOT NULL DEFAULT '',
  intensity_modifier NUMERIC(3,2) NOT NULL DEFAULT 1.00,
  UNIQUE(program_id, week_number)
);

-- -----------------------------------------------------------
-- SESSIONS (5-6 per week)
-- -----------------------------------------------------------

CREATE TABLE sessions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  week_id UUID NOT NULL REFERENCES program_weeks(id) ON DELETE CASCADE,
  day_number INTEGER NOT NULL CHECK (day_number BETWEEN 1 AND 6),
  session_type TEXT NOT NULL CHECK (session_type IN ('crossfit', 'hyrox', 'strength', 'home', 'mixed')),
  name TEXT NOT NULL,
  description TEXT,
  estimated_duration_min INTEGER NOT NULL DEFAULT 60,
  finisher_type TEXT NOT NULL DEFAULT 'none' CHECK (finisher_type IN ('core', 'cardio', 'mixed', 'none')),
  UNIQUE(week_id, day_number)
);

-- -----------------------------------------------------------
-- WORKOUT BLOCKS (warmup, strength, WOD, finisher)
-- -----------------------------------------------------------

CREATE TABLE workout_blocks (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  session_id UUID NOT NULL REFERENCES sessions(id) ON DELETE CASCADE,
  block_type TEXT NOT NULL CHECK (block_type IN ('warmup', 'strength', 'skill', 'wod', 'finisher')),
  order_index INTEGER NOT NULL DEFAULT 0,
  name TEXT NOT NULL,
  instructions TEXT NOT NULL DEFAULT '',
  wod_format TEXT CHECK (wod_format IN ('amrap', 'emom', 'for_time', 'tabata')),
  time_cap_seconds INTEGER,
  target_rounds INTEGER
);

CREATE INDEX idx_blocks_session ON workout_blocks(session_id, order_index);

-- -----------------------------------------------------------
-- BLOCK EXERCISES
-- -----------------------------------------------------------

CREATE TABLE block_exercises (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  block_id UUID NOT NULL REFERENCES workout_blocks(id) ON DELETE CASCADE,
  exercise_name TEXT NOT NULL,
  sets INTEGER,
  reps TEXT, -- can be "max" or a number
  weight_percentage NUMERIC(5,2), -- percentage of 1RM
  rest_seconds INTEGER,
  order_index INTEGER NOT NULL DEFAULT 0,
  notes TEXT
);

CREATE INDEX idx_exercises_block ON block_exercises(block_id, order_index);

-- -----------------------------------------------------------
-- WORKOUT LOGS (user's completed sessions)
-- -----------------------------------------------------------

CREATE TABLE workout_logs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
  session_id UUID NOT NULL REFERENCES sessions(id),
  program_week_id UUID REFERENCES program_weeks(id),
  started_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  completed_at TIMESTAMPTZ,
  status TEXT NOT NULL DEFAULT 'in_progress' CHECK (status IN ('in_progress', 'completed', 'skipped'))
);

CREATE INDEX idx_workout_logs_user ON workout_logs(user_id, started_at DESC);

-- -----------------------------------------------------------
-- EXERCISE LOGS (individual set logs)
-- -----------------------------------------------------------

CREATE TABLE exercise_logs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  workout_log_id UUID NOT NULL REFERENCES workout_logs(id) ON DELETE CASCADE,
  block_exercise_id UUID REFERENCES block_exercises(id),
  exercise_name TEXT NOT NULL,
  set_number INTEGER NOT NULL DEFAULT 1,
  reps_completed INTEGER NOT NULL DEFAULT 0,
  weight_kg NUMERIC(6,2),
  rpe INTEGER CHECK (rpe BETWEEN 1 AND 10),
  notes TEXT
);

CREATE INDEX idx_exercise_logs_workout ON exercise_logs(workout_log_id);
CREATE INDEX idx_exercise_logs_name ON exercise_logs(exercise_name, weight_kg DESC);

-- -----------------------------------------------------------
-- WOD LOGS
-- -----------------------------------------------------------

CREATE TABLE wod_logs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  workout_log_id UUID NOT NULL REFERENCES workout_logs(id) ON DELETE CASCADE,
  block_id UUID NOT NULL REFERENCES workout_blocks(id),
  wod_format TEXT NOT NULL CHECK (wod_format IN ('amrap', 'emom', 'for_time', 'tabata')),
  score NUMERIC(10,2) NOT NULL,
  score_detail TEXT,
  rx BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE INDEX idx_wod_logs_workout ON wod_logs(workout_log_id);

-- -----------------------------------------------------------
-- SESSION FEEDBACK
-- -----------------------------------------------------------

CREATE TABLE session_feedback (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  workout_log_id UUID NOT NULL REFERENCES workout_logs(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
  session_id UUID NOT NULL REFERENCES sessions(id),
  warmup_feeling TEXT NOT NULL CHECK (warmup_feeling IN ('tired', 'normal', 'good')),
  strength_difficulty TEXT NOT NULL CHECK (strength_difficulty IN ('easy', 'ok', 'hard')),
  strength_rpe INTEGER NOT NULL CHECK (strength_rpe BETWEEN 1 AND 10),
  wod_feeling TEXT NOT NULL CHECK (wod_feeling IN ('fresh', 'tired', 'exhausted')),
  finisher_feeling TEXT NOT NULL CHECK (finisher_feeling IN ('fresh', 'tired', 'exhausted')),
  global_fatigue INTEGER NOT NULL CHECK (global_fatigue BETWEEN 1 AND 10),
  motivation INTEGER NOT NULL CHECK (motivation BETWEEN 1 AND 10),
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_feedback_user ON session_feedback(user_id, created_at DESC);

-- -----------------------------------------------------------
-- ADAPTIVE SCORES (computed snapshots)
-- -----------------------------------------------------------

CREATE TABLE adaptive_scores (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
  fatigue_score NUMERIC(5,2) NOT NULL DEFAULT 0,
  performance_score NUMERIC(5,2) NOT NULL DEFAULT 0,
  consistency_score NUMERIC(5,2) NOT NULL DEFAULT 0,
  total_score NUMERIC(5,2) NOT NULL DEFAULT 0,
  classification TEXT NOT NULL DEFAULT 'stable' CHECK (classification IN ('performer', 'stable', 'fatigued', 'struggling')),
  computed_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_adaptive_user ON adaptive_scores(user_id, computed_at DESC);

-- -----------------------------------------------------------
-- BODY WEIGHT TRACKING
-- -----------------------------------------------------------

CREATE TABLE body_weight_logs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
  weight_kg NUMERIC(5,1) NOT NULL,
  recorded_at DATE NOT NULL DEFAULT CURRENT_DATE,
  UNIQUE(user_id, recorded_at)
);

-- -----------------------------------------------------------
-- USER PROGRAM ENROLLMENT
-- -----------------------------------------------------------

CREATE TABLE user_programs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
  program_id UUID NOT NULL REFERENCES programs(id),
  current_week INTEGER NOT NULL DEFAULT 1,
  current_day INTEGER NOT NULL DEFAULT 1,
  started_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  completed_at TIMESTAMPTZ,
  is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE INDEX idx_user_programs ON user_programs(user_id, is_active);

-- -----------------------------------------------------------
-- ROW LEVEL SECURITY
-- -----------------------------------------------------------

ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE one_rep_maxes ENABLE ROW LEVEL SECURITY;
ALTER TABLE workout_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE exercise_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE wod_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE session_feedback ENABLE ROW LEVEL SECURITY;
ALTER TABLE adaptive_scores ENABLE ROW LEVEL SECURITY;
ALTER TABLE body_weight_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_programs ENABLE ROW LEVEL SECURITY;

-- Users can only access their own data
CREATE POLICY "Users access own profile" ON user_profiles FOR ALL USING (auth.uid() = id);
CREATE POLICY "Users access own 1rm" ON one_rep_maxes FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users access own workout logs" ON workout_logs FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users access own exercise logs" ON exercise_logs FOR ALL USING (
  auth.uid() = (SELECT user_id FROM workout_logs WHERE id = exercise_logs.workout_log_id)
);
CREATE POLICY "Users access own wod logs" ON wod_logs FOR ALL USING (
  auth.uid() = (SELECT user_id FROM workout_logs WHERE id = wod_logs.workout_log_id)
);
CREATE POLICY "Users access own feedback" ON session_feedback FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users access own adaptive scores" ON adaptive_scores FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users access own body weight" ON body_weight_logs FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users access own programs" ON user_programs FOR ALL USING (auth.uid() = user_id);

-- Programs/sessions/blocks are readable by all authenticated users
ALTER TABLE programs ENABLE ROW LEVEL SECURITY;
ALTER TABLE program_weeks ENABLE ROW LEVEL SECURITY;
ALTER TABLE sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE workout_blocks ENABLE ROW LEVEL SECURITY;
ALTER TABLE block_exercises ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Programs are readable" ON programs FOR SELECT USING (TRUE);
CREATE POLICY "Weeks are readable" ON program_weeks FOR SELECT USING (TRUE);
CREATE POLICY "Sessions are readable" ON sessions FOR SELECT USING (TRUE);
CREATE POLICY "Blocks are readable" ON workout_blocks FOR SELECT USING (TRUE);
CREATE POLICY "Exercises are readable" ON block_exercises FOR SELECT USING (TRUE);

-- -----------------------------------------------------------
-- UPDATED_AT TRIGGER
-- -----------------------------------------------------------

CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER user_profiles_updated_at
  BEFORE UPDATE ON user_profiles
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();
