import 'package:drift/drift.dart';

import 'app_database.dart';

part 'odometer_dao.g.dart';

@DriftAccessor(tables: [OdometerEntries])
class OdometerDao extends DatabaseAccessor<AppDatabase>
    with _$OdometerDaoMixin {
  OdometerDao(super.db);

  Future<void> upsertEntry(OdometerEntriesCompanion entry) {
    final d = entry.date.value;
    final normalized = DateTime(d.year, d.month, d.day);
    return into(odometerEntries).insertOnConflictUpdate(
      entry.copyWith(date: Value(normalized)),
    );
  }

  Future<bool> updateEntry(OdometerEntriesCompanion entry) =>
      update(odometerEntries).replace(entry);

  Future<int> deleteEntry(int id) =>
      (delete(odometerEntries)..where((t) => t.id.equals(id))).go();

  Stream<List<OdometerEntry>> watchAllEntries() =>
      (select(odometerEntries)..orderBy([(t) => OrderingTerm.asc(t.date)]))
          .watch();
}
