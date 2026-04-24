-- ============================================================
-- El Coach — Weeks 2..6 Session Shells (all 4 programs)
-- ============================================================
-- Session rows only (name, description, duration, finisher_type).
-- Blocks/exercises NOT seeded — fill them in per-program as the
-- coach validates progression. Themes follow the macro-cycle:
--   W2 Build      (0.90) → volume up
--   W3 Intensity  (0.95) → denser WODs, tougher finishers
--   W4 Peak       (1.00) → heaviest week
--   W5 Deload     (0.80) → recovery volume
--   W6 Test       (1.05) → 1RM attempts + benchmarks
-- ============================================================

-- ============================================================
-- PROGRAM 1 — CrossFit Pure — Weeks 2..6
-- ============================================================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  -- Week 2 (Build)
  ('aaaaaaaa-0000-0000-0000-000012100000', '11111111-1111-1111-1111-000000000102', 1, 'crossfit', 'Upper Strength + MetCon (Build)',   'Strict Press 5×4 @75%, WOD plus dense (+10% volume).',          55, 'core'),
  ('aaaaaaaa-0000-0000-0000-000012200000', '11111111-1111-1111-1111-000000000102', 2, 'crossfit', 'Lower Strength + Conditioning',     'Back Squat 5×4 @80%, couple squat clean + burpee plus long.',   55, 'cardio'),
  ('aaaaaaaa-0000-0000-0000-000012300000', '11111111-1111-1111-1111-000000000102', 3, 'crossfit', 'Olympic + Gymnastics',              'Snatch EMOM 10 min + T2B/row/push press plus dense.',           60, 'core'),
  ('aaaaaaaa-0000-0000-0000-000012400000', '11111111-1111-1111-1111-000000000102', 4, 'crossfit', 'Deadlift + HSPU',                   'Deadlift 5×3 @82%, EMOM 22 min HSPU/Box Jump.',                 55, 'cardio'),
  ('aaaaaaaa-0000-0000-0000-000012500000', '11111111-1111-1111-1111-000000000102', 5, 'crossfit', 'Girl WOD — Fran',                   '21-15-9 Thrusters (43/29 kg) + Pull-ups for time.',             35, 'none'),
  ('aaaaaaaa-0000-0000-0000-000012600000', '11111111-1111-1111-1111-000000000102', 6, 'crossfit', 'Active Recovery',                   '25 min low-intensity + mobilité.',                              30, 'none'),
  -- Week 3 (Intensity)
  ('aaaaaaaa-0000-0000-0000-000013100000', '11111111-1111-1111-1111-000000000103', 1, 'crossfit', 'Upper Strength + Intervalle dense', 'Strict Press 5×3 @82%, EMOM plus serré.',                       55, 'core'),
  ('aaaaaaaa-0000-0000-0000-000013200000', '11111111-1111-1111-1111-000000000103', 2, 'crossfit', 'Lower + Conditioning Intensité',    'Back Squat 5×3 @85%, WOD for time avec cap serré.',             55, 'cardio'),
  ('aaaaaaaa-0000-0000-0000-000013300000', '11111111-1111-1111-1111-000000000103', 3, 'crossfit', 'Snatch Complex + Gym',              'Snatch Complex + AMRAP gym (pull-ups / HSPU / C2B).',           60, 'core'),
  ('aaaaaaaa-0000-0000-0000-000013400000', '11111111-1111-1111-1111-000000000103', 4, 'crossfit', 'Deadlift Heavy + Engine',           'Deadlift 4×3 @85%, EMOM 20 min engine.',                        55, 'cardio'),
  ('aaaaaaaa-0000-0000-0000-000013500000', '11111111-1111-1111-1111-000000000103', 5, 'crossfit', 'Girl WOD — Helen',                  '3 tours : 400m run + 21 KB swings (24/16) + 12 pull-ups.',      35, 'none'),
  ('aaaaaaaa-0000-0000-0000-000013600000', '11111111-1111-1111-1111-000000000103', 6, 'crossfit', 'Active Recovery',                   'Row ou marche facile 20 min + mobilité.',                       30, 'none'),
  -- Week 4 (Peak)
  ('aaaaaaaa-0000-0000-0000-000014100000', '11111111-1111-1111-1111-000000000104', 1, 'crossfit', 'Upper Heavy',                       'Strict Press 5×2 @87%, WOD court et intense.',                  55, 'core'),
  ('aaaaaaaa-0000-0000-0000-000014200000', '11111111-1111-1111-1111-000000000104', 2, 'crossfit', 'Lower Heavy',                       'Back Squat 5×2 @90%, 21-15-9 cleans/burpees.',                  55, 'cardio'),
  ('aaaaaaaa-0000-0000-0000-000014300000', '11111111-1111-1111-1111-000000000104', 3, 'crossfit', 'Olympic Peak',                      'Snatch jusqu''à 90% 1RM + WOD court.',                          60, 'core'),
  ('aaaaaaaa-0000-0000-0000-000014400000', '11111111-1111-1111-1111-000000000104', 4, 'crossfit', 'Deadlift Peak',                     'Deadlift 3×2 @90%, EMOM dense.',                                55, 'cardio'),
  ('aaaaaaaa-0000-0000-0000-000014500000', '11111111-1111-1111-1111-000000000104', 5, 'crossfit', 'Girl WOD — Diane',                  '21-15-9 Deadlifts (102/70 kg) + HSPU for time.',                35, 'none'),
  ('aaaaaaaa-0000-0000-0000-000014600000', '11111111-1111-1111-1111-000000000104', 6, 'crossfit', 'Active Recovery',                   'Cooldown + stretching complet.',                                30, 'none'),
  -- Week 5 (Deload)
  ('aaaaaaaa-0000-0000-0000-000015100000', '11111111-1111-1111-1111-000000000105', 1, 'crossfit', 'Upper Deload',                      'Strict Press 3×8 @60%, WOD bodyweight focus.',                  45, 'core'),
  ('aaaaaaaa-0000-0000-0000-000015200000', '11111111-1111-1111-1111-000000000105', 2, 'crossfit', 'Lower Deload',                      'Back Squat 3×10 @55%, jog + air squats.',                       45, 'cardio'),
  ('aaaaaaaa-0000-0000-0000-000015300000', '11111111-1111-1111-1111-000000000105', 3, 'crossfit', 'Skill Day',                         'Technique snatch légère + gym skill work (HS walk / C2B).',     45, 'none'),
  ('aaaaaaaa-0000-0000-0000-000015400000', '11111111-1111-1111-1111-000000000105', 4, 'crossfit', 'Pull/Push Deload',                  'Deadlift 3×5 @60%, push-ups + ring rows.',                      45, 'cardio'),
  ('aaaaaaaa-0000-0000-0000-000015500000', '11111111-1111-1111-1111-000000000105', 5, 'crossfit', 'Aerobic Base',                      '40 min Z2 (bike ou row ou course).',                            40, 'none'),
  ('aaaaaaaa-0000-0000-0000-000015600000', '11111111-1111-1111-1111-000000000105', 6, 'crossfit', 'Active Recovery',                   'Stretching + mobilité + walking.',                              30, 'none'),
  -- Week 6 (Test)
  ('aaaaaaaa-0000-0000-0000-000016100000', '11111111-1111-1111-1111-000000000106', 1, 'crossfit', 'Test 1RM Strict Press',             'Warmup progressif, 3-5 essais à 1RM.',                          45, 'none'),
  ('aaaaaaaa-0000-0000-0000-000016200000', '11111111-1111-1111-1111-000000000106', 2, 'crossfit', 'Test 1RM Back Squat',               'Warmup progressif, 3-5 essais à 1RM.',                          50, 'none'),
  ('aaaaaaaa-0000-0000-0000-000016300000', '11111111-1111-1111-1111-000000000106', 3, 'crossfit', 'Test 1RM Snatch',                   'Technique + tentatives 1RM.',                                   55, 'none'),
  ('aaaaaaaa-0000-0000-0000-000016400000', '11111111-1111-1111-1111-000000000106', 4, 'crossfit', 'Test 1RM Deadlift',                 'Warmup progressif, 3-5 essais à 1RM.',                          50, 'none'),
  ('aaaaaaaa-0000-0000-0000-000016500000', '11111111-1111-1111-1111-000000000106', 5, 'crossfit', 'Retest Cindy',                      'AMRAP 20 min — comparer au score W1 D5.',                       45, 'none'),
  ('aaaaaaaa-0000-0000-0000-000016600000', '11111111-1111-1111-1111-000000000106', 6, 'crossfit', 'Active Recovery',                   'Décompression + célébration.',                                  30, 'none');

-- ============================================================
-- PROGRAM 2 — Hybride — Weeks 2..6 (Day 7 = adaptive cooldown)
-- ============================================================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type, is_adaptive_cooldown, default_cooldown_activity) VALUES
  -- Week 2
  ('aaaaaaaa-0000-0000-0000-000022110000', '22222222-2222-2222-2222-000000000202', 1, 'strength', 'Push — Build',               'Bench 5×4 @75%, Strict Press 4×6 @65%.',     65, 'none',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000022210000', '22222222-2222-2222-2222-000000000202', 2, 'crossfit', 'WOD Upper — Diane',          'Benchmark Diane : 21-15-9 DL + HSPU.',       35, 'cardio',   FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000022310000', '22222222-2222-2222-2222-000000000202', 3, 'strength', 'Pull — Build',               'Deadlift 5×4 @80%, pull-ups lestés.',         65, 'none',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000022410000', '22222222-2222-2222-2222-000000000202', 4, 'crossfit', 'WOD Lower — Annie',          '50-40-30-20-10 DU + Sit-ups for time.',       25, 'core',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000022510000', '22222222-2222-2222-2222-000000000202', 5, 'strength', 'Legs — Build',               'Back Squat 5×4 @80%, RDL 4×6.',               70, 'none',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000022610000', '22222222-2222-2222-2222-000000000202', 6, 'crossfit', 'WOD Engine',                 'Triplette plus longue (4 tours).',            35, 'mixed',    FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000022710000', '22222222-2222-2222-2222-000000000202', 7, 'cooldown', 'Cooldown adaptatif',         'Activité choisie selon fatigue semaine.',      30, 'none',     TRUE,  'walk'),
  -- Week 3
  ('aaaaaaaa-0000-0000-0000-000023110000', '22222222-2222-2222-2222-000000000203', 1, 'strength', 'Push — Intensity',           'Bench 5×3 @82%, DB variations plus lourdes.', 65, 'none',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000023210000', '22222222-2222-2222-2222-000000000203', 2, 'crossfit', 'WOD Upper — Fran',           '21-15-9 Thrusters + Pull-ups for time.',      30, 'cardio',   FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000023310000', '22222222-2222-2222-2222-000000000203', 3, 'strength', 'Pull — Intensity',           'Deadlift 5×3 @85%, chin-ups lestés.',         65, 'none',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000023410000', '22222222-2222-2222-2222-000000000203', 4, 'crossfit', 'WOD Lower — Karen+',         '2 tours 75 wall balls + 400m run.',           30, 'core',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000023510000', '22222222-2222-2222-2222-000000000203', 5, 'strength', 'Legs — Intensity',           'Back Squat 5×3 @85%, Hip Thrust 4×6.',        70, 'none',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000023610000', '22222222-2222-2222-2222-000000000203', 6, 'crossfit', 'WOD Mixed',                  'Chipper : rower + snatch + C2B + run.',       40, 'mixed',    FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000023710000', '22222222-2222-2222-2222-000000000203', 7, 'cooldown', 'Cooldown adaptatif',         'Activité choisie selon fatigue semaine.',      30, 'none',     TRUE,  'walk'),
  -- Week 4 (Peak)
  ('aaaaaaaa-0000-0000-0000-000024110000', '22222222-2222-2222-2222-000000000204', 1, 'strength', 'Push — Peak',                'Bench 5×2 @90%, Push Press 3×3 @85%.',        65, 'none',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000024210000', '22222222-2222-2222-2222-000000000204', 2, 'crossfit', 'WOD Upper — Elizabeth',      '21-15-9 Squat Cleans + Ring Dips.',           35, 'cardio',   FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000024310000', '22222222-2222-2222-2222-000000000204', 3, 'strength', 'Pull — Peak',                'Deadlift 3×2 @92%, pull-ups strict.',         65, 'none',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000024410000', '22222222-2222-2222-2222-000000000204', 4, 'crossfit', 'WOD Lower — Jackie',         '1000m row + 50 thrusters + 30 pull-ups.',     30, 'core',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000024510000', '22222222-2222-2222-2222-000000000204', 5, 'strength', 'Legs — Peak',                'Back Squat 3×2 @90%, Front Squat 3×3.',       70, 'none',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000024610000', '22222222-2222-2222-2222-000000000204', 6, 'crossfit', 'WOD Engine Long',            '40 min AMRAP row/bike/run alternés.',          45, 'mixed',    FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000024710000', '22222222-2222-2222-2222-000000000204', 7, 'cooldown', 'Cooldown adaptatif',         'Activité choisie selon fatigue semaine.',      30, 'none',     TRUE,  'walk'),
  -- Week 5 (Deload)
  ('aaaaaaaa-0000-0000-0000-000025110000', '22222222-2222-2222-2222-000000000205', 1, 'strength', 'Push — Deload',              'Bench 3×8 @55%, push-ups volume.',            50, 'none',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000025210000', '22222222-2222-2222-2222-000000000205', 2, 'crossfit', 'WOD léger',                  'AMRAP 12 min bodyweight.',                     30, 'none',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000025310000', '22222222-2222-2222-2222-000000000205', 3, 'strength', 'Pull — Deload',              'Deadlift 3×5 @60%, ring rows.',               50, 'none',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000025410000', '22222222-2222-2222-2222-000000000205', 4, 'crossfit', 'WOD core-focus',             '20 min AMRAP core + mobilité.',                30, 'core',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000025510000', '22222222-2222-2222-2222-000000000205', 5, 'strength', 'Legs — Deload',              'Back Squat 3×8 @55%, lunges légers.',         50, 'none',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000025610000', '22222222-2222-2222-2222-000000000205', 6, 'crossfit', 'Aerobic Z2',                 '40 min Z2 facile.',                            40, 'none',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000025710000', '22222222-2222-2222-2222-000000000205', 7, 'cooldown', 'Cooldown adaptatif',         'Repos par défaut en deload.',                  30, 'none',     TRUE,  'rest_complete'),
  -- Week 6 (Test)
  ('aaaaaaaa-0000-0000-0000-000026110000', '22222222-2222-2222-2222-000000000206', 1, 'strength', 'Test 1RM Bench + Press',     'Warmup progressif, tentatives 1RM.',           55, 'none',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000026210000', '22222222-2222-2222-2222-000000000206', 2, 'crossfit', 'Retest WOD W1 Day 2',        'Comparer score.',                               35, 'cardio',   FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000026310000', '22222222-2222-2222-2222-000000000206', 3, 'strength', 'Test 1RM Deadlift',          'Warmup progressif, tentatives 1RM.',           50, 'none',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000026410000', '22222222-2222-2222-2222-000000000206', 4, 'crossfit', 'Retest Karen',               '150 Wall Balls for time — comparer W1 D4.',    25, 'core',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000026510000', '22222222-2222-2222-2222-000000000206', 5, 'strength', 'Test 1RM Back Squat',        'Warmup progressif, tentatives 1RM.',           50, 'none',     FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000026610000', '22222222-2222-2222-2222-000000000206', 6, 'crossfit', 'Retest Engine Triplet',      'Comparer score W1 D6.',                         35, 'mixed',    FALSE, NULL),
  ('aaaaaaaa-0000-0000-0000-000026710000', '22222222-2222-2222-2222-000000000206', 7, 'cooldown', 'Cooldown adaptatif',         'Activité choisie selon fatigue semaine.',      30, 'none',     TRUE,  'walk');

-- ============================================================
-- PROGRAM 3 — Hyrox Pure — Weeks 2..6
-- ============================================================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  -- Week 2
  ('aaaaaaaa-0000-0000-0000-000032100000', '33333333-3333-3333-3333-000000000302', 1, 'hyrox', 'Rox Base — Build',            '5 tours run/ski (au lieu de 4), même distances.',            60, 'core'),
  ('aaaaaaaa-0000-0000-0000-000032200000', '33333333-3333-3333-3333-000000000302', 2, 'hyrox', 'Strength + Sled +volume',     'Back Squat 5×4 @75%, 6 tours sled au lieu de 4.',             65, 'none'),
  ('aaaaaaaa-0000-0000-0000-000032300000', '33333333-3333-3333-3333-000000000302', 3, 'hyrox', 'Rox Circuit Moyen',           '5 tours avec 2 stations par tour.',                           50, 'mixed'),
  ('aaaaaaaa-0000-0000-0000-000032400000', '33333333-3333-3333-3333-000000000302', 4, 'hyrox', 'Tempo 6km + Row',             '6 km tempo + 2 km row.',                                      60, 'none'),
  ('aaaaaaaa-0000-0000-0000-000032500000', '33333333-3333-3333-3333-000000000302', 5, 'hyrox', 'Compromised Run +round',      '4 tours au lieu de 3.',                                       60, 'cardio'),
  ('aaaaaaaa-0000-0000-0000-000032600000', '33333333-3333-3333-3333-000000000302', 6, 'hyrox', 'Active Recovery',             'Marche 30 min + mobilité.',                                    40, 'none'),
  -- Week 3
  ('aaaaaaaa-0000-0000-0000-000033110000', '33333333-3333-3333-3333-000000000303', 1, 'hyrox', 'Rox Base Intensité',          'Intervalles run/ski plus rapides, repos -10s.',                55, 'core'),
  ('aaaaaaaa-0000-0000-0000-000033210000', '33333333-3333-3333-3333-000000000303', 2, 'hyrox', 'Strength Heavy + Sled Lourd', 'Back Squat 5×3 @85%, sled plus lourd.',                        65, 'none'),
  ('aaaaaaaa-0000-0000-0000-000033310000', '33333333-3333-3333-3333-000000000303', 3, 'hyrox', 'Rox Simulation 50%',          'Moitié d''une vraie Hyrox (4 stations + 4 km).',               55, 'mixed'),
  ('aaaaaaaa-0000-0000-0000-000033410000', '33333333-3333-3333-3333-000000000303', 4, 'hyrox', 'Tempo 7km + Ski',             '7 km tempo + 1 km ski.',                                       65, 'none'),
  ('aaaaaaaa-0000-0000-0000-000033510000', '33333333-3333-3333-3333-000000000303', 5, 'hyrox', 'Compromised Rox',             '3 tours : 600m run + station + 400m run + station.',           55, 'cardio'),
  ('aaaaaaaa-0000-0000-0000-000033610000', '33333333-3333-3333-3333-000000000303', 6, 'hyrox', 'Active Recovery',             'Swim ou marche + mobilité.',                                   40, 'none'),
  -- Week 4 (Peak)
  ('aaaaaaaa-0000-0000-0000-000034110000', '33333333-3333-3333-3333-000000000304', 1, 'hyrox', 'Rox Base Peak',               'Intervalles les plus rapides du cycle.',                       55, 'core'),
  ('aaaaaaaa-0000-0000-0000-000034210000', '33333333-3333-3333-3333-000000000304', 2, 'hyrox', 'Strength Max',                'Back Squat 3×2 @92%, DL 3×2 @92%.',                            70, 'none'),
  ('aaaaaaaa-0000-0000-0000-000034310000', '33333333-3333-3333-3333-000000000304', 3, 'hyrox', 'Rox Simulation 75%',          '6 stations + 6 km run. Simulation Hyrox quasi-complète.',      70, 'mixed'),
  ('aaaaaaaa-0000-0000-0000-000034410000', '33333333-3333-3333-3333-000000000304', 4, 'hyrox', 'Tempo 8 km',                  '8 km tempo à l''allure race.',                                 55, 'none'),
  ('aaaaaaaa-0000-0000-0000-000034510000', '33333333-3333-3333-3333-000000000304', 5, 'hyrox', 'Compromised Race Pace',       'Allure cible + stations intensité max.',                       60, 'cardio'),
  ('aaaaaaaa-0000-0000-0000-000034610000', '33333333-3333-3333-3333-000000000304', 6, 'hyrox', 'Active Recovery',             'Cooldown + massage / mobilité.',                               40, 'none'),
  -- Week 5 (Deload)
  ('aaaaaaaa-0000-0000-0000-000035110000', '33333333-3333-3333-3333-000000000305', 1, 'hyrox', 'Easy Run + Ski',              '30 min Z2 easy.',                                              40, 'none'),
  ('aaaaaaaa-0000-0000-0000-000035210000', '33333333-3333-3333-3333-000000000305', 2, 'hyrox', 'Strength Deload',             'Back Squat 3×5 @60%.',                                         50, 'none'),
  ('aaaaaaaa-0000-0000-0000-000035310000', '33333333-3333-3333-3333-000000000305', 3, 'hyrox', 'Technique Station',           'Focus technique : sled push, wall ball, lunge.',              45, 'none'),
  ('aaaaaaaa-0000-0000-0000-000035410000', '33333333-3333-3333-3333-000000000305', 4, 'hyrox', 'Z2 Long',                     '60 min run Z2 facile.',                                        60, 'none'),
  ('aaaaaaaa-0000-0000-0000-000035510000', '33333333-3333-3333-3333-000000000305', 5, 'hyrox', 'Row + mobilité',              '20 min row easy + mobilité complète.',                         40, 'none'),
  ('aaaaaaaa-0000-0000-0000-000035610000', '33333333-3333-3333-3333-000000000305', 6, 'hyrox', 'Active Recovery',             'Marche + stretching.',                                         30, 'none'),
  -- Week 6 (Test)
  ('aaaaaaaa-0000-0000-0000-000036110000', '33333333-3333-3333-3333-000000000306', 1, 'hyrox', 'Test 5 km run',               'Chrono 5 km — benchmark aérobie.',                             40, 'none'),
  ('aaaaaaaa-0000-0000-0000-000036210000', '33333333-3333-3333-3333-000000000306', 2, 'hyrox', 'Test 1 km Row + Ski',         'Chrono 1000m row + 1000m ski.',                                35, 'none'),
  ('aaaaaaaa-0000-0000-0000-000036310000', '33333333-3333-3333-3333-000000000306', 3, 'hyrox', 'Hyrox Simulation Complète',   '8 stations + 8 km run — race simulation.',                     90, 'mixed'),
  ('aaaaaaaa-0000-0000-0000-000036410000', '33333333-3333-3333-3333-000000000306', 4, 'hyrox', 'Easy Recovery',               'Marche + mobilité.',                                           30, 'none'),
  ('aaaaaaaa-0000-0000-0000-000036510000', '33333333-3333-3333-3333-000000000306', 5, 'hyrox', 'Test Station Chrono',         'Chrono sur chaque station (wall ball, sled, etc).',           60, 'none'),
  ('aaaaaaaa-0000-0000-0000-000036610000', '33333333-3333-3333-3333-000000000306', 6, 'hyrox', 'Active Recovery',             'Fin de cycle — célébration + mobilité.',                       30, 'none');

-- ============================================================
-- PROGRAM 4 — At Home — Weeks 2..6
-- ============================================================

INSERT INTO sessions (id, week_id, day_number, session_type, name, description, estimated_duration_min, finisher_type) VALUES
  -- Week 2
  ('aaaaaaaa-0000-0000-0000-000042100000', '44444444-4444-4444-4444-000000000402', 1, 'home', 'Full Body — Build',            '+5 reps par exo sur Cindy-lite, 15 min AMRAP.',              35, 'core'),
  ('aaaaaaaa-0000-0000-0000-000042200000', '44444444-4444-4444-4444-000000000402', 2, 'home', 'DB/KB Conditioning — Build',   '5 tours au lieu de 4.',                                       40, 'mixed'),
  ('aaaaaaaa-0000-0000-0000-000042300000', '44444444-4444-4444-4444-000000000402', 3, 'home', 'Gymnastics-Lite — Build',      '6 séries au lieu de 5, reps ajustées.',                       45, 'core'),
  ('aaaaaaaa-0000-0000-0000-000042400000', '44444444-4444-4444-4444-000000000402', 4, 'home', 'Cardio & Core — Build',        'EMOM 24 min (au lieu de 20).',                                35, 'cardio'),
  ('aaaaaaaa-0000-0000-0000-000042500000', '44444444-4444-4444-4444-000000000402', 5, 'home', 'Mixed Full Body — Build',      '6 tours au lieu de 5.',                                       40, 'mixed'),
  ('aaaaaaaa-0000-0000-0000-000042600000', '44444444-4444-4444-4444-000000000402', 6, 'home', 'Active Recovery',              'Marche 30 min + mobilité.',                                   30, 'none'),
  -- Week 3
  ('aaaaaaaa-0000-0000-0000-000043100000', '44444444-4444-4444-4444-000000000403', 1, 'home', 'Full Body — Intensity',        'AMRAP 15 min plus dense.',                                    35, 'core'),
  ('aaaaaaaa-0000-0000-0000-000043200000', '44444444-4444-4444-4444-000000000403', 2, 'home', 'DB/KB — Intensity',            '6 tours rapides.',                                            40, 'mixed'),
  ('aaaaaaaa-0000-0000-0000-000043300000', '44444444-4444-4444-4444-000000000403', 3, 'home', 'Gymnastics — Intensity',       'Progresser vers pistol squats + HSPU pike.',                  45, 'core'),
  ('aaaaaaaa-0000-0000-0000-000043400000', '44444444-4444-4444-4444-000000000403', 4, 'home', 'Cardio Chipper',               '100 DU + 80 sit-ups + 60 mountain climbers + 40 burpees.',    35, 'cardio'),
  ('aaaaaaaa-0000-0000-0000-000043500000', '44444444-4444-4444-4444-000000000403', 5, 'home', 'Mixed — Intensity',            '7 tours, cap 30 min.',                                         40, 'mixed'),
  ('aaaaaaaa-0000-0000-0000-000043600000', '44444444-4444-4444-4444-000000000403', 6, 'home', 'Active Recovery',              'Stretching + mobilité complète.',                              30, 'none'),
  -- Week 4 (Peak)
  ('aaaaaaaa-0000-0000-0000-000044110000', '44444444-4444-4444-4444-000000000404', 1, 'home', 'Full Body — Peak',             'AMRAP 20 min max reps.',                                      40, 'core'),
  ('aaaaaaaa-0000-0000-0000-000044210000', '44444444-4444-4444-4444-000000000404', 2, 'home', 'DB/KB — Peak',                 '8 tours, cap 35 min.',                                         40, 'mixed'),
  ('aaaaaaaa-0000-0000-0000-000044310000', '44444444-4444-4444-4444-000000000404', 3, 'home', 'Gymnastics — Peak',            'Pistol squat tentatives, wall walk 6×.',                      45, 'core'),
  ('aaaaaaaa-0000-0000-0000-000044410000', '44444444-4444-4444-4444-000000000404', 4, 'home', 'Cardio — Peak',                'Intervalles dense : 10×1 min ON / 1 min OFF.',                35, 'cardio'),
  ('aaaaaaaa-0000-0000-0000-000044510000', '44444444-4444-4444-4444-000000000404', 5, 'home', 'Mixed — Peak',                 'Chipper long : 10 ex × 10 reps for time.',                    45, 'mixed'),
  ('aaaaaaaa-0000-0000-0000-000044610000', '44444444-4444-4444-4444-000000000404', 6, 'home', 'Active Recovery',              'Cooldown complet.',                                            30, 'none'),
  -- Week 5 (Deload)
  ('aaaaaaaa-0000-0000-0000-000045110000', '44444444-4444-4444-4444-000000000405', 1, 'home', 'Full Body — Deload',           'AMRAP 10 min bodyweight easy.',                               30, 'none'),
  ('aaaaaaaa-0000-0000-0000-000045210000', '44444444-4444-4444-4444-000000000405', 2, 'home', 'DB/KB — Deload',               '3 tours easy, focus technique.',                              30, 'none'),
  ('aaaaaaaa-0000-0000-0000-000045310000', '44444444-4444-4444-4444-000000000405', 3, 'home', 'Mobility Skill',               'Handstand hold + wall walk progressions.',                    35, 'none'),
  ('aaaaaaaa-0000-0000-0000-000045410000', '44444444-4444-4444-4444-000000000405', 4, 'home', 'Cardio Z2',                    '25 min Z2 facile.',                                            30, 'none'),
  ('aaaaaaaa-0000-0000-0000-000045510000', '44444444-4444-4444-4444-000000000405', 5, 'home', 'Mixed Light',                  '3 tours courts, cap 15 min.',                                 25, 'none'),
  ('aaaaaaaa-0000-0000-0000-000045610000', '44444444-4444-4444-4444-000000000405', 6, 'home', 'Active Recovery',              'Stretching + walking.',                                        30, 'none'),
  -- Week 6 (Test)
  ('aaaaaaaa-0000-0000-0000-000046110000', '44444444-4444-4444-4444-000000000406', 1, 'home', 'Test Max Push-ups',            'Push-ups en 2 min (max reps).',                               30, 'none'),
  ('aaaaaaaa-0000-0000-0000-000046210000', '44444444-4444-4444-4444-000000000406', 2, 'home', 'Test Max Air Squats',          'Air squats en 5 min (max reps).',                             30, 'none'),
  ('aaaaaaaa-0000-0000-0000-000046310000', '44444444-4444-4444-4444-000000000406', 3, 'home', 'Retest Gymnastics',            'Comparer wall walks + pike push-ups.',                         40, 'none'),
  ('aaaaaaaa-0000-0000-0000-000046410000', '44444444-4444-4444-4444-000000000406', 4, 'home', 'Retest Cardio EMOM',           'Comparer score W1 D4.',                                        35, 'cardio'),
  ('aaaaaaaa-0000-0000-0000-000046510000', '44444444-4444-4444-4444-000000000406', 5, 'home', 'Retest Full Body',             'Comparer temps W1 D5.',                                        40, 'mixed'),
  ('aaaaaaaa-0000-0000-0000-000046610000', '44444444-4444-4444-4444-000000000406', 6, 'home', 'Active Recovery',              'Fin de cycle + célébration.',                                  30, 'none');
