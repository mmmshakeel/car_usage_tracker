import 'package:car_usage_tracker/core/database/app_database.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('persists tracker settings and orders odometer entries by date',
      () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    await database.settingsDao.saveSettings(
      ContractSettingsTableCompanion(
        leaseStartDate: Value(DateTime(2026, 1, 1)),
        leaseEndDate: Value(DateTime(2027, 1, 1)),
        contractDurationDays: const Value(365),
        startingOdometerKm: const Value(10000),
        maxKmPerContract: const Value(15000),
      ),
    );

    await database.odometerDao.upsertEntry(
      OdometerEntriesCompanion(
        date: Value(DateTime(2026, 2, 2)),
        odometerKm: const Value(10300),
      ),
    );
    await database.odometerDao.upsertEntry(
      OdometerEntriesCompanion(
        date: Value(DateTime(2026, 2, 1)),
        odometerKm: const Value(10100),
      ),
    );

    final settings = await database.settingsDao.watchSettings().first;
    final entries = await database.odometerDao.watchAllEntries().first;

    expect(settings?.startingOdometerKm, 10000);
    expect(entries.map((entry) => entry.odometerKm), [10100, 10300]);
  });
}
