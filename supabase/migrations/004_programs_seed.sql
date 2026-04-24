-- ============================================================
-- El Coach — Programs Seed: CrossFit / Hybride / Hyrox / At Home
-- ============================================================
-- 4 programs × 6 weeks = 24 weeks of progression.
-- Each program follows the same macro-cycle:
--   W1 Foundation (0.85) → W2 Build (0.90) → W3 Intensity (0.95)
--   → W4 Peak (1.00) → W5 Deload (0.80) → W6 Test (1.05)
-- ============================================================

-- -----------------------------------------------------------
-- Program 1: CrossFit Pure
-- -----------------------------------------------------------

INSERT INTO programs (id, module, name, description, duration_weeks, level) VALUES
  ('11111111-1111-1111-1111-111111111111',
   'crossfit',
   'CrossFit Pure',
   '6 semaines de CrossFit conventionnel — force, haltérophilie olympique, gymnastique et WODs variés. 5 séances + 1 récupération active par semaine.',
   6,
   'intermediate');

INSERT INTO program_weeks (id, program_id, week_number, theme, intensity_modifier) VALUES
  ('11111111-1111-1111-1111-000000000101', '11111111-1111-1111-1111-111111111111', 1, 'Foundation', 0.85),
  ('11111111-1111-1111-1111-000000000102', '11111111-1111-1111-1111-111111111111', 2, 'Build',      0.90),
  ('11111111-1111-1111-1111-000000000103', '11111111-1111-1111-1111-111111111111', 3, 'Intensity',  0.95),
  ('11111111-1111-1111-1111-000000000104', '11111111-1111-1111-1111-111111111111', 4, 'Peak',       1.00),
  ('11111111-1111-1111-1111-000000000105', '11111111-1111-1111-1111-111111111111', 5, 'Deload',     0.80),
  ('11111111-1111-1111-1111-000000000106', '11111111-1111-1111-1111-111111111111', 6, 'Test',       1.05);

-- -----------------------------------------------------------
-- Program 2: Hybride (CrossFit + musculation + cooldown adaptatif)
-- -----------------------------------------------------------

INSERT INTO programs (id, module, name, description, duration_weeks, level) VALUES
  ('22222222-2222-2222-2222-222222222222',
   'hybrid',
   'Hybride CrossFit / Musculation',
   '6 semaines mixtes : 3 séances CrossFit (WODs + olympique) + 3 séances de musculation structurée (push/pull/legs) + 1 jour de cooldown adaptatif (walk / run / boxe / swim / repos complet) choisi par le moteur selon ta fatigue de la semaine.',
   6,
   'intermediate');

INSERT INTO program_weeks (id, program_id, week_number, theme, intensity_modifier) VALUES
  ('22222222-2222-2222-2222-000000000201', '22222222-2222-2222-2222-222222222222', 1, 'Foundation', 0.85),
  ('22222222-2222-2222-2222-000000000202', '22222222-2222-2222-2222-222222222222', 2, 'Build',      0.90),
  ('22222222-2222-2222-2222-000000000203', '22222222-2222-2222-2222-222222222222', 3, 'Intensity',  0.95),
  ('22222222-2222-2222-2222-000000000204', '22222222-2222-2222-2222-222222222222', 4, 'Peak',       1.00),
  ('22222222-2222-2222-2222-000000000205', '22222222-2222-2222-2222-222222222222', 5, 'Deload',     0.80),
  ('22222222-2222-2222-2222-000000000206', '22222222-2222-2222-2222-222222222222', 6, 'Test',       1.05);

-- -----------------------------------------------------------
-- Program 3: Hyrox Pure
-- -----------------------------------------------------------

INSERT INTO programs (id, module, name, description, duration_weeks, level) VALUES
  ('33333333-3333-3333-3333-333333333333',
   'hyrox',
   'Hyrox Pure',
   '6 semaines de préparation Hyrox — running endurance + répétitions des 8 stations officielles (ski erg, sled push/pull, burpee broad jump, row, farmer''s carry, sandbag lunges, wall balls) + intervalles rox-style.',
   6,
   'intermediate');

INSERT INTO program_weeks (id, program_id, week_number, theme, intensity_modifier) VALUES
  ('33333333-3333-3333-3333-000000000301', '33333333-3333-3333-3333-333333333333', 1, 'Foundation', 0.85),
  ('33333333-3333-3333-3333-000000000302', '33333333-3333-3333-3333-333333333333', 2, 'Build',      0.90),
  ('33333333-3333-3333-3333-000000000303', '33333333-3333-3333-3333-333333333333', 3, 'Intensity',  0.95),
  ('33333333-3333-3333-3333-000000000304', '33333333-3333-3333-3333-333333333333', 4, 'Peak',       1.00),
  ('33333333-3333-3333-3333-000000000305', '33333333-3333-3333-3333-333333333333', 5, 'Deload',     0.80),
  ('33333333-3333-3333-3333-000000000306', '33333333-3333-3333-3333-333333333333', 6, 'Test',       1.05);

-- -----------------------------------------------------------
-- Program 4: At Home
-- -----------------------------------------------------------

INSERT INTO programs (id, module, name, description, duration_weeks, level) VALUES
  ('44444444-4444-4444-4444-444444444444',
   'home',
   'At Home',
   '6 semaines avec matériel minimal — poids du corps, haltères ou kettlebell (optionnel), corde à sauter. Pas de barre, pas de rameur, pas de rack. 5 séances courtes (30-45 min).',
   6,
   'beginner');

INSERT INTO program_weeks (id, program_id, week_number, theme, intensity_modifier) VALUES
  ('44444444-4444-4444-4444-000000000401', '44444444-4444-4444-4444-444444444444', 1, 'Foundation', 0.85),
  ('44444444-4444-4444-4444-000000000402', '44444444-4444-4444-4444-444444444444', 2, 'Build',      0.90),
  ('44444444-4444-4444-4444-000000000403', '44444444-4444-4444-4444-444444444444', 3, 'Intensity',  0.95),
  ('44444444-4444-4444-4444-000000000404', '44444444-4444-4444-4444-444444444444', 4, 'Peak',       1.00),
  ('44444444-4444-4444-4444-000000000405', '44444444-4444-4444-4444-444444444444', 5, 'Deload',     0.80),
  ('44444444-4444-4444-4444-000000000406', '44444444-4444-4444-4444-444444444444', 6, 'Test',       1.05);
