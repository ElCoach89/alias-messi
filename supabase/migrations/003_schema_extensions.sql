-- ============================================================
-- El Coach — Schema Extensions
-- ============================================================
-- Adds support for:
--   - 'hybrid' module (CrossFit + musculation + adaptive cooldown)
--   - Adaptive cooldown day (walk / run / boxe / swim / rest)
--   - 7-day weeks (the 7th day is the cooldown in Hybride)
-- ============================================================

-- -----------------------------------------------------------
-- Programs — accept 'hybrid' module
-- -----------------------------------------------------------

ALTER TABLE programs DROP CONSTRAINT IF EXISTS programs_module_check;
ALTER TABLE programs ADD CONSTRAINT programs_module_check
  CHECK (module IN ('crossfit', 'hyrox', 'strength', 'home', 'hybrid'));

-- -----------------------------------------------------------
-- Sessions — allow day 1..7, accept 'hybrid' and 'cooldown' session types
-- -----------------------------------------------------------

ALTER TABLE sessions DROP CONSTRAINT IF EXISTS sessions_day_number_check;
ALTER TABLE sessions ADD CONSTRAINT sessions_day_number_check
  CHECK (day_number BETWEEN 1 AND 7);

ALTER TABLE sessions DROP CONSTRAINT IF EXISTS sessions_session_type_check;
ALTER TABLE sessions ADD CONSTRAINT sessions_session_type_check
  CHECK (session_type IN ('crossfit', 'hyrox', 'strength', 'home', 'mixed', 'hybrid', 'cooldown'));

-- Flag a session as adaptive cooldown — at runtime the engine picks the activity
-- (walk / run / boxe / swim / rest_complete) based on the user's weekly fatigue.
ALTER TABLE sessions ADD COLUMN IF NOT EXISTS is_adaptive_cooldown BOOLEAN NOT NULL DEFAULT FALSE;
-- Default fallback activity if the engine has no fatigue signal yet.
ALTER TABLE sessions ADD COLUMN IF NOT EXISTS default_cooldown_activity TEXT
  CHECK (default_cooldown_activity IN ('walk', 'run', 'boxe', 'swim', 'rest_complete'));

-- Update the week_id UNIQUE(week_id, day_number) is already fine since day_number
-- bound is the only thing that changed.

-- -----------------------------------------------------------
-- Workout blocks — allow 'cooldown' block type
-- -----------------------------------------------------------

ALTER TABLE workout_blocks DROP CONSTRAINT IF EXISTS workout_blocks_block_type_check;
ALTER TABLE workout_blocks ADD CONSTRAINT workout_blocks_block_type_check
  CHECK (block_type IN ('warmup', 'strength', 'skill', 'wod', 'finisher', 'cooldown'));

-- -----------------------------------------------------------
-- Weekly fatigue snapshots — feeds the cooldown decision
-- -----------------------------------------------------------
-- The engine already computes daily adaptive_scores. This table rolls up by
-- ISO week so the Hybride cooldown on day 7 can look at "last 6 days" context
-- to decide walk (low fatigue) → run (low fatigue + motivated) → swim/boxe
-- (moderate) → rest_complete (high fatigue).

CREATE TABLE weekly_fatigue_snapshots (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
  iso_year INTEGER NOT NULL,
  iso_week INTEGER NOT NULL CHECK (iso_week BETWEEN 1 AND 53),
  avg_fatigue_score NUMERIC(5,2) NOT NULL DEFAULT 0,
  avg_performance_score NUMERIC(5,2) NOT NULL DEFAULT 0,
  sessions_completed INTEGER NOT NULL DEFAULT 0,
  suggested_cooldown TEXT NOT NULL DEFAULT 'walk'
    CHECK (suggested_cooldown IN ('walk', 'run', 'boxe', 'swim', 'rest_complete')),
  computed_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(user_id, iso_year, iso_week)
);

CREATE INDEX idx_weekly_fatigue_user ON weekly_fatigue_snapshots(user_id, iso_year DESC, iso_week DESC);

ALTER TABLE weekly_fatigue_snapshots ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users access own weekly fatigue" ON weekly_fatigue_snapshots
  FOR ALL USING (auth.uid() = user_id);
