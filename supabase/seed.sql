-- ============================================================
-- El Coach — Seed Data: CrossFit Base Program (6 Weeks)
-- ============================================================

-- Insert the CrossFit program
INSERT INTO programs (id, module, name, description, duration_weeks, level)
VALUES (
  '00000000-0000-0000-0000-000000000001',
  'crossfit',
  'CrossFit Foundations',
  'A 6-week progressive CrossFit program building strength, conditioning, and skills.',
  6,
  'intermediate'
);

-- Insert 6 weeks
INSERT INTO program_weeks (id, program_id, week_number, theme, intensity_modifier) VALUES
  ('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 1, 'Foundation', 0.85),
  ('10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', 2, 'Build', 0.90),
  ('10000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001', 3, 'Intensity', 0.95),
  ('10000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000001', 4, 'Peak', 1.00),
  ('10000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000001', 5, 'Deload', 0.80),
  ('10000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000001', 6, 'Test', 1.05);

-- ============================================================
-- Week 1 Sessions (5 training + 1 recovery)
-- ============================================================

-- Day 1: Upper Strength + Core Finisher
INSERT INTO sessions (id, week_id, day_number, session_type, name, estimated_duration_min, finisher_type)
VALUES ('20000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', 1, 'crossfit', 'Upper Strength + MetCon', 55, 'core');

-- Day 1 Blocks
INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions) VALUES
  ('30000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', 'warmup', 0, 'General Warm-up', ''),
  ('30000000-0000-0000-0000-000000000002', '20000000-0000-0000-0000-000000000001', 'strength', 1, 'Strict Press', 'Build to working sets'),
  ('30000000-0000-0000-0000-000000000003', '20000000-0000-0000-0000-000000000001', 'wod', 2, 'Fight Gone Bad', '', 'amrap', 1020, NULL),
  ('30000000-0000-0000-0000-000000000004', '20000000-0000-0000-0000-000000000001', 'finisher', 3, 'Core Circuit', '3 rounds');

-- Day 1 Exercises
INSERT INTO block_exercises (block_id, exercise_name, sets, reps, order_index) VALUES
  ('30000000-0000-0000-0000-000000000001', '400m Row', NULL, '1', 0),
  ('30000000-0000-0000-0000-000000000001', 'Arm Circles', NULL, '10 each', 1),
  ('30000000-0000-0000-0000-000000000001', 'PVC Pass-throughs', NULL, '10', 2),
  ('30000000-0000-0000-0000-000000000001', 'Push-up to Down Dog', NULL, '8', 3);

INSERT INTO block_exercises (block_id, exercise_name, sets, reps, weight_percentage, rest_seconds, order_index) VALUES
  ('30000000-0000-0000-0000-000000000002', 'Strict Press', 5, '5', 70, 120, 0);

INSERT INTO block_exercises (block_id, exercise_name, order_index, notes) VALUES
  ('30000000-0000-0000-0000-000000000003', 'Wall Balls (9/6kg)', 0, '1 min station'),
  ('30000000-0000-0000-0000-000000000003', 'Sumo Deadlift High Pull (35/25kg)', 1, '1 min station'),
  ('30000000-0000-0000-0000-000000000003', 'Box Jumps (20")', 2, '1 min station'),
  ('30000000-0000-0000-0000-000000000003', 'Push Press (35/25kg)', 3, '1 min station'),
  ('30000000-0000-0000-0000-000000000003', 'Row (calories)', 4, '1 min station');

INSERT INTO block_exercises (block_id, exercise_name, sets, reps, order_index) VALUES
  ('30000000-0000-0000-0000-000000000004', 'Plank Hold', 3, '45s', 0),
  ('30000000-0000-0000-0000-000000000004', 'V-ups', 3, '15', 1),
  ('30000000-0000-0000-0000-000000000004', 'Russian Twists', 3, '20', 2);

-- Day 2: Lower Body + Cardio Finisher
INSERT INTO sessions (id, week_id, day_number, session_type, name, estimated_duration_min, finisher_type)
VALUES ('20000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000001', 2, 'crossfit', 'Lower Body + Intervals', 50, 'cardio');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions, wod_format, time_cap_seconds) VALUES
  ('30000000-0000-0000-0000-000000000005', '20000000-0000-0000-0000-000000000002', 'warmup', 0, 'Warm-up', '', NULL, NULL),
  ('30000000-0000-0000-0000-000000000006', '20000000-0000-0000-0000-000000000002', 'strength', 1, 'Back Squat', 'Progressive loading', NULL, NULL),
  ('30000000-0000-0000-0000-000000000007', '20000000-0000-0000-0000-000000000002', 'wod', 2, 'Squat Clean Ladder', '', 'for_time', 720),
  ('30000000-0000-0000-0000-000000000008', '20000000-0000-0000-0000-000000000002', 'finisher', 3, 'Cardio Blast', '4 rounds', NULL, NULL);

INSERT INTO block_exercises (block_id, exercise_name, sets, reps, weight_percentage, rest_seconds, order_index) VALUES
  ('30000000-0000-0000-0000-000000000006', 'Back Squat', 5, '5', 75, 150, 0);

INSERT INTO block_exercises (block_id, exercise_name, order_index, notes) VALUES
  ('30000000-0000-0000-0000-000000000007', 'Squat Cleans', 0, '21-15-9 reps'),
  ('30000000-0000-0000-0000-000000000007', 'Bar-facing Burpees', 1, '21-15-9 reps');

INSERT INTO block_exercises (block_id, exercise_name, sets, reps, order_index) VALUES
  ('30000000-0000-0000-0000-000000000008', 'Assault Bike', 4, '30s max', 0),
  ('30000000-0000-0000-0000-000000000008', 'Rest', 4, '30s', 1);

-- Day 3: Gymnastics + Core Finisher
INSERT INTO sessions (id, week_id, day_number, session_type, name, estimated_duration_min, finisher_type)
VALUES ('20000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000001', 3, 'crossfit', 'Gymnastics + AMRAP', 60, 'core');

-- Day 4: Push/Pull + Cardio Finisher
INSERT INTO sessions (id, week_id, day_number, session_type, name, estimated_duration_min, finisher_type)
VALUES ('20000000-0000-0000-0000-000000000004', '10000000-0000-0000-0000-000000000001', 4, 'crossfit', 'Push/Pull + EMOM', 55, 'cardio');

-- Day 5: Full Body + Mixed Finisher
INSERT INTO sessions (id, week_id, day_number, session_type, name, estimated_duration_min, finisher_type)
VALUES ('20000000-0000-0000-0000-000000000005', '10000000-0000-0000-0000-000000000001', 5, 'crossfit', 'Full Body + For Time', 65, 'mixed');

-- Day 6: Active Recovery (no finisher)
INSERT INTO sessions (id, week_id, day_number, session_type, name, estimated_duration_min, finisher_type)
VALUES ('20000000-0000-0000-0000-000000000006', '10000000-0000-0000-0000-000000000001', 6, 'crossfit', 'Active Recovery', 30, 'none');
