-- ============================================================
-- El Coach — Week 1 FULL detail (Days 2..end for each program)
-- ============================================================
-- Converts the shells from 005 into fully-blocked sessions.
-- Relies on DELETE + INSERT for the shell session rows.
-- UUID scheme continues from 005.
-- ============================================================

-- We need to re-create each shell session with blocks. Rather than UPDATE
-- everything, we DELETE the shells created in 005 and re-INSERT with full
-- blocks. Block UUIDs are new to avoid collisions.

DELETE FROM sessions WHERE id IN (
  -- CrossFit Pure Days 2-6
  'aaaaaaaa-0000-0000-0000-000011200000',
  'aaaaaaaa-0000-0000-0000-000011300000',
  'aaaaaaaa-0000-0000-0000-000011400000',
  'aaaaaaaa-0000-0000-0000-000011500000',
  'aaaaaaaa-0000-0000-0000-000011600000',
  -- Hybride Days 2-6 (Day 7 cooldown already final)
  'aaaaaaaa-0000-0000-0000-000022200000',
  'aaaaaaaa-0000-0000-0000-000022300000',
  'aaaaaaaa-0000-0000-0000-000022400000',
  'aaaaaaaa-0000-0000-0000-000022500000',
  'aaaaaaaa-0000-0000-0000-000022600000',
  -- Hyrox Pure Days 2-6
  'aaaaaaaa-0000-0000-0000-000033200000',
  'aaaaaaaa-0000-0000-0000-000033300000',
  'aaaaaaaa-0000-0000-0000-000033400000',
  'aaaaaaaa-0000-0000-0000-000033500000',
  'aaaaaaaa-0000-0000-0000-000033600000',
  -- At Home Days 2-6
  'aaaaaaaa-0000-0000-0000-000044200000',
  'aaaaaaaa-0000-0000-0000-000044300000',
  'aaaaaaaa-0000-0000-0000-000044400000',
  'aaaaaaaa-0000-0000-0000-000044500000',
  'aaaaaaaa-0000-0000-0000-000044600000'
);

-- ============================================================
-- PROGRAM 1 — CrossFit Pure — Days 2..6
-- ============================================================

-- === Day 2: Lower Strength + Conditioning ===================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000011200000', '11111111-1111-1111-1111-000000000101', 2, 'crossfit',
   'Lower Strength + Conditioning',
   'Back Squat progressif puis échelle de squat cleans + bar-facing burpees, finisher bike.',
   55, 'cardio');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions, wod_format, time_cap_seconds) VALUES
  ('bbbbbbbb-0000-0000-0000-000011200001', 'aaaaaaaa-0000-0000-0000-000011200000', 'warmup',   0, 'Échauffement', '3 tours à rythme contrôlé', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000011200002', 'aaaaaaaa-0000-0000-0000-000011200000', 'strength', 1, 'Back Squat', '5×5 @ 75% 1RM, 150s repos', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000011200003', 'aaaaaaaa-0000-0000-0000-000011200000', 'wod',      2, '21-15-9 Squat Clean / Bar-facing Burpee', 'For time, cap 12 min', 'for_time', 720),
  ('bbbbbbbb-0000-0000-0000-000011200004', 'aaaaaaaa-0000-0000-0000-000011200000', 'finisher', 3, 'Bike Intervals', '4× 30s max / 30s repos', NULL, NULL);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000011200001', (SELECT id FROM exercises WHERE slug = 'run'),          'Run',         NULL, '200m', 0),
  ('bbbbbbbb-0000-0000-0000-000011200001', (SELECT id FROM exercises WHERE slug = 'goblet-squat'), 'Goblet Squat', NULL, '10',   1),
  ('bbbbbbbb-0000-0000-0000-000011200001', (SELECT id FROM exercises WHERE slug = 'push-up'),      'Push-up',      NULL, '10',   2);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, weight_percentage, rest_seconds, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000011200002', (SELECT id FROM exercises WHERE slug = 'back-squat'),  'Back Squat', 5, '5', 75, 150, 0);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000011200003', (SELECT id FROM exercises WHERE slug = 'clean'),             'Squat Clean',       '21-15-9', 0, '@ 60% 1RM'),
  ('bbbbbbbb-0000-0000-0000-000011200003', (SELECT id FROM exercises WHERE slug = 'bar-facing-burpee'), 'Bar-facing Burpee', '21-15-9', 1, NULL);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000011200004', (SELECT id FROM exercises WHERE slug = 'assault-bike'), 'Assault Bike', 4, '30s', 0, '30s repos entre intervalles');

-- === Day 3: Olympic + Gymnastics EMOM =======================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000011300000', '11111111-1111-1111-1111-000000000101', 3, 'crossfit',
   'Olympic + Gymnastics',
   'Technique snatch + EMOM mélangeant T2B et calorie row.',
   60, 'core');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions, wod_format, time_cap_seconds) VALUES
  ('bbbbbbbb-0000-0000-0000-000011300001', 'aaaaaaaa-0000-0000-0000-000011300000', 'warmup', 0, 'PVC Snatch Warmup', '3 tours avec barre vide', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000011300002', 'aaaaaaaa-0000-0000-0000-000011300000', 'skill',  1, 'Snatch Technique', 'EMOM 8 min, 2 reps / min', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000011300003', 'aaaaaaaa-0000-0000-0000-000011300000', 'wod',    2, 'EMOM 15 min Mixte', 'Rotation T2B / Row / Push Press', 'emom', 900),
  ('bbbbbbbb-0000-0000-0000-000011300004', 'aaaaaaaa-0000-0000-0000-000011300000', 'finisher', 3, 'Core Finisher', '3 tours', NULL, NULL);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000011300001', (SELECT id FROM exercises WHERE slug = 'bike-erg'),     'Bike',          NULL, '5 min', 0),
  ('bbbbbbbb-0000-0000-0000-000011300001', (SELECT id FROM exercises WHERE slug = 'air-squat'),    'Air Squat',     3, '10', 1),
  ('bbbbbbbb-0000-0000-0000-000011300001', (SELECT id FROM exercises WHERE slug = 'hang-snatch'),  'Hang Snatch (PVC)', 3, '8', 2);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, weight_percentage, rest_seconds, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000011300002', (SELECT id FROM exercises WHERE slug = 'snatch'), 'Snatch', 8, '2', 65, 0, 0);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000011300003', (SELECT id FROM exercises WHERE slug = 't2b'),          'T2B',          '10', 0, 'Min 1, 4, 7, 10, 13'),
  ('bbbbbbbb-0000-0000-0000-000011300003', (SELECT id FROM exercises WHERE slug = 'calorie-row'),  'Cal Row',      '12/10', 1, 'Min 2, 5, 8, 11, 14'),
  ('bbbbbbbb-0000-0000-0000-000011300003', (SELECT id FROM exercises WHERE slug = 'push-press'),   'Push Press',   '8 @ 50%', 2, 'Min 3, 6, 9, 12, 15');

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000011300004', (SELECT id FROM exercises WHERE slug = 'ghd-situp'), 'GHD Sit-up',  3, '15',   0),
  ('bbbbbbbb-0000-0000-0000-000011300004', (SELECT id FROM exercises WHERE slug = 'plank'),     'Plank',       3, '30s',  1);

-- === Day 4: Deadlift + HSPU EMOM ============================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000011400000', '11111111-1111-1111-1111-000000000101', 4, 'crossfit',
   'Deadlift + HSPU EMOM',
   'Deadlift lourd puis EMOM 20 min alternant HSPU et box jumps.',
   55, 'cardio');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions, wod_format, time_cap_seconds) VALUES
  ('bbbbbbbb-0000-0000-0000-000011400001', 'aaaaaaaa-0000-0000-0000-000011400000', 'warmup',   0, 'Mobilité hanches + activation', '2 tours', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000011400002', 'aaaaaaaa-0000-0000-0000-000011400000', 'strength', 1, 'Deadlift', '5×3 @ 80% 1RM, 180s repos', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000011400003', 'aaaaaaaa-0000-0000-0000-000011400000', 'wod',      2, 'EMOM 20 min HSPU / Box', 'Min impair HSPU, Min pair Box Jump', 'emom', 1200),
  ('bbbbbbbb-0000-0000-0000-000011400004', 'aaaaaaaa-0000-0000-0000-000011400000', 'finisher', 3, 'Core Triplet', '3 tours', NULL, NULL);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000011400001', (SELECT id FROM exercises WHERE slug = 'row-distance'),  'Row',           NULL, '250m', 0),
  ('bbbbbbbb-0000-0000-0000-000011400001', (SELECT id FROM exercises WHERE slug = 'walking-lunge'), 'Walking Lunge', NULL, '10 par jambe', 1),
  ('bbbbbbbb-0000-0000-0000-000011400001', (SELECT id FROM exercises WHERE slug = 'push-up'),       'Push-up',       NULL, '8',    2);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, weight_percentage, rest_seconds, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000011400002', (SELECT id FROM exercises WHERE slug = 'deadlift'), 'Deadlift', 5, '3', 80, 180, 0);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000011400003', (SELECT id FROM exercises WHERE slug = 'hspu'),     'HSPU',     '5-8', 0, 'Minutes impaires'),
  ('bbbbbbbb-0000-0000-0000-000011400003', (SELECT id FROM exercises WHERE slug = 'box-jump'), 'Box Jump', '12',  1, 'Minutes paires, 60/50 cm');

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000011400004', (SELECT id FROM exercises WHERE slug = 'russian-twist'), 'Russian Twist', 3, '20', 0),
  ('bbbbbbbb-0000-0000-0000-000011400004', (SELECT id FROM exercises WHERE slug = 'hollow-rock'),   'Hollow Rock',   3, '15', 1),
  ('bbbbbbbb-0000-0000-0000-000011400004', (SELECT id FROM exercises WHERE slug = 'plank'),         'Plank',         3, '30s', 2);

-- === Day 5: Benchmark "Cindy" ===============================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000011500000', '11111111-1111-1111-1111-000000000101', 5, 'crossfit',
   'Benchmark "Cindy"',
   'AMRAP 20 min : 5 pull-ups / 10 push-ups / 15 air squats. Benchmark de référence.',
   45, 'none');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions, wod_format, time_cap_seconds) VALUES
  ('bbbbbbbb-0000-0000-0000-000011500001', 'aaaaaaaa-0000-0000-0000-000011500000', 'warmup', 0, 'Slow Cindy', '3 tours à rythme facile', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000011500002', 'aaaaaaaa-0000-0000-0000-000011500000', 'wod',    1, 'Cindy', 'AMRAP 20 min', 'amrap', 1200);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000011500001', (SELECT id FROM exercises WHERE slug = 'strict-pull-up'),  'Pull-up',   3, '3',   0),
  ('bbbbbbbb-0000-0000-0000-000011500001', (SELECT id FROM exercises WHERE slug = 'push-up'),         'Push-up',   3, '6',   1),
  ('bbbbbbbb-0000-0000-0000-000011500001', (SELECT id FROM exercises WHERE slug = 'air-squat'),       'Air Squat', 3, '9',   2);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000011500002', (SELECT id FROM exercises WHERE slug = 'kipping-pull-up'),  'Pull-up',   '5',  0),
  ('bbbbbbbb-0000-0000-0000-000011500002', (SELECT id FROM exercises WHERE slug = 'push-up'),          'Push-up',   '10', 1),
  ('bbbbbbbb-0000-0000-0000-000011500002', (SELECT id FROM exercises WHERE slug = 'air-squat'),        'Air Squat', '15', 2);

-- === Day 6: Active Recovery =================================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000011600000', '11111111-1111-1111-1111-000000000101', 6, 'crossfit',
   'Active Recovery',
   'Marche ou rameur facile 20 min + mobilité hanches/épaules.',
   30, 'none');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions) VALUES
  ('bbbbbbbb-0000-0000-0000-000011600001', 'aaaaaaaa-0000-0000-0000-000011600000', 'cooldown', 0, 'Low Intensity', 'Choisir 1 modalité à rythme conversationnel'),
  ('bbbbbbbb-0000-0000-0000-000011600002', 'aaaaaaaa-0000-0000-0000-000011600000', 'cooldown', 1, 'Mobilité', 'Enchaîner les positions, pas de chrono');

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000011600001', (SELECT id FROM exercises WHERE slug = 'run'),          'Walk / easy jog', '20 min', 0),
  ('bbbbbbbb-0000-0000-0000-000011600001', (SELECT id FROM exercises WHERE slug = 'row-distance'), 'Rameur easy',     '2000m',  1);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000011600002', NULL, 'Pigeon Pose',       '60s/côté', 0, 'Mobilité hanches'),
  ('bbbbbbbb-0000-0000-0000-000011600002', NULL, 'Couch Stretch',     '60s/côté', 1, 'Psoas + quad'),
  ('bbbbbbbb-0000-0000-0000-000011600002', NULL, 'Shoulder Dislocates','15 reps', 2, 'PVC');

-- ============================================================
-- PROGRAM 2 — Hybride — Days 2..6 (Day 7 cooldown already set)
-- ============================================================

-- === Day 2: WOD Upper Focus — "Grace" =======================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000022200000', '22222222-2222-2222-2222-000000000201', 2, 'crossfit',
   'WOD Upper Focus — Grace',
   '30 Clean & Jerk for time. Benchmark classique, intensité max.',
   35, 'cardio');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions, wod_format, time_cap_seconds) VALUES
  ('bbbbbbbb-0000-0000-0000-000022200001', 'aaaaaaaa-0000-0000-0000-000022200000', 'warmup', 0, 'Bar Complex Warmup', '3 tours avec barre vide', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000022200002', 'aaaaaaaa-0000-0000-0000-000022200000', 'wod',    1, 'Grace', '30 Clean & Jerk for time @ 60/40 kg', 'for_time', 600),
  ('bbbbbbbb-0000-0000-0000-000022200003', 'aaaaaaaa-0000-0000-0000-000022200000', 'finisher', 2, 'Core Circuit', '3 tours', NULL, NULL);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000022200001', (SELECT id FROM exercises WHERE slug = 'row-distance'),    'Row',               NULL, '500m', 0),
  ('bbbbbbbb-0000-0000-0000-000022200001', (SELECT id FROM exercises WHERE slug = 'clean-and-jerk'),  'Clean & Jerk (vide)', 3, '5', 1);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000022200002', (SELECT id FROM exercises WHERE slug = 'clean-and-jerk'), 'Clean & Jerk', '30', 0, '@ 60/40 kg RX');

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000022200003', (SELECT id FROM exercises WHERE slug = 'run'),         'Run',    3, '200m', 0),
  ('bbbbbbbb-0000-0000-0000-000022200003', (SELECT id FROM exercises WHERE slug = 'sit-up'),      'Sit-up', 3, '20',   1);

-- === Day 3: Pull (Dos / Biceps) =============================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000022300000', '22222222-2222-2222-2222-000000000201', 3, 'strength',
   'Pull — Dos / Biceps',
   'Deadlift, pull-ups lestées, DB rows, finisher hollow.',
   65, 'none');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions) VALUES
  ('bbbbbbbb-0000-0000-0000-000022300001', 'aaaaaaaa-0000-0000-0000-000022300000', 'warmup',   0, 'Activation dos', '5 min bike + bandes'),
  ('bbbbbbbb-0000-0000-0000-000022300002', 'aaaaaaaa-0000-0000-0000-000022300000', 'strength', 1, 'Deadlift',       '5×5 @ 75%, 180s repos'),
  ('bbbbbbbb-0000-0000-0000-000022300003', 'aaaaaaaa-0000-0000-0000-000022300000', 'strength', 2, 'Pull-up lesté',  '4×6 avec ceinture'),
  ('bbbbbbbb-0000-0000-0000-000022300004', 'aaaaaaaa-0000-0000-0000-000022300000', 'strength', 3, 'Accessoires',    '3 tours en superset'),
  ('bbbbbbbb-0000-0000-0000-000022300005', 'aaaaaaaa-0000-0000-0000-000022300000', 'finisher', 4, 'Hollow Tabata',  '8 tours 20s/10s');

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000022300001', (SELECT id FROM exercises WHERE slug = 'bike-erg'),      'Bike',          NULL, '5 min', 0),
  ('bbbbbbbb-0000-0000-0000-000022300001', (SELECT id FROM exercises WHERE slug = 'ring-row'),      'Ring Row',      2, '10',    1);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, weight_percentage, rest_seconds, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000022300002', (SELECT id FROM exercises WHERE slug = 'deadlift'),       'Deadlift',      5, '5', 75,  180, 0),
  ('bbbbbbbb-0000-0000-0000-000022300003', (SELECT id FROM exercises WHERE slug = 'strict-pull-up'), 'Weighted Pull-up', 4, '6', NULL, 120, 0);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, rest_seconds, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000022300004', (SELECT id FROM exercises WHERE slug = 'db-row'),     'DB Row',      3, '10', 60, 0),
  ('bbbbbbbb-0000-0000-0000-000022300004', (SELECT id FROM exercises WHERE slug = 'kb-row'),     'KB Row',      3, '10', 60, 1);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000022300005', (SELECT id FROM exercises WHERE slug = 'hollow-hold'), 'Hollow Hold', '20s', 0, 'Tabata 8 tours');

-- === Day 4: WOD Lower Focus — "Karen" =======================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000022400000', '22222222-2222-2222-2222-000000000201', 4, 'crossfit',
   'WOD Lower Focus — Karen',
   '150 Wall Balls for time. Jambes + cardio pur.',
   25, 'core');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions, wod_format, time_cap_seconds) VALUES
  ('bbbbbbbb-0000-0000-0000-000022400001', 'aaaaaaaa-0000-0000-0000-000022400000', 'warmup', 0, 'Squat + mobilité', '3 tours', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000022400002', 'aaaaaaaa-0000-0000-0000-000022400000', 'wod',    1, 'Karen', '150 Wall Balls for time', 'for_time', 900),
  ('bbbbbbbb-0000-0000-0000-000022400003', 'aaaaaaaa-0000-0000-0000-000022400000', 'finisher', 2, 'Plank Accumulation', '3 min total en plank (cumul)', NULL, NULL);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000022400001', (SELECT id FROM exercises WHERE slug = 'air-squat'),  'Air Squat',  3, '15', 0),
  ('bbbbbbbb-0000-0000-0000-000022400001', (SELECT id FROM exercises WHERE slug = 'wall-ball'),  'Wall Ball',  3, '10', 1);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000022400002', (SELECT id FROM exercises WHERE slug = 'wall-ball'), 'Wall Ball', '150', 0, '@ 9/6 kg RX');

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000022400003', (SELECT id FROM exercises WHERE slug = 'plank'), 'Plank (cumul)', '180s', 0);

-- === Day 5: Legs Musculation ================================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000022500000', '22222222-2222-2222-2222-000000000201', 5, 'strength',
   'Legs — Quads / Postérieurs',
   'Back Squat, RDL, front rack lunges, hip thrusts, finisher sled.',
   70, 'none');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions) VALUES
  ('bbbbbbbb-0000-0000-0000-000022500001', 'aaaaaaaa-0000-0000-0000-000022500000', 'warmup',   0, 'Bike + mobilité', '5 min bike + mobilité hanches'),
  ('bbbbbbbb-0000-0000-0000-000022500002', 'aaaaaaaa-0000-0000-0000-000022500000', 'strength', 1, 'Back Squat',       '5×5 @ 75%, 150s repos'),
  ('bbbbbbbb-0000-0000-0000-000022500003', 'aaaaaaaa-0000-0000-0000-000022500000', 'strength', 2, 'Romanian Deadlift','4×8 @ 70%, 120s repos'),
  ('bbbbbbbb-0000-0000-0000-000022500004', 'aaaaaaaa-0000-0000-0000-000022500000', 'strength', 3, 'Accessoires',      '3 tours'),
  ('bbbbbbbb-0000-0000-0000-000022500005', 'aaaaaaaa-0000-0000-0000-000022500000', 'finisher', 4, 'Sled Push',        '4× 30m lourds');

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000022500001', (SELECT id FROM exercises WHERE slug = 'bike-erg'),       'Bike',         NULL, '5 min', 0),
  ('bbbbbbbb-0000-0000-0000-000022500001', (SELECT id FROM exercises WHERE slug = 'air-squat'),     'Air Squat',    2, '15', 1);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, weight_percentage, rest_seconds, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000022500002', (SELECT id FROM exercises WHERE slug = 'back-squat'),        'Back Squat',      5, '5', 75, 150, 0),
  ('bbbbbbbb-0000-0000-0000-000022500003', (SELECT id FROM exercises WHERE slug = 'romanian-deadlift'), 'Romanian DL',     4, '8', 70, 120, 0);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, rest_seconds, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000022500004', (SELECT id FROM exercises WHERE slug = 'front-rack-walking-lunge'), 'Front Rack Lunge', 3, '20', 90, 0),
  ('bbbbbbbb-0000-0000-0000-000022500004', (SELECT id FROM exercises WHERE slug = 'hip-thrust'),               'Hip Thrust',       3, '10', 60, 1);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000022500005', (SELECT id FROM exercises WHERE slug = 'sled-push'), 'Sled Push',  4, '30m', 0);

-- === Day 6: WOD Engine Mixte ================================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000022600000', '22222222-2222-2222-2222-000000000201', 6, 'crossfit',
   'WOD Engine Mixte',
   'Triplette 3 tours : 500m row / 20 DB snatch alt / 15 burpee box jump over.',
   30, 'mixed');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions, wod_format, time_cap_seconds) VALUES
  ('bbbbbbbb-0000-0000-0000-000022600001', 'aaaaaaaa-0000-0000-0000-000022600000', 'warmup', 0, 'Row + lunges', '3 tours faciles', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000022600002', 'aaaaaaaa-0000-0000-0000-000022600000', 'wod',    1, 'Triplette 3 rounds', 'For time, cap 25 min', 'for_time', 1500);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000022600001', (SELECT id FROM exercises WHERE slug = 'row-distance'),   'Row',          NULL, '250m', 0),
  ('bbbbbbbb-0000-0000-0000-000022600001', (SELECT id FROM exercises WHERE slug = 'walking-lunge'),  'Walking Lunge', 2, '10/jambe', 1);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000022600002', (SELECT id FROM exercises WHERE slug = 'row-distance'),         'Row',              '500m', 0, NULL),
  ('bbbbbbbb-0000-0000-0000-000022600002', (SELECT id FROM exercises WHERE slug = 'db-snatch-alt'),        'DB Snatch (alt)',  '20',   1, '@ 22.5/15 kg'),
  ('bbbbbbbb-0000-0000-0000-000022600002', (SELECT id FROM exercises WHERE slug = 'burpee-box-jump-over'), 'Burpee Box Jump Over', '15', 2, '60/50 cm');

-- ============================================================
-- PROGRAM 3 — Hyrox Pure — Days 2..6
-- ============================================================

-- === Day 2: Strength Base + Sled ============================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000033200000', '33333333-3333-3333-3333-000000000301', 2, 'hyrox',
   'Strength Base + Sled',
   'Back Squat + Deadlift pour la base force, puis intervalles sled push/pull.',
   65, 'none');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions) VALUES
  ('bbbbbbbb-0000-0000-0000-000033200001', 'aaaaaaaa-0000-0000-0000-000033200000', 'warmup',   0, 'Mobilité + bike',   '5 min bike + mobilité'),
  ('bbbbbbbb-0000-0000-0000-000033200002', 'aaaaaaaa-0000-0000-0000-000033200000', 'strength', 1, 'Back Squat',         '5×5 @ 70%'),
  ('bbbbbbbb-0000-0000-0000-000033200003', 'aaaaaaaa-0000-0000-0000-000033200000', 'strength', 2, 'Deadlift',           '4×4 @ 75%'),
  ('bbbbbbbb-0000-0000-0000-000033200004', 'aaaaaaaa-0000-0000-0000-000033200000', 'wod',      3, 'Sled Intervals',     '4 tours, 60s repos'),
  ('bbbbbbbb-0000-0000-0000-000033200005', 'aaaaaaaa-0000-0000-0000-000033200000', 'finisher', 4, 'Plank',              '3 min cumul');

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000033200001', (SELECT id FROM exercises WHERE slug = 'bike-erg'),  'Bike',      NULL, '5 min', 0),
  ('bbbbbbbb-0000-0000-0000-000033200001', (SELECT id FROM exercises WHERE slug = 'air-squat'), 'Air Squat', 2, '10', 1);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, weight_percentage, rest_seconds, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000033200002', (SELECT id FROM exercises WHERE slug = 'back-squat'), 'Back Squat', 5, '5', 70, 150, 0),
  ('bbbbbbbb-0000-0000-0000-000033200003', (SELECT id FROM exercises WHERE slug = 'deadlift'),   'Deadlift',   4, '4', 75, 180, 0);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000033200004', (SELECT id FROM exercises WHERE slug = 'sled-push'), 'Sled Push', 4, '50m', 0),
  ('bbbbbbbb-0000-0000-0000-000033200004', (SELECT id FROM exercises WHERE slug = 'sled-pull'), 'Sled Pull', 4, '50m', 1);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000033200005', (SELECT id FROM exercises WHERE slug = 'plank'), 'Plank (cumul)', '180s', 0);

-- === Day 3: Rox Circuit Court ===============================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000033300000', '33333333-3333-3333-3333-000000000301', 3, 'hyrox',
   'Rox Circuit Court',
   '4 tours avec run 500m + 1 station tournante (wall ball / burpee broad jump / farmer carry / sandbag lunge).',
   45, 'mixed');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions, wod_format, time_cap_seconds) VALUES
  ('bbbbbbbb-0000-0000-0000-000033300001', 'aaaaaaaa-0000-0000-0000-000033300000', 'warmup', 0, 'Échauffement', '5 min jog easy + mobilité', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000033300002', 'aaaaaaaa-0000-0000-0000-000033300000', 'wod',    1, '4 rounds rox-style', 'For time, cap 35 min', 'for_time', 2100);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000033300001', (SELECT id FROM exercises WHERE slug = 'run'),          'Jog easy',      NULL, '5 min', 0),
  ('bbbbbbbb-0000-0000-0000-000033300001', (SELECT id FROM exercises WHERE slug = 'walking-lunge'), 'Walking Lunge', 2, '10/jambe', 1);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000033300002', (SELECT id FROM exercises WHERE slug = 'run'),                 'Run',              '500m', 0, 'Tour 1-4'),
  ('bbbbbbbb-0000-0000-0000-000033300002', (SELECT id FROM exercises WHERE slug = 'wall-ball'),           'Wall Ball',        '40',   1, 'Tour 1 uniquement'),
  ('bbbbbbbb-0000-0000-0000-000033300002', (SELECT id FROM exercises WHERE slug = 'burpee-broad-jump'),   'Burpee Broad Jump','20',   2, 'Tour 2 uniquement'),
  ('bbbbbbbb-0000-0000-0000-000033300002', (SELECT id FROM exercises WHERE slug = 'db-farmers-carry'),    'Farmer''s Carry',  '200m', 3, 'Tour 3 uniquement @ 2×22 kg'),
  ('bbbbbbbb-0000-0000-0000-000033300002', (SELECT id FROM exercises WHERE slug = 'sandbag-lunge'),       'Sandbag Lunge',    '50m',  4, 'Tour 4 uniquement @ 20 kg');

-- === Day 4: Tempo Run + Row =================================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000033400000', '33333333-3333-3333-3333-000000000301', 4, 'hyrox',
   'Tempo Run + Row',
   '5 km run au seuil aérobie puis 2 km row easy + mobilité.',
   55, 'none');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions) VALUES
  ('bbbbbbbb-0000-0000-0000-000033400001', 'aaaaaaaa-0000-0000-0000-000033400000', 'warmup',  0, 'Jog + strides', '5 min jog easy + 4×20m strides'),
  ('bbbbbbbb-0000-0000-0000-000033400002', 'aaaaaaaa-0000-0000-0000-000033400000', 'wod',     1, '5 km tempo',    '80% HRmax, allure régulière'),
  ('bbbbbbbb-0000-0000-0000-000033400003', 'aaaaaaaa-0000-0000-0000-000033400000', 'cooldown',2, '2 km row easy', 'Retour au calme');

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000033400001', (SELECT id FROM exercises WHERE slug = 'run'), 'Easy Jog', '5 min', 0);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000033400002', (SELECT id FROM exercises WHERE slug = 'run'), 'Tempo Run', '5000m', 0, '80% HRmax');

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000033400003', (SELECT id FROM exercises WHERE slug = 'row-distance'), 'Row easy', '2000m', 0);

-- === Day 5: Compromised Run =================================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000033500000', '33333333-3333-3333-3333-000000000301', 5, 'hyrox',
   'Compromised Run',
   '3 tours : 400m run + 100m sandbag lunge + 400m run + 40 wall balls. Simulation fatigue Hyrox.',
   50, 'cardio');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions, wod_format, time_cap_seconds) VALUES
  ('bbbbbbbb-0000-0000-0000-000033500001', 'aaaaaaaa-0000-0000-0000-000033500000', 'warmup', 0, 'Bike + dynamic', '5 min bike', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000033500002', 'aaaaaaaa-0000-0000-0000-000033500000', 'wod',    1, '3 rounds Hyrox-feel', 'For time, cap 45 min', 'for_time', 2700);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000033500001', (SELECT id FROM exercises WHERE slug = 'bike-erg'), 'Bike',           '5 min', 0);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000033500002', (SELECT id FROM exercises WHERE slug = 'run'),           'Run',            '400m', 0, NULL),
  ('bbbbbbbb-0000-0000-0000-000033500002', (SELECT id FROM exercises WHERE slug = 'sandbag-lunge'), 'Sandbag Lunge',  '100m', 1, '@ 20 kg'),
  ('bbbbbbbb-0000-0000-0000-000033500002', (SELECT id FROM exercises WHERE slug = 'run'),           'Run',            '400m', 2, NULL),
  ('bbbbbbbb-0000-0000-0000-000033500002', (SELECT id FROM exercises WHERE slug = 'wall-ball'),     'Wall Ball',      '40',   3, NULL);

-- === Day 6: Active Recovery =================================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000033600000', '33333333-3333-3333-3333-000000000301', 6, 'hyrox',
   'Active Recovery',
   '30 min walk + mobilité + stretching statique.',
   40, 'none');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions) VALUES
  ('bbbbbbbb-0000-0000-0000-000033600001', 'aaaaaaaa-0000-0000-0000-000033600000', 'cooldown', 0, 'Walk', '30 min rythme conversationnel'),
  ('bbbbbbbb-0000-0000-0000-000033600002', 'aaaaaaaa-0000-0000-0000-000033600000', 'cooldown', 1, 'Stretching', '10 min mobilité + étirements');

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000033600001', (SELECT id FROM exercises WHERE slug = 'run'), 'Walk', '30 min', 0);

INSERT INTO block_exercises (block_id, exercise_name, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000033600002', 'Pigeon Pose',    '60s/côté', 0),
  ('bbbbbbbb-0000-0000-0000-000033600002', 'Couch Stretch',  '60s/côté', 1),
  ('bbbbbbbb-0000-0000-0000-000033600002', 'Thoracic Opener','60s',      2);

-- ============================================================
-- PROGRAM 4 — At Home — Days 2..6
-- ============================================================

-- === Day 2: DB/KB Conditioning ==============================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000044200000', '44444444-4444-4444-4444-000000000401', 2, 'home',
   'DB/KB Conditioning',
   'Haltères/kettlebell si dispo : thrusters + rows + goblet squats. Sinon variante bodyweight.',
   35, 'mixed');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions, wod_format, time_cap_seconds) VALUES
  ('bbbbbbbb-0000-0000-0000-000044200001', 'aaaaaaaa-0000-0000-0000-000044200000', 'warmup', 0, 'Dynamic warmup', '2 tours easy', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000044200002', 'aaaaaaaa-0000-0000-0000-000044200000', 'wod',    1, '4 rounds for time', 'Enchaîner sans pause', 'for_time', 1200),
  ('bbbbbbbb-0000-0000-0000-000044200003', 'aaaaaaaa-0000-0000-0000-000044200000', 'finisher', 2, 'Core Tabata', '8× 20s/10s', 'tabata', 240);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000044200001', (SELECT id FROM exercises WHERE slug = 'air-squat'),       'Air Squat',     2, '15', 0),
  ('bbbbbbbb-0000-0000-0000-000044200001', (SELECT id FROM exercises WHERE slug = 'walking-lunge'),   'Walking Lunge', 2, '10/jambe', 1),
  ('bbbbbbbb-0000-0000-0000-000044200001', (SELECT id FROM exercises WHERE slug = 'push-up'),         'Push-up',       2, '10', 2);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000044200002', (SELECT id FROM exercises WHERE slug = 'db-thruster'),   'DB Thruster',   '15', 0, '@ 2×15 kg'),
  ('bbbbbbbb-0000-0000-0000-000044200002', (SELECT id FROM exercises WHERE slug = 'lateral-lunge'), 'Lateral Lunge', '20', 1, NULL),
  ('bbbbbbbb-0000-0000-0000-000044200002', (SELECT id FROM exercises WHERE slug = 'push-up'),       'Push-up',       '15', 2, NULL);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000044200003', (SELECT id FROM exercises WHERE slug = 'hollow-hold'),      'Hollow Hold',     '20s', 0, 'Tabata'),
  ('bbbbbbbb-0000-0000-0000-000044200003', (SELECT id FROM exercises WHERE slug = 'mountain-climber'), 'Mountain Climber','20s', 1, 'Tabata');

-- === Day 3: Gymnastics-Lite =================================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000044300000', '44444444-4444-4444-4444-000000000401', 3, 'home',
   'Gymnastics-Lite',
   'Pike push-ups, wall walks, ring/inverted rows, pistol progressions.',
   40, 'core');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions) VALUES
  ('bbbbbbbb-0000-0000-0000-000044300001', 'aaaaaaaa-0000-0000-0000-000044300000', 'warmup', 0, 'Mobilité',        '5 min cat-cow + cercles hanches'),
  ('bbbbbbbb-0000-0000-0000-000044300002', 'aaaaaaaa-0000-0000-0000-000044300000', 'skill',  1, 'Gymnastique',     '5 séries, 90s repos'),
  ('bbbbbbbb-0000-0000-0000-000044300003', 'aaaaaaaa-0000-0000-0000-000044300000', 'finisher', 2, 'Isométrique',   '3 tours, 30s chaque');

INSERT INTO block_exercises (block_id, exercise_name, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000044300001', 'Cat-Cow',             '20 reps', 0),
  ('bbbbbbbb-0000-0000-0000-000044300001', 'Hip Circles',         '10/sens', 1),
  ('bbbbbbbb-0000-0000-0000-000044300001', 'Arm Circles',         '10/sens', 2);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, rest_seconds, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000044300002', (SELECT id FROM exercises WHERE slug = 'wall-walk'),      'Wall Walk',      5, '1', 90, 0),
  ('bbbbbbbb-0000-0000-0000-000044300002', (SELECT id FROM exercises WHERE slug = 'pike-push-up'),   'Pike Push-up',   5, '8', 60, 1),
  ('bbbbbbbb-0000-0000-0000-000044300002', (SELECT id FROM exercises WHERE slug = 'ring-row'),       'Ring/Inverted Row', 5, '10', 60, 2);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000044300003', (SELECT id FROM exercises WHERE slug = 'hollow-hold'), 'Hollow Hold', '30s', 0),
  ('bbbbbbbb-0000-0000-0000-000044300003', (SELECT id FROM exercises WHERE slug = 'arch-hold'),   'Arch Hold',   '30s', 1),
  ('bbbbbbbb-0000-0000-0000-000044300003', (SELECT id FROM exercises WHERE slug = 'l-sit'),       'L-Sit',       '20s', 2);

-- === Day 4: Cardio & Core ===================================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000044400000', '44444444-4444-4444-4444-000000000401', 4, 'home',
   'Cardio & Core',
   'EMOM 20 min : burpees / mountain climbers / double unders / hollow rocks.',
   30, 'cardio');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions, wod_format, time_cap_seconds) VALUES
  ('bbbbbbbb-0000-0000-0000-000044400001', 'aaaaaaaa-0000-0000-0000-000044400000', 'warmup', 0, 'Jumping Jacks + squats', '2 tours', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000044400002', 'aaaaaaaa-0000-0000-0000-000044400000', 'wod',    1, 'EMOM 20 min', 'Rotation 4 exos', 'emom', 1200);

INSERT INTO block_exercises (block_id, exercise_name, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000044400001', 'Jumping Jacks',      '30', 0),
  ('bbbbbbbb-0000-0000-0000-000044400001', 'Air Squat',          '15', 1);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000044400002', (SELECT id FROM exercises WHERE slug = 'burpee'),           'Burpee',           '10', 0, 'Min 1, 5, 9, 13, 17'),
  ('bbbbbbbb-0000-0000-0000-000044400002', (SELECT id FROM exercises WHERE slug = 'mountain-climber'), 'Mountain Climber', '30', 1, 'Min 2, 6, 10, 14, 18'),
  ('bbbbbbbb-0000-0000-0000-000044400002', (SELECT id FROM exercises WHERE slug = 'double-under'),     'Double Under',     '40', 2, 'Min 3, 7, 11, 15, 19 (ou 80 single unders)'),
  ('bbbbbbbb-0000-0000-0000-000044400002', (SELECT id FROM exercises WHERE slug = 'hollow-rock'),      'Hollow Rock',      '20', 3, 'Min 4, 8, 12, 16, 20');

-- === Day 5: Mixed Full Body =================================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000044500000', '44444444-4444-4444-4444-000000000401', 5, 'home',
   'Mixed Full Body',
   '5 tours : 12 DB thrusters + 15 push-ups + 20 walking lunges + 10 burpees. For time.',
   35, 'mixed');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions, wod_format, time_cap_seconds) VALUES
  ('bbbbbbbb-0000-0000-0000-000044500001', 'aaaaaaaa-0000-0000-0000-000044500000', 'warmup', 0, 'Warmup', '2 tours à rythme facile', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000044500002', 'aaaaaaaa-0000-0000-0000-000044500000', 'wod',    1, '5 rounds for time', 'Cap 25 min', 'for_time', 1500);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000044500001', (SELECT id FROM exercises WHERE slug = 'air-squat'),      'Air Squat',     2, '15', 0),
  ('bbbbbbbb-0000-0000-0000-000044500001', (SELECT id FROM exercises WHERE slug = 'walking-lunge'),  'Walking Lunge', 2, '10/jambe', 1),
  ('bbbbbbbb-0000-0000-0000-000044500001', (SELECT id FROM exercises WHERE slug = 'push-up'),        'Push-up',       2, '8', 2);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000044500002', (SELECT id FROM exercises WHERE slug = 'db-thruster'),   'DB Thruster',   '12', 0, '@ 2×15 kg'),
  ('bbbbbbbb-0000-0000-0000-000044500002', (SELECT id FROM exercises WHERE slug = 'push-up'),       'Push-up',       '15', 1, NULL),
  ('bbbbbbbb-0000-0000-0000-000044500002', (SELECT id FROM exercises WHERE slug = 'walking-lunge'), 'Walking Lunge', '20', 2, NULL),
  ('bbbbbbbb-0000-0000-0000-000044500002', (SELECT id FROM exercises WHERE slug = 'burpee'),        'Burpee',        '10', 3, NULL);

-- === Day 6: Active Recovery =================================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000044600000', '44444444-4444-4444-4444-000000000401', 6, 'home',
   'Active Recovery',
   '30 min walk + stretching + mobilité épaules/hanches.',
   30, 'none');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions) VALUES
  ('bbbbbbbb-0000-0000-0000-000044600001', 'aaaaaaaa-0000-0000-0000-000044600000', 'cooldown', 0, 'Walk',       '30 min rythme conversationnel'),
  ('bbbbbbbb-0000-0000-0000-000044600002', 'aaaaaaaa-0000-0000-0000-000044600000', 'cooldown', 1, 'Stretching', '10 min mobilité');

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000044600001', (SELECT id FROM exercises WHERE slug = 'run'), 'Walk', '30 min', 0);

INSERT INTO block_exercises (block_id, exercise_name, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000044600002', 'Pigeon Pose',       '60s/côté', 0),
  ('bbbbbbbb-0000-0000-0000-000044600002', 'Couch Stretch',     '60s/côté', 1),
  ('bbbbbbbb-0000-0000-0000-000044600002', 'Shoulder Dislocates','15 reps', 2);
