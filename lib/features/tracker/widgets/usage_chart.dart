import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/models/month_bucket.dart';
import '../../../core/theme/app_theme.dart';

class UsageChart extends StatelessWidget {
  const UsageChart({super.key, required this.months});

  final List<MonthBucket> months;

  @override
  Widget build(BuildContext context) {
    if (months.isEmpty) {
      return _EmptyChart();
    }

    final barGroups = months.indexed.map((record) {
      final (i, bucket) = record;
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: bucket.kmDriven,
            color: bucket.kmDriven > 0 ? AppColors.chartBar : Colors.grey.shade200,
            width: 12,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ],
      );
    }).toList();

    // Show a label every 3 months to avoid crowding.
    const labelInterval = 3;

    return SizedBox(
      height: 220,
      child: BarChart(
        BarChartData(
          barGroups: barGroups,
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final idx = value.toInt();
                  if (idx < 0 || idx >= months.length) {
                    return const SizedBox.shrink();
                  }
                  if (idx % labelInterval != 0) {
                    return const SizedBox.shrink();
                  }
                  final label = DateFormat('MMM yy').format(months[idx].date);
                  return Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.xs),
                    child: Text(label, style: const TextStyle(fontSize: 9)),
                  );
                },
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final bucket = months[group.x];
                if (bucket.kmDriven == 0) return null;
                final month = DateFormat('MMM yyyy').format(bucket.date);
                return BarTooltipItem(
                  '$month\n${bucket.kmDriven.toStringAsFixed(0)} km',
                  const TextStyle(color: Colors.white, fontSize: 11),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.card,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: const Center(
        child: Text(
          'No entries yet.\nLog your first mileage to see the chart.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
