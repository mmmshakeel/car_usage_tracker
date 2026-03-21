import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/models/summary_stats.dart';
import '../../../core/theme/app_theme.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key, required this.stats});

  final SummaryStats? stats;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: stats == null ? _EmptyState() : _Content(stats: stats!),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'No data yet',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: AppSpacing.xs),
        Text(
          'Add a mileage entry and set up your contract settings.',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.stats});

  final SummaryStats stats;

  @override
  Widget build(BuildContext context) {
    final dateLabel = stats.lastUpdated != null
        ? DateFormat('dd MMM yyyy').format(stats.lastUpdated!)
        : '—';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${stats.latestOdometerKm} km',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
            ),
            Text(
              'Last updated $dateLabel',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        const Divider(height: AppSpacing.lg),
        _StatRow(label: 'Driven in contract', value: '${stats.kmDrivenInContract} km'),
        _StatRow(label: 'Remaining km', value: '${stats.remainingKm} km'),
        _StatRow(label: 'Days remaining', value: '${stats.remainingDays} days'),
        _StatRow(
          label: 'Avg daily drive',
          value: '${stats.avgDailyDrive.toStringAsFixed(1)} km/day',
        ),
        _StatRow(
          label: 'Recommended daily drive',
          value: '${stats.maxKmPerDayRemaining.toStringAsFixed(1)} km/day',
        ),
      ],
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
