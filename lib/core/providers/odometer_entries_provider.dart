import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/app_database.dart';
import '../models/odometer_entry_model.dart';
import 'database_provider.dart';

part 'odometer_entries_provider.g.dart';

/// Raw stream of DB entries ordered by date ascending.
@riverpod
Stream<List<OdometerEntry>> odometerEntries(OdometerEntriesRef ref) {
  return ref.watch(databaseProvider).odometerDao.watchAllEntries();
}

/// Entries enriched with computed [kmDriven] per entry.
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
