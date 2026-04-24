-- ============================================================
-- El Coach — Exercises Reference Table
-- ============================================================
-- Single source of truth for movement names used across programs.
-- Categorized by family, equipment, and module compatibility so
-- the programming engine can pick appropriate exercises per
-- program type (crossfit / hyrox / strength / home / hybrid).
-- ============================================================

CREATE TABLE exercises (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  category TEXT NOT NULL CHECK (category IN ('monostructural', 'weightlifting', 'gymnastics', 'odd_object', 'accessory')),
  subcategory TEXT NOT NULL,
  equipment TEXT[] NOT NULL DEFAULT ARRAY[]::TEXT[],
  modules TEXT[] NOT NULL DEFAULT ARRAY[]::TEXT[],
  is_unilateral BOOLEAN NOT NULL DEFAULT FALSE,
  is_bodyweight BOOLEAN NOT NULL DEFAULT FALSE,
  scoring_unit TEXT CHECK (scoring_unit IN ('reps', 'time_s', 'distance_m', 'calories', 'weight_kg')),
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_exercises_category ON exercises(category, subcategory);
CREATE INDEX idx_exercises_modules ON exercises USING GIN(modules);
CREATE INDEX idx_exercises_equipment ON exercises USING GIN(equipment);

ALTER TABLE exercises ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Exercises are readable by all" ON exercises FOR SELECT USING (TRUE);

-- Add exercise_id foreign key to block_exercises (keep exercise_name for custom/legacy entries)
ALTER TABLE block_exercises ADD COLUMN exercise_id UUID REFERENCES exercises(id);
CREATE INDEX idx_block_exercises_exercise_id ON block_exercises(exercise_id);

-- ============================================================
-- Seed: Monostructural (cardio / jump rope / locomotion)
-- ============================================================

INSERT INTO exercises (slug, name, category, subcategory, equipment, modules, is_bodyweight, scoring_unit) VALUES
  ('run', 'Run', 'monostructural', 'running', ARRAY[]::TEXT[], ARRAY['crossfit','hyrox','hybrid','home'], TRUE, 'distance_m'),
  ('shuttle-run', 'Shuttle Run', 'monostructural', 'running', ARRAY[]::TEXT[], ARRAY['crossfit','hyrox','hybrid','home'], TRUE, 'distance_m'),
  ('calorie-row', 'Calorie Row', 'monostructural', 'machine', ARRAY['rower'], ARRAY['crossfit','hyrox','hybrid','strength'], FALSE, 'calories'),
  ('row-distance', 'Row (distance)', 'monostructural', 'machine', ARRAY['rower'], ARRAY['crossfit','hyrox','hybrid','strength'], FALSE, 'distance_m'),
  ('assault-bike', 'Assault Bike', 'monostructural', 'machine', ARRAY['assault_bike'], ARRAY['crossfit','hyrox','hybrid','strength'], FALSE, 'calories'),
  ('echo-bike', 'Echo Bike', 'monostructural', 'machine', ARRAY['echo_bike'], ARRAY['crossfit','hyrox','hybrid','strength'], FALSE, 'calories'),
  ('ski-erg', 'Ski Erg', 'monostructural', 'machine', ARRAY['ski_erg'], ARRAY['crossfit','hyrox','hybrid','strength'], FALSE, 'calories'),
  ('bike-erg', 'Bike Erg', 'monostructural', 'machine', ARRAY['bike_erg'], ARRAY['crossfit','hyrox','hybrid','strength'], FALSE, 'calories'),
  ('swim', 'Swim', 'monostructural', 'aquatic', ARRAY['pool'], ARRAY['crossfit','hybrid'], TRUE, 'distance_m'),
  ('single-under', 'Single Under', 'monostructural', 'jump_rope', ARRAY['jump_rope'], ARRAY['crossfit','hybrid','home'], TRUE, 'reps'),
  ('double-under', 'Double Under', 'monostructural', 'jump_rope', ARRAY['jump_rope'], ARRAY['crossfit','hybrid','home'], TRUE, 'reps'),
  ('triple-under', 'Triple Under', 'monostructural', 'jump_rope', ARRAY['jump_rope'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('double-under-crossover', 'Double Under Crossover', 'monostructural', 'jump_rope', ARRAY['jump_rope'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('bear-crawl', 'Bear Crawl', 'monostructural', 'locomotion', ARRAY[]::TEXT[], ARRAY['crossfit','hybrid','home'], TRUE, 'distance_m'),
  ('ruck-walk', 'Ruck / Weighted Vest Walk', 'monostructural', 'running', ARRAY['weighted_vest'], ARRAY['crossfit','hyrox','hybrid','home'], FALSE, 'distance_m');

-- ============================================================
-- Seed: Weightlifting — Barbell Squats
-- ============================================================

INSERT INTO exercises (slug, name, category, subcategory, equipment, modules, is_bodyweight, scoring_unit) VALUES
  ('air-squat', 'Air Squat', 'gymnastics', 'squat', ARRAY[]::TEXT[], ARRAY['crossfit','hybrid','home','hyrox'], TRUE, 'reps'),
  ('back-squat', 'Back Squat', 'weightlifting', 'squat', ARRAY['barbell','rack'], ARRAY['crossfit','hybrid','strength'], FALSE, 'weight_kg'),
  ('front-squat', 'Front Squat', 'weightlifting', 'squat', ARRAY['barbell','rack'], ARRAY['crossfit','hybrid','strength'], FALSE, 'weight_kg'),
  ('overhead-squat', 'Overhead Squat (OHS)', 'weightlifting', 'squat', ARRAY['barbell'], ARRAY['crossfit','hybrid','strength'], FALSE, 'weight_kg'),
  ('pistol-squat', 'Pistol Squat', 'gymnastics', 'squat', ARRAY[]::TEXT[], ARRAY['crossfit','hybrid','home'], TRUE, 'reps'),
  ('goblet-squat', 'Goblet Squat', 'weightlifting', 'squat', ARRAY['kettlebell','dumbbell'], ARRAY['crossfit','hybrid','home','strength'], FALSE, 'reps'),
  ('db-front-squat', 'Dumbbell Front Squat', 'weightlifting', 'squat', ARRAY['dumbbell'], ARRAY['crossfit','hybrid','home','strength'], FALSE, 'reps'),
  ('jump-squat', 'Jump Squat', 'gymnastics', 'squat', ARRAY[]::TEXT[], ARRAY['crossfit','hybrid','home'], TRUE, 'reps');

-- ============================================================
-- Seed: Weightlifting — Deadlift / Hinge
-- ============================================================

INSERT INTO exercises (slug, name, category, subcategory, equipment, modules, scoring_unit) VALUES
  ('deadlift', 'Deadlift', 'weightlifting', 'deadlift', ARRAY['barbell'], ARRAY['crossfit','hybrid','strength'], 'weight_kg'),
  ('sumo-deadlift', 'Sumo Deadlift', 'weightlifting', 'deadlift', ARRAY['barbell'], ARRAY['crossfit','hybrid','strength'], 'weight_kg'),
  ('romanian-deadlift', 'Romanian Deadlift (RDL)', 'weightlifting', 'deadlift', ARRAY['barbell','dumbbell','kettlebell'], ARRAY['crossfit','hybrid','strength','home'], 'weight_kg'),
  ('sdhp', 'Sumo Deadlift High Pull (SDHP)', 'weightlifting', 'deadlift', ARRAY['barbell'], ARRAY['crossfit','hybrid'], 'reps'),
  ('good-morning', 'Good Morning', 'weightlifting', 'hinge', ARRAY['barbell'], ARRAY['crossfit','hybrid','strength'], 'reps'),
  ('db-deadlift', 'Dumbbell Deadlift', 'weightlifting', 'deadlift', ARRAY['dumbbell'], ARRAY['crossfit','hybrid','home','strength'], 'reps'),
  ('kb-deadlift', 'Kettlebell Deadlift', 'weightlifting', 'deadlift', ARRAY['kettlebell'], ARRAY['crossfit','hybrid','home','strength'], 'reps');

-- ============================================================
-- Seed: Weightlifting — Press / Push
-- ============================================================

INSERT INTO exercises (slug, name, category, subcategory, equipment, modules, scoring_unit) VALUES
  ('strict-press', 'Strict Press (Shoulder Press)', 'weightlifting', 'press', ARRAY['barbell','rack'], ARRAY['crossfit','hybrid','strength'], 'weight_kg'),
  ('push-press', 'Push Press', 'weightlifting', 'press', ARRAY['barbell','rack'], ARRAY['crossfit','hybrid','strength'], 'weight_kg'),
  ('push-jerk', 'Push Jerk', 'weightlifting', 'press', ARRAY['barbell','rack'], ARRAY['crossfit','hybrid','strength'], 'weight_kg'),
  ('split-jerk', 'Split Jerk', 'weightlifting', 'press', ARRAY['barbell','rack'], ARRAY['crossfit','hybrid','strength'], 'weight_kg'),
  ('bench-press', 'Bench Press', 'weightlifting', 'press', ARRAY['barbell','bench','rack'], ARRAY['hybrid','strength'], 'weight_kg'),
  ('bench-press-db', 'Dumbbell Bench Press', 'weightlifting', 'press', ARRAY['dumbbell','bench'], ARRAY['hybrid','strength','home'], 'reps'),
  ('behind-the-neck-press', 'Behind the Neck Press', 'weightlifting', 'press', ARRAY['barbell','rack'], ARRAY['crossfit','hybrid','strength'], 'weight_kg'),
  ('db-shoulder-to-overhead', 'Dumbbell Shoulder-to-Overhead', 'weightlifting', 'press', ARRAY['dumbbell'], ARRAY['crossfit','hybrid','home','strength'], 'reps'),
  ('kb-press', 'Kettlebell Press', 'weightlifting', 'press', ARRAY['kettlebell'], ARRAY['crossfit','hybrid','home','strength'], 'reps'),
  ('kb-thruster', 'Kettlebell Thruster', 'weightlifting', 'complex', ARRAY['kettlebell'], ARRAY['crossfit','hybrid','home'], 'reps'),
  ('db-thruster', 'Dumbbell Thruster', 'weightlifting', 'complex', ARRAY['dumbbell'], ARRAY['crossfit','hybrid','home'], 'reps');

-- ============================================================
-- Seed: Weightlifting — Olympic Lifts
-- ============================================================

INSERT INTO exercises (slug, name, category, subcategory, equipment, modules, scoring_unit) VALUES
  ('clean', 'Clean (Squat Clean)', 'weightlifting', 'olympic_clean', ARRAY['barbell'], ARRAY['crossfit','hybrid','strength'], 'weight_kg'),
  ('power-clean', 'Power Clean', 'weightlifting', 'olympic_clean', ARRAY['barbell'], ARRAY['crossfit','hybrid','strength'], 'weight_kg'),
  ('hang-clean', 'Hang Clean', 'weightlifting', 'olympic_clean', ARRAY['barbell'], ARRAY['crossfit','hybrid','strength'], 'weight_kg'),
  ('hang-power-clean', 'Hang Power Clean', 'weightlifting', 'olympic_clean', ARRAY['barbell'], ARRAY['crossfit','hybrid','strength'], 'weight_kg'),
  ('snatch', 'Snatch (Squat Snatch)', 'weightlifting', 'olympic_snatch', ARRAY['barbell'], ARRAY['crossfit','hybrid','strength'], 'weight_kg'),
  ('power-snatch', 'Power Snatch', 'weightlifting', 'olympic_snatch', ARRAY['barbell'], ARRAY['crossfit','hybrid','strength'], 'weight_kg'),
  ('hang-snatch', 'Hang Snatch', 'weightlifting', 'olympic_snatch', ARRAY['barbell'], ARRAY['crossfit','hybrid','strength'], 'weight_kg'),
  ('hang-power-snatch', 'Hang Power Snatch', 'weightlifting', 'olympic_snatch', ARRAY['barbell'], ARRAY['crossfit','hybrid','strength'], 'weight_kg'),
  ('clean-and-jerk', 'Clean & Jerk', 'weightlifting', 'olympic_clean', ARRAY['barbell'], ARRAY['crossfit','hybrid','strength'], 'weight_kg'),
  ('snatch-balance', 'Snatch Balance', 'weightlifting', 'olympic_snatch', ARRAY['barbell'], ARRAY['crossfit','hybrid','strength'], 'weight_kg');

-- ============================================================
-- Seed: Weightlifting — Complexes & Combos
-- ============================================================

INSERT INTO exercises (slug, name, category, subcategory, equipment, modules, scoring_unit, notes) VALUES
  ('thruster', 'Thruster', 'weightlifting', 'complex', ARRAY['barbell'], ARRAY['crossfit','hybrid','strength'], 'reps', 'Front squat + push press'),
  ('ground-to-overhead', 'Ground-to-Overhead (G2OH)', 'weightlifting', 'complex', ARRAY['barbell'], ARRAY['crossfit','hybrid'], 'reps', 'Any style: snatch or clean & jerk'),
  ('shoulder-to-overhead', 'Shoulder-to-Overhead (S2OH)', 'weightlifting', 'complex', ARRAY['barbell'], ARRAY['crossfit','hybrid'], 'reps', 'Any style: press, push press, or jerk'),
  ('bear-complex', 'Bear Complex', 'weightlifting', 'complex', ARRAY['barbell'], ARRAY['crossfit','hybrid','strength'], 'reps', 'Clean + front squat + push press + back squat + push press'),
  ('devils-press', 'Devil''s Press', 'weightlifting', 'complex', ARRAY['dumbbell'], ARRAY['crossfit','hybrid','home'], 'reps', 'Burpee + double dumbbell snatch'),
  ('man-maker', 'Man Maker', 'weightlifting', 'complex', ARRAY['dumbbell'], ARRAY['crossfit','hybrid','home'], 'reps', 'Push-up + row + clean + thruster with DBs'),
  ('log-clean-press', 'Log Clean & Press', 'weightlifting', 'complex', ARRAY['log'], ARRAY['odd_object','hybrid'], 'reps', 'Strongman movement');

-- ============================================================
-- Seed: Weightlifting — Dumbbell
-- ============================================================

INSERT INTO exercises (slug, name, category, subcategory, equipment, modules, is_unilateral, scoring_unit) VALUES
  ('db-snatch', 'Dumbbell Snatch (1 arm)', 'weightlifting', 'olympic_snatch', ARRAY['dumbbell'], ARRAY['crossfit','hybrid','home','strength'], TRUE, 'reps'),
  ('db-snatch-alt', 'Alternating Dumbbell Snatch', 'weightlifting', 'olympic_snatch', ARRAY['dumbbell'], ARRAY['crossfit','hybrid','home'], FALSE, 'reps'),
  ('db-double-snatch', 'Dumbbell Snatch (2 arms)', 'weightlifting', 'olympic_snatch', ARRAY['dumbbell'], ARRAY['crossfit','hybrid','home'], FALSE, 'reps'),
  ('db-clean', 'Dumbbell Clean', 'weightlifting', 'olympic_clean', ARRAY['dumbbell'], ARRAY['crossfit','hybrid','home','strength'], FALSE, 'reps'),
  ('db-hang-clean', 'Dumbbell Hang Clean', 'weightlifting', 'olympic_clean', ARRAY['dumbbell'], ARRAY['crossfit','hybrid','home'], FALSE, 'reps'),
  ('db-hang-clean-overhead', 'Dumbbell Hang Clean-to-Overhead', 'weightlifting', 'complex', ARRAY['dumbbell'], ARRAY['crossfit','hybrid','home'], FALSE, 'reps'),
  ('db-row', 'Dumbbell Row (bent over)', 'weightlifting', 'pull', ARRAY['dumbbell'], ARRAY['hybrid','strength','home'], TRUE, 'reps'),
  ('db-box-step-up', 'Dumbbell Box Step-up', 'weightlifting', 'lunge', ARRAY['dumbbell','box'], ARRAY['crossfit','hyrox','hybrid','home'], FALSE, 'reps'),
  ('db-cossack-squat', 'Dumbbell Cossack Squat', 'weightlifting', 'squat', ARRAY['dumbbell'], ARRAY['hybrid','home','strength'], TRUE, 'reps'),
  ('db-oh-walking-lunge', 'Dumbbell Overhead Walking Lunge', 'weightlifting', 'lunge', ARRAY['dumbbell'], ARRAY['crossfit','hybrid','home'], FALSE, 'reps'),
  ('db-farmers-carry', 'Dumbbell Farmer''s Carry', 'weightlifting', 'carry', ARRAY['dumbbell'], ARRAY['crossfit','hyrox','hybrid','strength','home'], FALSE, 'distance_m'),
  ('db-overhead-carry', 'Dumbbell Overhead Carry', 'weightlifting', 'carry', ARRAY['dumbbell'], ARRAY['crossfit','hybrid','strength'], FALSE, 'distance_m');

-- ============================================================
-- Seed: Weightlifting — Kettlebell
-- ============================================================

INSERT INTO exercises (slug, name, category, subcategory, equipment, modules, is_unilateral, scoring_unit, notes) VALUES
  ('kb-swing-russian', 'Kettlebell Swing (Russian)', 'weightlifting', 'swing', ARRAY['kettlebell'], ARRAY['crossfit','hybrid','home','strength'], FALSE, 'reps', 'To eye level'),
  ('kb-swing-american', 'Kettlebell Swing (American)', 'weightlifting', 'swing', ARRAY['kettlebell'], ARRAY['crossfit','hybrid','home'], FALSE, 'reps', 'Overhead finish'),
  ('kb-clean', 'Kettlebell Clean', 'weightlifting', 'olympic_clean', ARRAY['kettlebell'], ARRAY['crossfit','hybrid','home','strength'], TRUE, 'reps'),
  ('kb-snatch', 'Kettlebell Snatch', 'weightlifting', 'olympic_snatch', ARRAY['kettlebell'], ARRAY['crossfit','hybrid','home','strength'], TRUE, 'reps'),
  ('kb-box-step-up', 'Kettlebell Box Step-up', 'weightlifting', 'lunge', ARRAY['kettlebell','box'], ARRAY['crossfit','hyrox','hybrid','home'], FALSE, 'reps'),
  ('kb-farmers-carry', 'Kettlebell Farmer''s Carry', 'weightlifting', 'carry', ARRAY['kettlebell'], ARRAY['crossfit','hyrox','hybrid','strength','home'], FALSE, 'distance_m'),
  ('kb-overhead-carry', 'Kettlebell Overhead Carry', 'weightlifting', 'carry', ARRAY['kettlebell'], ARRAY['crossfit','hybrid','strength'], TRUE, 'distance_m'),
  ('turkish-get-up', 'Turkish Get-Up (TGU)', 'weightlifting', 'complex', ARRAY['kettlebell'], ARRAY['crossfit','hybrid','home','strength'], TRUE, 'reps'),
  ('kb-row', 'Kettlebell Row', 'weightlifting', 'pull', ARRAY['kettlebell'], ARRAY['hybrid','strength','home'], TRUE, 'reps');

-- ============================================================
-- Seed: Weightlifting — Wall Ball / Med Ball
-- ============================================================

INSERT INTO exercises (slug, name, category, subcategory, equipment, modules, scoring_unit) VALUES
  ('wall-ball', 'Wall Ball Shot', 'weightlifting', 'complex', ARRAY['wall_ball'], ARRAY['crossfit','hyrox','hybrid'], 'reps'),
  ('med-ball-clean', 'Med Ball Clean', 'weightlifting', 'olympic_clean', ARRAY['medicine_ball'], ARRAY['crossfit','hybrid','home'], 'reps'),
  ('slam-ball', 'Slam Ball', 'weightlifting', 'swing', ARRAY['slam_ball'], ARRAY['crossfit','hybrid','home'], 'reps');

-- ============================================================
-- Seed: Weightlifting — Lunges (barbell)
-- ============================================================

INSERT INTO exercises (slug, name, category, subcategory, equipment, modules, scoring_unit) VALUES
  ('walking-lunge', 'Walking Lunge', 'gymnastics', 'lunge', ARRAY[]::TEXT[], ARRAY['crossfit','hyrox','hybrid','home','strength'], 'reps'),
  ('overhead-walking-lunge', 'Overhead Walking Lunge', 'weightlifting', 'lunge', ARRAY['barbell'], ARRAY['crossfit','hybrid','strength'], 'reps'),
  ('front-rack-walking-lunge', 'Front-rack Walking Lunge', 'weightlifting', 'lunge', ARRAY['barbell'], ARRAY['crossfit','hybrid','strength'], 'reps'),
  ('barbell-lunge', 'Barbell Lunge', 'weightlifting', 'lunge', ARRAY['barbell'], ARRAY['hybrid','strength'], 'reps'),
  ('lateral-lunge', 'Lateral Lunge', 'gymnastics', 'lunge', ARRAY[]::TEXT[], ARRAY['hybrid','home','strength'], 'reps'),
  ('jumping-lunge', 'Jumping Lunge', 'gymnastics', 'lunge', ARRAY[]::TEXT[], ARRAY['crossfit','hybrid','home'], 'reps'),
  ('sandbag-lunge', 'Sandbag Walking Lunge', 'odd_object', 'lunge', ARRAY['sandbag'], ARRAY['hyrox','hybrid'], 'reps');

-- ============================================================
-- Seed: Gymnastics — Pull (kipping, strict, bar/ring skills)
-- ============================================================

INSERT INTO exercises (slug, name, category, subcategory, equipment, modules, is_bodyweight, scoring_unit) VALUES
  ('strict-pull-up', 'Strict Pull-up', 'gymnastics', 'pull', ARRAY['pull_up_bar'], ARRAY['crossfit','hybrid','strength','home'], TRUE, 'reps'),
  ('kipping-pull-up', 'Kipping Pull-up', 'gymnastics', 'pull', ARRAY['pull_up_bar'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('butterfly-pull-up', 'Butterfly Pull-up', 'gymnastics', 'pull', ARRAY['pull_up_bar'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('c2b', 'Chest-to-Bar (C2B)', 'gymnastics', 'pull', ARRAY['pull_up_bar'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('bar-muscle-up', 'Bar Muscle-up', 'gymnastics', 'pull', ARRAY['pull_up_bar'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('strict-bar-muscle-up', 'Strict Bar Muscle-up', 'gymnastics', 'pull', ARRAY['pull_up_bar'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('ring-muscle-up', 'Ring Muscle-up', 'gymnastics', 'pull', ARRAY['rings'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('strict-ring-muscle-up', 'Strict Ring Muscle-up', 'gymnastics', 'pull', ARRAY['rings'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('ring-row', 'Ring Row', 'gymnastics', 'pull', ARRAY['rings'], ARRAY['crossfit','hybrid','home'], TRUE, 'reps'),
  ('t2b', 'Toes-to-Bar (T2B)', 'gymnastics', 'pull', ARRAY['pull_up_bar'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('k2e', 'Knees-to-Elbows (K2E)', 'gymnastics', 'pull', ARRAY['pull_up_bar'], ARRAY['crossfit','hybrid','home'], TRUE, 'reps'),
  ('rope-climb', 'Rope Climb', 'gymnastics', 'pull', ARRAY['rope'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('legless-rope-climb', 'Legless Rope Climb', 'gymnastics', 'pull', ARRAY['rope'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('ghd-situp', 'GHD Sit-up', 'gymnastics', 'core', ARRAY['ghd'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('peg-board', 'Peg Board', 'gymnastics', 'pull', ARRAY['peg_board'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('parallel-bar-walk', 'Parallel Bar Walk', 'gymnastics', 'balance', ARRAY['parallel_bars'], ARRAY['crossfit','hybrid'], TRUE, 'distance_m');

-- ============================================================
-- Seed: Gymnastics — Push (push-ups, dips, HSPU)
-- ============================================================

INSERT INTO exercises (slug, name, category, subcategory, equipment, modules, is_bodyweight, scoring_unit) VALUES
  ('push-up', 'Push-up', 'gymnastics', 'push', ARRAY[]::TEXT[], ARRAY['crossfit','hybrid','home','strength','hyrox'], TRUE, 'reps'),
  ('hrpu', 'Hand Release Push-up (HRPU)', 'gymnastics', 'push', ARRAY[]::TEXT[], ARRAY['crossfit','hybrid','home','hyrox'], TRUE, 'reps'),
  ('ring-push-up', 'Ring Push-up', 'gymnastics', 'push', ARRAY['rings'], ARRAY['crossfit','hybrid','home'], TRUE, 'reps'),
  ('ring-dip', 'Ring Dip', 'gymnastics', 'push', ARRAY['rings'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('box-dip', 'Box Dip', 'gymnastics', 'push', ARRAY['box'], ARRAY['crossfit','hybrid','home'], TRUE, 'reps'),
  ('hspu', 'Handstand Push-up (HSPU)', 'gymnastics', 'push', ARRAY['wall'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('strict-hspu', 'Strict Handstand Push-up', 'gymnastics', 'push', ARRAY['wall'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('wall-facing-hspu', 'Wall-Facing HSPU', 'gymnastics', 'push', ARRAY['wall'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('deficit-hspu', 'Deficit HSPU', 'gymnastics', 'push', ARRAY['wall','plates'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('strict-deficit-hspu', 'Strict Chest-to-Wall Deficit HSPU', 'gymnastics', 'push', ARRAY['wall','plates'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('pike-push-up', 'Pike Push-up', 'gymnastics', 'push', ARRAY[]::TEXT[], ARRAY['crossfit','hybrid','home'], TRUE, 'reps'),
  ('ring-handstand-push-up', 'Ring Handstand Push-up', 'gymnastics', 'push', ARRAY['rings'], ARRAY['crossfit','hybrid'], TRUE, 'reps');

-- ============================================================
-- Seed: Gymnastics — Handstand / Balance / Core
-- ============================================================

INSERT INTO exercises (slug, name, category, subcategory, equipment, modules, is_bodyweight, scoring_unit) VALUES
  ('handstand-hold', 'Handstand Hold', 'gymnastics', 'balance', ARRAY['wall'], ARRAY['crossfit','hybrid','home'], TRUE, 'time_s'),
  ('handstand-walk', 'Handstand Walk', 'gymnastics', 'balance', ARRAY[]::TEXT[], ARRAY['crossfit','hybrid'], TRUE, 'distance_m'),
  ('freestanding-handstand', 'Freestanding Handstand Hold', 'gymnastics', 'balance', ARRAY[]::TEXT[], ARRAY['crossfit','hybrid'], TRUE, 'time_s'),
  ('handstand-walk-obstacle', 'Handstand Walk Obstacle Course', 'gymnastics', 'balance', ARRAY['obstacles'], ARRAY['crossfit','hybrid'], TRUE, 'time_s'),
  ('wall-walk', 'Wall Walk', 'gymnastics', 'balance', ARRAY['wall'], ARRAY['crossfit','hybrid','home'], TRUE, 'reps'),
  ('l-sit', 'L-Sit', 'gymnastics', 'core', ARRAY[]::TEXT[], ARRAY['crossfit','hybrid','home'], TRUE, 'time_s'),
  ('hollow-rock', 'Hollow Rock', 'gymnastics', 'core', ARRAY[]::TEXT[], ARRAY['crossfit','hybrid','home'], TRUE, 'reps'),
  ('hollow-hold', 'Hollow Body Hold', 'gymnastics', 'core', ARRAY[]::TEXT[], ARRAY['crossfit','hybrid','home'], TRUE, 'time_s'),
  ('arch-hold', 'Superman / Arch Hold', 'gymnastics', 'core', ARRAY[]::TEXT[], ARRAY['crossfit','hybrid','home'], TRUE, 'time_s'),
  ('plank', 'Plank Hold', 'gymnastics', 'core', ARRAY[]::TEXT[], ARRAY['crossfit','hybrid','home','strength'], TRUE, 'time_s');

-- ============================================================
-- Seed: Gymnastics — Jumps / Plyo / Step-ups
-- ============================================================

INSERT INTO exercises (slug, name, category, subcategory, equipment, modules, is_bodyweight, scoring_unit) VALUES
  ('box-jump', 'Box Jump', 'gymnastics', 'jump', ARRAY['box'], ARRAY['crossfit','hybrid','home'], TRUE, 'reps'),
  ('box-jump-over', 'Box Jump Over', 'gymnastics', 'jump', ARRAY['box'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('lateral-box-jump-over', 'Lateral Box Jump Over', 'gymnastics', 'jump', ARRAY['box'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('broad-jump', 'Broad Jump', 'gymnastics', 'jump', ARRAY[]::TEXT[], ARRAY['crossfit','hyrox','hybrid','home'], TRUE, 'distance_m'),
  ('step-up', 'Step-up', 'gymnastics', 'jump', ARRAY['box'], ARRAY['crossfit','hyrox','hybrid','home'], TRUE, 'reps');

-- ============================================================
-- Seed: Gymnastics — Burpees (incl. hybrid burpees)
-- ============================================================

INSERT INTO exercises (slug, name, category, subcategory, equipment, modules, is_bodyweight, scoring_unit) VALUES
  ('burpee', 'Burpee', 'gymnastics', 'burpee', ARRAY[]::TEXT[], ARRAY['crossfit','hyrox','hybrid','home'], TRUE, 'reps'),
  ('bar-facing-burpee', 'Bar-facing Burpee', 'gymnastics', 'burpee', ARRAY['barbell'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('burpee-box-jump-over', 'Burpee Box Jump Over', 'gymnastics', 'burpee', ARRAY['box'], ARRAY['crossfit','hybrid'], TRUE, 'reps'),
  ('burpee-broad-jump', 'Burpee Broad Jump', 'gymnastics', 'burpee', ARRAY[]::TEXT[], ARRAY['hyrox','hybrid','crossfit'], TRUE, 'reps'),
  ('lateral-burpee-over-db', 'Lateral Burpee Over Dumbbell', 'gymnastics', 'burpee', ARRAY['dumbbell'], ARRAY['crossfit','hybrid','home'], TRUE, 'reps'),
  ('hand-release-burpee', 'Hand Release Burpee', 'gymnastics', 'burpee', ARRAY[]::TEXT[], ARRAY['crossfit','hybrid','home','hyrox'], TRUE, 'reps');

-- ============================================================
-- Seed: Odd Objects (Games / Strongman-influenced)
-- ============================================================

INSERT INTO exercises (slug, name, category, subcategory, equipment, modules, scoring_unit, notes) VALUES
  ('dball-over-shoulder', 'D-Ball Over Shoulder', 'odd_object', 'complex', ARRAY['d_ball'], ARRAY['crossfit','hybrid'], 'reps', 'Lift and throw over one shoulder'),
  ('dball-clean', 'D-Ball Clean', 'odd_object', 'olympic_clean', ARRAY['d_ball'], ARRAY['crossfit','hybrid'], 'reps', NULL),
  ('dball-carry', 'D-Ball Carry', 'odd_object', 'carry', ARRAY['d_ball'], ARRAY['crossfit','hybrid'], 'distance_m', NULL),
  ('yoke-carry', 'Yoke Carry', 'odd_object', 'carry', ARRAY['yoke'], ARRAY['crossfit','hybrid'], 'distance_m', NULL),
  ('yoke-walk', 'Yoke Walk', 'odd_object', 'carry', ARRAY['yoke'], ARRAY['crossfit','hybrid'], 'distance_m', NULL),
  ('atlas-stone', 'Atlas Stone', 'odd_object', 'complex', ARRAY['atlas_stone'], ARRAY['crossfit','hybrid'], 'reps', NULL),
  ('sandbag-carry', 'Sandbag Carry', 'odd_object', 'carry', ARRAY['sandbag'], ARRAY['crossfit','hyrox','hybrid','home'], 'distance_m', NULL),
  ('sandbag-throw', 'Sandbag Throw', 'odd_object', 'complex', ARRAY['sandbag'], ARRAY['crossfit','hybrid'], 'reps', NULL),
  ('pig-push', 'Pig Push', 'odd_object', 'complex', ARRAY['pig'], ARRAY['crossfit','hybrid'], 'distance_m', 'Games-style weighted sled'),
  ('sled-push', 'Sled Push', 'odd_object', 'complex', ARRAY['sled'], ARRAY['crossfit','hyrox','hybrid','strength'], 'distance_m', NULL),
  ('sled-pull', 'Sled Pull', 'odd_object', 'complex', ARRAY['sled'], ARRAY['crossfit','hyrox','hybrid','strength'], 'distance_m', NULL),
  ('tire-flip', 'Tire Flip', 'odd_object', 'complex', ARRAY['tire'], ARRAY['crossfit','hybrid','strength'], 'reps', NULL);

-- ============================================================
-- Seed: Accessory (core / posterior chain / hip)
-- ============================================================

INSERT INTO exercises (slug, name, category, subcategory, equipment, modules, is_bodyweight, scoring_unit) VALUES
  ('ghd-hip-extension', 'GHD Hip Extension', 'accessory', 'posterior', ARRAY['ghd'], ARRAY['crossfit','hybrid','strength'], TRUE, 'reps'),
  ('back-extension', 'Back Extension', 'accessory', 'posterior', ARRAY['ghd'], ARRAY['crossfit','hybrid','strength'], TRUE, 'reps'),
  ('v-up', 'V-Up', 'accessory', 'core', ARRAY[]::TEXT[], ARRAY['crossfit','hybrid','home','strength'], TRUE, 'reps'),
  ('russian-twist', 'Russian Twist', 'accessory', 'core', ARRAY['medicine_ball'], ARRAY['crossfit','hybrid','home','strength'], TRUE, 'reps'),
  ('sit-up', 'Sit-up', 'accessory', 'core', ARRAY[]::TEXT[], ARRAY['crossfit','hybrid','home','hyrox','strength'], TRUE, 'reps'),
  ('mountain-climber', 'Mountain Climber', 'accessory', 'core', ARRAY[]::TEXT[], ARRAY['hybrid','home','hyrox'], TRUE, 'reps'),
  ('glute-bridge', 'Glute Bridge', 'accessory', 'posterior', ARRAY[]::TEXT[], ARRAY['hybrid','home','strength'], TRUE, 'reps'),
  ('hip-thrust', 'Hip Thrust', 'accessory', 'posterior', ARRAY['barbell','bench'], ARRAY['hybrid','strength'], FALSE, 'reps');
