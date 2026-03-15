import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/odometer_entries_provider.dart';
import '../../core/providers/summary_stats_provider.dart';
import '../../core/theme/app_theme.dart';
import 'widgets/summary_card.dart';
import 'widgets/usage_chart.dart';

class TrackerScreen extends ConsumerWidget {
  const TrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(summaryStatsProvider);
    final entriesAsync = ref.watch(odometerEntriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Car Usage Track')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kilometer usage',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppSpacing.md),
            entriesAsync.when(
              data: (entries) => UsageChart(entries: entries),
              loading: () => const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => SizedBox(
                height: 200,
                child: Center(child: Text('Error loading chart: $e')),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            if (statsAsync != null)
              SummaryCard(stats: statsAsync)
            else
              const SummaryCard(stats: null),
            const SizedBox(height: AppSpacing.lg),
            _CtaRow(),
          ],
        ),
      ),
    );
  }
}

class _CtaRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Ready to add mileage?',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        ElevatedButton(
          onPressed: () => context.push('/log'),
          child: const Text('Log Mileage'),
        ),
      ],
    );
  }
}
