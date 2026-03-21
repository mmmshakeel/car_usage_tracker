import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/summary_stats.dart';
import 'contract_settings_provider.dart';
import 'odometer_entries_provider.dart';

part 'summary_stats_provider.g.dart';

/// Combines entries and contract settings to compute all summary statistics.
/// Returns null when either dependency is still loading or settings are unset.
@riverpod
SummaryStats? summaryStats(SummaryStatsRef ref) {
  final entries = ref.watch(odometerEntriesProvider).valueOrNull;
  final settings = ref.watch(contractSettingsProvider).valueOrNull;

  if (entries == null || settings == null) return null;

  final latestOdometerKm =
      entries.isNotEmpty ? entries.last.odometerKm : settings.startingOdometerKm;

  final lastUpdated = entries.isNotEmpty ? entries.last.date : null;

  final kmDrivenInContract = latestOdometerKm - settings.startingOdometerKm;
  final remainingKm = settings.maxKmPerContract - kmDrivenInContract;

  final today = DateTime.now();
  final remainingDays = settings.leaseEndDate.difference(today).inDays;

  final maxKmPerDayIdeal = settings.contractDurationDays > 0
      ? settings.maxKmPerContract / settings.contractDurationDays
      : 0.0;

  final maxKmPerDayRemaining =
      remainingDays > 0 ? remainingKm / remainingDays : 0.0;

  final daysSinceStart = today.difference(settings.leaseStartDate).inDays;
  final avgDailyDrive =
      daysSinceStart > 0 ? kmDrivenInContract / daysSinceStart : 0.0;

  return SummaryStats(
    kmDrivenInContract: kmDrivenInContract,
    remainingKm: remainingKm,
    remainingDays: remainingDays,
    maxKmPerDayIdeal: maxKmPerDayIdeal,
    maxKmPerDayRemaining: maxKmPerDayRemaining,
    avgDailyDrive: avgDailyDrive,
    latestOdometerKm: latestOdometerKm,
    lastUpdated: lastUpdated,
  );
}
