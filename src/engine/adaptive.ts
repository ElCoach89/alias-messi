// ============================================================
// El Coach — Adaptive Engine
// ============================================================
// Analyzes the last 3 sessions to compute scores and classify
// the user, then returns adjustments for the next session.
// ============================================================

import {
  SessionFeedback,
  AdaptiveScores,
  AdaptiveAdjustment,
  UserClassification,
  WorkoutLog,
} from '../types';

// --- Score Computation ---

interface FeedbackWindow {
  feedbacks: SessionFeedback[];
  workoutLogs: WorkoutLog[];
  totalSessionsInPeriod: number; // how many sessions were scheduled
}

/**
 * Compute Fatigue Score (0-40)
 * Based on: global_fatigue, warmup_feeling, wod_feeling, finisher_feeling
 */
function computeFatigueScore(feedbacks: SessionFeedback[]): number {
  if (feedbacks.length === 0) return 20; // neutral default

  let total = 0;

  for (const fb of feedbacks) {
    // Global fatigue contributes 0-10 directly
    total += fb.global_fatigue;

    // Warmup feeling: tired=3, normal=1, good=0
    const warmupMap = { tired: 3, normal: 1, good: 0 };
    total += warmupMap[fb.warmup_feeling];

    // WOD feeling: exhausted=4, tired=2, fresh=0
    const wodMap = { exhausted: 4, tired: 2, fresh: 0 };
    total += wodMap[fb.wod_feeling];

    // Finisher feeling: exhausted=3, tired=1.5, fresh=0
    const finisherMap = { exhausted: 3, tired: 1.5, fresh: 0 };
    total += finisherMap[fb.finisher_feeling];
  }

  // Normalize to 0-40 range (max per session: 10+3+4+3 = 20)
  const maxPossible = feedbacks.length * 20;
  return Math.min(40, Math.round((total / maxPossible) * 40));
}

/**
 * Compute Performance Score (0-40)
 * Based on: strength_rpe, strength_difficulty, motivation
 * Higher = better performing
 */
function computePerformanceScore(feedbacks: SessionFeedback[]): number {
  if (feedbacks.length === 0) return 20; // neutral default

  let total = 0;

  for (const fb of feedbacks) {
    // Motivation contributes positively (1-10 → 0-10)
    total += fb.motivation;

    // Strength difficulty: easy=8, ok=5, hard=2
    const difficultyMap = { easy: 8, ok: 5, hard: 2 };
    total += difficultyMap[fb.strength_difficulty];

    // Inverse of RPE (low RPE = performing well): (10 - rpe) * 1.2
    total += (10 - fb.strength_rpe) * 1.2;
  }

  // Normalize to 0-40 (max per session: 10+8+10.8 = 28.8)
  const maxPossible = feedbacks.length * 28.8;
  return Math.min(40, Math.round((total / maxPossible) * 40));
}

/**
 * Compute Consistency Score (0-20)
 * Based on: sessions completed vs sessions scheduled
 */
function computeConsistencyScore(
  completedLogs: WorkoutLog[],
  totalScheduled: number,
): number {
  if (totalScheduled === 0) return 10; // neutral

  const completed = completedLogs.filter((l) => l.status === 'completed').length;
  const ratio = completed / totalScheduled;

  return Math.min(20, Math.round(ratio * 20));
}

/**
 * Classify user based on total score breakdown
 */
function classifyUser(scores: Omit<AdaptiveScores, 'classification' | 'computed_at'>): UserClassification {
  const { fatigue_score, performance_score, consistency_score } = scores;

  // High fatigue + low performance → struggling
  if (fatigue_score >= 28 && performance_score <= 15) return 'struggling';

  // High fatigue regardless of performance → fatigued
  if (fatigue_score >= 24) return 'fatigued';

  // High performance + good consistency → performer
  if (performance_score >= 28 && consistency_score >= 14) return 'performer';

  // Default → stable
  return 'stable';
}

// --- Main Compute Function ---

export function computeAdaptiveScores(window: FeedbackWindow): AdaptiveScores {
  const fatigue_score = computeFatigueScore(window.feedbacks);
  const performance_score = computePerformanceScore(window.feedbacks);
  const consistency_score = computeConsistencyScore(
    window.workoutLogs,
    window.totalSessionsInPeriod,
  );

  const total_score = fatigue_score + performance_score + consistency_score;

  const partial = { fatigue_score, performance_score, consistency_score, total_score };
  const classification = classifyUser(partial);

  return {
    ...partial,
    classification,
    computed_at: new Date().toISOString(),
  };
}

// --- Adjustment Generator ---

const COACH_MESSAGES: Record<UserClassification, string[]> = {
  performer: [
    "You're on fire! Let's push a bit harder today.",
    "Great momentum — time to level up.",
    "Your consistency is paying off. Ready to add weight?",
  ],
  stable: [
    "Solid work. Let's keep building.",
    "You're in a good rhythm — stay focused.",
    "Consistency is key. Let's go.",
  ],
  fatigued: [
    "Your body needs a lighter session today.",
    "We're scaling back today — recovery matters.",
    "Listen to your body. Lighter loads, same effort.",
  ],
  struggling: [
    "Let's take it easy today. Showing up is what counts.",
    "Recovery first. We've simplified today's session.",
    "Small steps forward. Let's focus on movement quality.",
  ],
};

export function generateAdjustment(scores: AdaptiveScores): AdaptiveAdjustment {
  const { classification } = scores;

  const messages = COACH_MESSAGES[classification];
  const message = messages[Math.floor(Math.random() * messages.length)];

  switch (classification) {
    case 'performer':
      return {
        weight_modifier: 1.05, // +5%
        volume_modifier: 1.0,
        duration_modifier: 1.0,
        finisher_intensity: 'increased',
        coach_message: message,
      };

    case 'stable':
      return {
        weight_modifier: 1.025, // +2.5%
        volume_modifier: 1.0,
        duration_modifier: 1.0,
        finisher_intensity: 'normal',
        coach_message: message,
      };

    case 'fatigued':
      return {
        weight_modifier: 0.9, // -10%
        volume_modifier: 0.85, // fewer reps
        duration_modifier: 0.9, // shorter time caps
        finisher_intensity: 'reduced',
        coach_message: message,
      };

    case 'struggling':
      return {
        weight_modifier: 0.8, // -20%
        volume_modifier: 0.75,
        duration_modifier: 0.8,
        finisher_intensity: 'reduced',
        coach_message: message,
      };
  }
}

// --- Apply Adjustments to Workout ---

export function adjustWeight(baseWeightKg: number, modifier: number): number {
  // Round to nearest 0.5kg
  return Math.round((baseWeightKg * modifier) * 2) / 2;
}

export function adjustReps(baseReps: number, modifier: number): number {
  return Math.max(1, Math.round(baseReps * modifier));
}

export function adjustTimeCap(baseSeconds: number, modifier: number): number {
  // Round to nearest 30 seconds
  return Math.max(60, Math.round((baseSeconds * modifier) / 30) * 30);
}

/**
 * Compute the suggested weight for a given exercise based on 1RM
 */
export function computeSuggestedWeight(
  oneRepMax: number,
  targetPercentage: number,
  adaptiveModifier: number,
): number {
  const base = oneRepMax * (targetPercentage / 100);
  return adjustWeight(base, adaptiveModifier);
}
