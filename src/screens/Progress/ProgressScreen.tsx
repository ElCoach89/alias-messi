// ============================================================
// El Coach — Progress Screen
// ============================================================

import React, { useState } from 'react';
import { View, Text, StyleSheet, ScrollView, Dimensions } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { LineChart } from 'react-native-chart-kit';
import { Colors, Spacing, FontSize, BorderRadius } from '../../constants/theme';
import Card from '../../components/Card';
import SegmentedControl from '../../components/SegmentedControl';

const screenWidth = Dimensions.get('window').width - Spacing.md * 2;

// Mock data
const STRENGTH_DATA = {
  labels: ['W1', 'W2', 'W3', 'W4', 'W5', 'W6'],
  datasets: [{ data: [80, 82.5, 85, 87.5, 82.5, 90] }],
};

const WOD_DATA = {
  labels: ['W1', 'W2', 'W3', 'W4', 'W5', 'W6'],
  datasets: [{ data: [7, 8, 8.5, 9, 7.5, 10] }],
};

const CONSISTENCY_DATA = {
  labels: ['W1', 'W2', 'W3', 'W4', 'W5', 'W6'],
  datasets: [{ data: [4, 5, 5, 4, 3, 5] }],
};

const CHART_CONFIG = {
  backgroundColor: Colors.card,
  backgroundGradientFrom: Colors.card,
  backgroundGradientTo: Colors.card,
  decimalPlaces: 1,
  color: (opacity = 1) => `rgba(255, 107, 53, ${opacity})`,
  labelColor: () => Colors.textMuted,
  propsForDots: {
    r: '4',
    strokeWidth: '2',
    stroke: Colors.primary,
  },
  propsForBackgroundLines: {
    stroke: Colors.border,
    strokeDasharray: '',
  },
};

type ChartView = 'strength' | 'wod' | 'consistency';

const PRS = [
  { exercise: 'Back Squat', weight: 110, unit: 'kg' },
  { exercise: 'Deadlift', weight: 140, unit: 'kg' },
  { exercise: 'Clean & Jerk', weight: 85, unit: 'kg' },
  { exercise: 'Snatch', weight: 67.5, unit: 'kg' },
  { exercise: 'Bench Press', weight: 90, unit: 'kg' },
];

export default function ProgressScreen() {
  const [chartView, setChartView] = useState<ChartView>('strength');

  const chartData =
    chartView === 'strength'
      ? STRENGTH_DATA
      : chartView === 'wod'
        ? WOD_DATA
        : CONSISTENCY_DATA;

  const chartLabel =
    chartView === 'strength'
      ? 'Back Squat (kg)'
      : chartView === 'wod'
        ? 'AMRAP Rounds'
        : 'Sessions / Week';

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView showsVerticalScrollIndicator={false} contentContainerStyle={styles.scroll}>
        <Text style={styles.title}>Progress</Text>

        {/* Summary Cards */}
        <View style={styles.summaryRow}>
          <Card style={styles.summaryCard}>
            <Ionicons name="barbell" size={20} color={Colors.primary} />
            <Text style={styles.summaryValue}>42</Text>
            <Text style={styles.summaryLabel}>Sessions</Text>
          </Card>
          <Card style={styles.summaryCard}>
            <Ionicons name="trophy" size={20} color={Colors.warning} />
            <Text style={styles.summaryValue}>5</Text>
            <Text style={styles.summaryLabel}>PRs</Text>
          </Card>
          <Card style={styles.summaryCard}>
            <Ionicons name="flame" size={20} color={Colors.error} />
            <Text style={styles.summaryValue}>12</Text>
            <Text style={styles.summaryLabel}>Streak</Text>
          </Card>
        </View>

        {/* Chart Toggle */}
        <SegmentedControl
          label="View"
          options={[
            { value: 'strength', label: 'Strength' },
            { value: 'wod', label: 'WOD' },
            { value: 'consistency', label: 'Consistency' },
          ]}
          selected={chartView}
          onChange={setChartView}
        />

        {/* Chart */}
        <Card>
          <Text style={styles.chartTitle}>{chartLabel}</Text>
          <LineChart
            data={chartData}
            width={screenWidth - Spacing.md * 2}
            height={200}
            chartConfig={CHART_CONFIG}
            bezier
            style={styles.chart}
            withInnerLines={false}
            withOuterLines={false}
          />
        </Card>

        {/* PRs */}
        <Text style={styles.sectionTitle}>Personal Records</Text>
        {PRS.map((pr, i) => (
          <Card key={i} style={styles.prCard}>
            <View style={styles.prRow}>
              <View style={styles.prLeft}>
                <Ionicons name="medal" size={18} color={Colors.warning} />
                <Text style={styles.prExercise}>{pr.exercise}</Text>
              </View>
              <Text style={styles.prWeight}>
                {pr.weight} {pr.unit}
              </Text>
            </View>
          </Card>
        ))}
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  scroll: {
    padding: Spacing.md,
    paddingBottom: Spacing.xxl,
  },
  title: {
    fontSize: FontSize.xxl,
    fontWeight: '800',
    color: Colors.text,
    marginBottom: Spacing.lg,
  },
  summaryRow: {
    flexDirection: 'row',
    gap: Spacing.sm,
    marginBottom: Spacing.lg,
  },
  summaryCard: {
    flex: 1,
    alignItems: 'center',
    gap: 4,
  },
  summaryValue: {
    fontSize: FontSize.xl,
    fontWeight: '800',
    color: Colors.text,
  },
  summaryLabel: {
    fontSize: FontSize.xs,
    color: Colors.textMuted,
  },
  chartTitle: {
    color: Colors.textSecondary,
    fontSize: FontSize.sm,
    marginBottom: Spacing.sm,
  },
  chart: {
    borderRadius: BorderRadius.md,
    marginLeft: -Spacing.sm,
  },
  sectionTitle: {
    fontSize: FontSize.lg,
    fontWeight: '700',
    color: Colors.text,
    marginTop: Spacing.md,
    marginBottom: Spacing.sm,
  },
  prCard: {
    marginBottom: Spacing.sm,
  },
  prRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  prLeft: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.sm,
  },
  prExercise: {
    color: Colors.text,
    fontSize: FontSize.base,
    fontWeight: '600',
  },
  prWeight: {
    color: Colors.primary,
    fontSize: FontSize.lg,
    fontWeight: '800',
  },
});
