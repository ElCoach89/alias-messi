-- ============================================================
-- El Coach — Week 1 Sessions for all 4 Programs
-- ============================================================
-- Day 1 is fully detailed (warmup + strength + WOD + finisher)
-- for each program — use it as a quality reference.
-- Days 2..N are session shells (name + duration + finisher_type)
-- so the weekly structure is visible; flesh them out iteratively.
--
-- UUID scheme:
--   Sessions: aaaaaaaa-0000-0000-0000-0000{P}{W}{D}00000  — P=program, W=week, D=day
--   Blocks:   bbbbbbbb-0000-0000-0000-0000{P}{W}{D}000{O} — O=block order
-- ============================================================

-- ============================================================
-- PROGRAM 1 — CrossFit Pure — Week 1 (6 days)
-- ============================================================

-- --- Day 1: Upper Strength + MetCon --------------------------

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000011100000',
   '11111111-1111-1111-1111-000000000101',
   1, 'crossfit',
   'Upper Strength + MetCon',
   'Force en presse verticale puis conditionnement court avec pull-ups et KB swings.',
   55, 'core');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions, wod_format, time_cap_seconds) VALUES
  ('bbbbbbbb-0000-0000-0000-000011100001', 'aaaaaaaa-0000-0000-0000-000011100000', 'warmup',   0, 'General Warm-up', '2 tours à rythme facile', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000011100002', 'aaaaaaaa-0000-0000-0000-000011100000', 'strength', 1, 'Strict Press', 'Monter progressivement jusqu''aux séries de travail', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000011100003', 'aaaaaaaa-0000-0000-0000-000011100000', 'wod',      2, 'Helen-lite', 'AMRAP 15 minutes', 'amrap', 900),
  ('bbbbbbbb-0000-0000-0000-000011100004', 'aaaaaaaa-0000-0000-0000-000011100000', 'finisher', 3, 'Core Circuit', '3 tours sans interruption', NULL, NULL);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000011100001', (SELECT id FROM exercises WHERE slug = 'row-distance'),   'Row',                NULL, '400m', 0, NULL),
  ('bbbbbbbb-0000-0000-0000-000011100001', (SELECT id FROM exercises WHERE slug = 'air-squat'),      'Air Squat',          NULL, '15',   1, NULL),
  ('bbbbbbbb-0000-0000-0000-000011100001', (SELECT id FROM exercises WHERE slug = 'push-up'),        'Push-up',            NULL, '10',   2, NULL),
  ('bbbbbbbb-0000-0000-0000-000011100001', (SELECT id FROM exercises WHERE slug = 'single-under'),   'Single Unders',      NULL, '40',   3, NULL);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, weight_percentage, rest_seconds, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000011100002', (SELECT id FROM exercises WHERE slug = 'strict-press'),   'Strict Press',       5, '5', 70, 120, 0);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000011100003', (SELECT id FROM exercises WHERE slug = 'run'),              'Run',                0, '400m'),
  ('bbbbbbbb-0000-0000-0000-000011100003', (SELECT id FROM exercises WHERE slug = 'kb-swing-russian'), 'KB Swing Russian',   1, '21 reps @ 24/16 kg'),
  ('bbbbbbbb-0000-0000-0000-000011100003', (SELECT id FROM exercises WHERE slug = 'kipping-pull-up'),  'Pull-up (kipping)',  2, '12 reps');

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000011100004', (SELECT id FROM exercises WHERE slug = 'plank'),         'Plank Hold',         3, '45s', 0),
  ('bbbbbbbb-0000-0000-0000-000011100004', (SELECT id FROM exercises WHERE slug = 'v-up'),          'V-up',               3, '15',  1),
  ('bbbbbbbb-0000-0000-0000-000011100004', (SELECT id FROM exercises WHERE slug = 'russian-twist'), 'Russian Twist',      3, '20',  2);

-- --- Day 2..6: Session shells --------------------------------

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000011200000', '11111111-1111-1111-1111-000000000101', 2, 'crossfit', 'Lower Strength + Conditioning',
   'Back Squat progressif puis échelle de squat cleans + bar-facing burpees.', 55, 'cardio'),
  ('aaaaaaaa-0000-0000-0000-000011300000', '11111111-1111-1111-1111-000000000101', 3, 'crossfit', 'Olympic + Gymnastics',
   'Technique snatch puis EMOM mélangeant T2B et calorie row.', 60, 'core'),
  ('aaaaaaaa-0000-0000-0000-000011400000', '11111111-1111-1111-1111-000000000101', 4, 'crossfit', 'Deadlift + HSPU EMOM',
   'Deadlift lourd puis EMOM alternant HSPU et box jumps.', 55, 'cardio'),
  ('aaaaaaaa-0000-0000-0000-000011500000', '11111111-1111-1111-1111-000000000101', 5, 'crossfit', 'Benchmark "Cindy"',
   '20 min AMRAP : 5 pull-ups / 10 push-ups / 15 air squats.', 45, 'mixed'),
  ('aaaaaaaa-0000-0000-0000-000011600000', '11111111-1111-1111-1111-000000000101', 6, 'crossfit', 'Active Recovery',
   'Marche ou rameur facile 20 min + mobilité hanches/épaules.', 30, 'none');

-- ============================================================
-- PROGRAM 2 — Hybride — Week 1 (7 days incl. adaptive cooldown)
-- ============================================================

-- --- Day 1: Push musculation ---------------------------------

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000022100000',
   '22222222-2222-2222-2222-000000000201',
   1, 'strength',
   'Push — Pec / Épaule / Triceps',
   'Séance de musculation structurée : bench lourd, strict press, puis accessoires haltères.',
   65, 'none');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions) VALUES
  ('bbbbbbbb-0000-0000-0000-000022100001', 'aaaaaaaa-0000-0000-0000-000022100000', 'warmup',   0, 'Activation épaules', '5 min bike + mobilité + activation bandes'),
  ('bbbbbbbb-0000-0000-0000-000022100002', 'aaaaaaaa-0000-0000-0000-000022100000', 'strength', 1, 'Bench Press', 'Monter en pyramide jusqu''aux séries de travail'),
  ('bbbbbbbb-0000-0000-0000-000022100003', 'aaaaaaaa-0000-0000-0000-000022100000', 'strength', 2, 'Strict Press', 'Cadence maîtrisée, pas de momentum'),
  ('bbbbbbbb-0000-0000-0000-000022100004', 'aaaaaaaa-0000-0000-0000-000022100000', 'strength', 3, 'Accessoires DB', '3 tours, 60s repos'),
  ('bbbbbbbb-0000-0000-0000-000022100005', 'aaaaaaaa-0000-0000-0000-000022100000', 'finisher', 4, 'Finisher Push', 'AMRAP 8 min');

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000022100001', (SELECT id FROM exercises WHERE slug = 'bike-erg'),      'Bike Erg (easy)',     NULL, '5 min', 0),
  ('bbbbbbbb-0000-0000-0000-000022100001', (SELECT id FROM exercises WHERE slug = 'push-up'),       'Push-up',             2, '10', 1);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, weight_percentage, rest_seconds, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000022100002', (SELECT id FROM exercises WHERE slug = 'bench-press'),   'Bench Press',         5, '5', 70, 150, 0),
  ('bbbbbbbb-0000-0000-0000-000022100003', (SELECT id FROM exercises WHERE slug = 'strict-press'),  'Strict Press',        4, '8', 60, 120, 0);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, rest_seconds, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000022100004', (SELECT id FROM exercises WHERE slug = 'bench-press-db'),        'DB Bench Press',         3, '10', 60, 0),
  ('bbbbbbbb-0000-0000-0000-000022100004', (SELECT id FROM exercises WHERE slug = 'db-shoulder-to-overhead'),'DB Shoulder-to-OH',     3, '12', 60, 1);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000022100005', (SELECT id FROM exercises WHERE slug = 'hrpu'),       'Hand Release Push-up', NULL, '10', 0, 'AMRAP 8 min'),
  ('bbbbbbbb-0000-0000-0000-000022100005', (SELECT id FROM exercises WHERE slug = 'ring-dip'),   'Ring Dip',             NULL, '8',  1, NULL),
  ('bbbbbbbb-0000-0000-0000-000022100005', (SELECT id FROM exercises WHERE slug = 'plank'),      'Plank',                NULL, '30s', 2, NULL);

-- --- Day 2..7: Session shells --------------------------------

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type, is_adaptive_cooldown, default_cooldown_activity) VALUES
  ('aaaaaaaa-0000-0000-0000-000022200000', '22222222-2222-2222-2222-000000000201', 2, 'crossfit', 'WOD Upper Focus',
   '"Grace"-style : 30 Clean & Jerk for time (55/35 kg).', 35, 'cardio', FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000022300000', '22222222-2222-2222-2222-000000000201', 3, 'strength', 'Pull — Dos / Biceps',
   'Deadlift lourd, pull-ups, DB rows, finisher band curls.', 65, 'none', FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000022400000', '22222222-2222-2222-2222-000000000201', 4, 'crossfit', 'WOD Lower Focus',
   '"Karen"-style : 150 wall balls for time (9/6 kg).', 25, 'core', FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000022500000', '22222222-2222-2222-2222-000000000201', 5, 'strength', 'Legs — Quads / Postérieurs',
   'Back Squat, RDL, front rack lunges, calf/core finisher.', 70, 'none', FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000022600000', '22222222-2222-2222-2222-000000000201', 6, 'crossfit', 'WOD Engine Mixte',
   'Triplette : 500m row / 20 DB snatch / 15 burpee box jump over. 3 tours.', 30, 'mixed', FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000022700000', '22222222-2222-2222-2222-000000000201', 7, 'cooldown', 'Cooldown adaptatif',
   'Activité choisie par le moteur selon la fatigue de la semaine : walk (fatigue faible) / run léger (stable) / boxe ou swim (modéré) / repos complet (élevé).', 30, 'none', TRUE, 'walk');

-- ============================================================
-- PROGRAM 3 — Hyrox Pure — Week 1 (6 days)
-- ============================================================

-- --- Day 1: Rox Base ----------------------------------------

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000033100000',
   '33333333-3333-3333-3333-000000000301',
   1, 'hyrox',
   'Rox Base — Run + Ski + Core',
   'Intervalles run/ski pour poser la base aérobie Hyrox, finisher gainage + lunges.',
   55, 'core');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions, wod_format, time_cap_seconds) VALUES
  ('bbbbbbbb-0000-0000-0000-000033100001', 'aaaaaaaa-0000-0000-0000-000033100000', 'warmup',   0, 'Mobilité + activation', 'Hanches, chevilles, bassin', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000033100002', 'aaaaaaaa-0000-0000-0000-000033100000', 'wod',      1, 'Intervalles Run + Ski', '4 tours, 1 min de repos entre tours', 'for_time', 2400),
  ('bbbbbbbb-0000-0000-0000-000033100003', 'aaaaaaaa-0000-0000-0000-000033100000', 'finisher', 2, 'Core + Lunges Finisher', '3 tours enchaînés', NULL, NULL);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000033100001', (SELECT id FROM exercises WHERE slug = 'ski-erg'),         'Ski Erg (easy)',      NULL, '5 min', 0),
  ('bbbbbbbb-0000-0000-0000-000033100001', (SELECT id FROM exercises WHERE slug = 'walking-lunge'),   'Walking Lunge',       NULL, '20',    1),
  ('bbbbbbbb-0000-0000-0000-000033100001', (SELECT id FROM exercises WHERE slug = 'air-squat'),       'Air Squat',           NULL, '15',    2);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000033100002', (SELECT id FROM exercises WHERE slug = 'run'),     'Run',     0, '800m par tour'),
  ('bbbbbbbb-0000-0000-0000-000033100002', (SELECT id FROM exercises WHERE slug = 'ski-erg'), 'Ski Erg', 1, '500m par tour');

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000033100003', (SELECT id FROM exercises WHERE slug = 'sit-up'),           'Sit-up',            3, '20', 0),
  ('bbbbbbbb-0000-0000-0000-000033100003', (SELECT id FROM exercises WHERE slug = 'mountain-climber'), 'Mountain Climber',  3, '20', 1),
  ('bbbbbbbb-0000-0000-0000-000033100003', (SELECT id FROM exercises WHERE slug = 'walking-lunge'),    'Walking Lunge',     3, '20', 2);

-- --- Day 2..6: Session shells --------------------------------

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000033200000', '33333333-3333-3333-3333-000000000301', 2, 'hyrox', 'Strength Base + Sled',
   'Back Squat 5×5, Deadlift 4×4, puis 4×50 m sled push + 50 m sled pull.', 65, 'none'),
  ('aaaaaaaa-0000-0000-0000-000033300000', '33333333-3333-3333-3333-000000000301', 3, 'hyrox', 'Rox Circuit court',
   '4 tours : 500 m run + 1 station tournante (wall ball / burpee broad jump / farmer''s carry / sandbag lunge).', 45, 'mixed'),
  ('aaaaaaaa-0000-0000-0000-000033400000', '33333333-3333-3333-3333-000000000301', 4, 'hyrox', 'Tempo Run + Row',
   '5 km run au seuil aérobie puis 2 km row easy + mobilité.', 55, 'none'),
  ('aaaaaaaa-0000-0000-0000-000033500000', '33333333-3333-3333-3333-000000000301', 5, 'hyrox', 'Compromised Run',
   '3×(400m run + 100m sandbag lunge + 400m run + 40 wall balls). Simulation de fatigue Hyrox.', 50, 'cardio'),
  ('aaaaaaaa-0000-0000-0000-000033600000', '33333333-3333-3333-3333-000000000301', 6, 'hyrox', 'Active Recovery',
   'Marche 30 min + mobilité + stretching statique.', 40, 'none');

-- ============================================================
-- PROGRAM 4 — At Home — Week 1 (6 days)
-- ============================================================

-- --- Day 1: Full Body Bodyweight ----------------------------

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000044100000',
   '44444444-4444-4444-4444-000000000401',
   1, 'home',
   'Full Body Bodyweight',
   'Poids du corps uniquement — base poussée + tirage + squat + core. Peu d''espace nécessaire.',
   35, 'core');

INSERT INTO workout_blocks (id, session_id, block_type, order_index, name, instructions, wod_format, time_cap_seconds) VALUES
  ('bbbbbbbb-0000-0000-0000-000044100001', 'aaaaaaaa-0000-0000-0000-000044100000', 'warmup',   0, 'Échauffement',         '2 tours, rythme facile', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000044100002', 'aaaaaaaa-0000-0000-0000-000044100000', 'skill',    1, 'Push-up progression',  '5 séries, 60s de repos', NULL, NULL),
  ('bbbbbbbb-0000-0000-0000-000044100003', 'aaaaaaaa-0000-0000-0000-000044100000', 'wod',      2, 'AMRAP "Cindy-lite"',   'AMRAP 12 minutes', 'amrap', 720),
  ('bbbbbbbb-0000-0000-0000-000044100004', 'aaaaaaaa-0000-0000-0000-000044100000', 'finisher', 3, 'Core Tabata',          '8 tours, 20s effort / 10s repos', 'tabata', 240);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000044100001', (SELECT id FROM exercises WHERE slug = 'air-squat'),      'Air Squat',         NULL, '20', 0),
  ('bbbbbbbb-0000-0000-0000-000044100001', (SELECT id FROM exercises WHERE slug = 'push-up'),        'Push-up',           NULL, '10', 1),
  ('bbbbbbbb-0000-0000-0000-000044100001', (SELECT id FROM exercises WHERE slug = 'walking-lunge'),  'Walking Lunge',     NULL, '10 par jambe', 2),
  ('bbbbbbbb-0000-0000-0000-000044100001', (SELECT id FROM exercises WHERE slug = 'hollow-rock'),    'Hollow Rock',       NULL, '15', 3);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, sets, reps, rest_seconds, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000044100002', (SELECT id FROM exercises WHERE slug = 'push-up'),  'Push-up',    5, 'max', 60, 0, 'Scale : sur les genoux ou contre un mur si besoin');

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index) VALUES
  ('bbbbbbbb-0000-0000-0000-000044100003', (SELECT id FROM exercises WHERE slug = 'air-squat'),  'Air Squat',  '10', 0),
  ('bbbbbbbb-0000-0000-0000-000044100003', (SELECT id FROM exercises WHERE slug = 'push-up'),    'Push-up',    '10', 1),
  ('bbbbbbbb-0000-0000-0000-000044100003', (SELECT id FROM exercises WHERE slug = 'sit-up'),     'Sit-up',     '10', 2);

INSERT INTO block_exercises (block_id, exercise_id, exercise_name, reps, order_index, notes) VALUES
  ('bbbbbbbb-0000-0000-0000-000044100004', (SELECT id FROM exercises WHERE slug = 'plank'),              'Plank',             '20s', 0, 'Tabata'),
  ('bbbbbbbb-0000-0000-0000-000044100004', (SELECT id FROM exercises WHERE slug = 'hollow-hold'),        'Hollow Body Hold',  '20s', 1, 'Tabata'),
  ('bbbbbbbb-0000-0000-0000-000044100004', (SELECT id FROM exercises WHERE slug = 'mountain-climber'),   'Mountain Climber',  '20s', 2, 'Tabata');

-- --- Day 2..6: Session shells --------------------------------

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  ('aaaaaaaa-0000-0000-0000-000044200000', '44444444-4444-4444-4444-000000000401', 2, 'home', 'DB/KB Conditioning',
   'Si haltères/kettlebell dispo : DB thrusters + DB rows + goblet squats. Sinon : intervalles HIIT bodyweight.', 35, 'mixed'),
  ('aaaaaaaa-0000-0000-0000-000044300000', '44444444-4444-4444-4444-000000000401', 3, 'home', 'Gymnastics-Lite',
   'Pike push-ups, wall walks, ring/inverted rows, pistol progressions.', 40, 'core'),
  ('aaaaaaaa-0000-0000-0000-000044400000', '44444444-4444-4444-4444-000000000401', 4, 'home', 'Cardio & Core',
   'Burpees + mountain climbers + double-unders + hollow rocks — intervalles EMOM 20 min.', 30, 'cardio'),
  ('aaaaaaaa-0000-0000-0000-000044500000', '44444444-4444-4444-4444-000000000401', 5, 'home', 'Mixed Full Body',
   'DB thruster + push-up + walking lunge + burpee — 5 tours pour le temps.', 35, 'mixed'),
  ('aaaaaaaa-0000-0000-0000-000044600000', '44444444-4444-4444-4444-000000000401', 6, 'home', 'Active Recovery',
   'Marche 30 min + stretching + mobilité épaules/hanches.', 30, 'none');
