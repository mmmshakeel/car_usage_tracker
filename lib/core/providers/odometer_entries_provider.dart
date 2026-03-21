import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/app_database.dart';
import '../models/month_bucket.dart';
import '../models/odometer_entry_model.dart';
import 'contract_settings_provider.dart';
import 'database_provider.dart';

part 'odometer_entries_provider.g.dart';

/// Raw stream of DB entries ordered by date ascending.
@riverpod
Stream<List<OdometerEntry>> odometerEntries(OdometerEntriesRef ref) {
  return ref.watch(databaseProvider).odometerDao.watchAllEntries();
}

/// km driven per entry, enriched with the computed [kmDriven] field.
@riverpod
List<OdometerEntryModel> kmDrivenPerEntry(KmDrivenPerEntryRef ref) {
  final entries = ref.watch(odometerEntriesProvider).valueOrNull ?? [];

  final result = <OdometerEntryModel>[];
  for (var i = 0; i < entries.length; i++) {
    final entry = entries[i];
    final kmDriven =
        i > 0 ? entry.odometerKm - entries[i - 1].odometerKm : null;
    result.add(OdometerEntryModel(
      id: entry.id,
      date: entry.date,
      odometerKm: entry.odometerKm,
      note: entry.note,
      kmDriven: kmDriven,
    ));
  }
  return result;
}

/// Monthly km driven aggregated across the full lease contract period.
/// Falls back to a 12-month rolling window if contract settings are not set.
@riverpod
List<MonthBucket> monthlyKm(MonthlyKmRef ref) {
  final entries = ref.watch(kmDrivenPerEntryProvider);
  final settings = ref.watch(contractSettingsProvider).valueOrNull;

  // Determine chart date range.
  final today = DateTime.now();
  final DateTime rangeStart;
  final DateTime rangeEnd;
  if (settings != null) {
    rangeStart = DateTime(settings.leaseStartDate.year, settings.leaseStartDate.month);
    rangeEnd = DateTime(settings.leaseEndDate.year, settings.leaseEndDate.month);
  } else {
    rangeStart = DateTime(today.year, today.month);
    rangeEnd = DateTime(today.year, today.month + 11);
  }

  // Sum km driven per calendar month from enriched entries.
  final kmByMonth = <String, double>{};
  for (final entry in entries) {
    if (entry.kmDriven == null) continue;
    final key = '${entry.date.year}-${entry.date.month}';
    kmByMonth[key] = (kmByMonth[key] ?? 0) + entry.kmDriven!;
  }

  // Generate one bucket per month slot across the range.
  final buckets = <MonthBucket>[];
  var cursor = rangeStart;
  while (!cursor.isAfter(rangeEnd)) {
    final key = '${cursor.year}-${cursor.month}';
    buckets.add(MonthBucket(
      year: cursor.year,
      month: cursor.month,
      kmDriven: kmByMonth[key] ?? 0,
    ));
    cursor = DateTime(cursor.year, cursor.month + 1);
  }
  return buckets;
}
