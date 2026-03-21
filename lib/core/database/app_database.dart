import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'odometer_dao.dart';
import 'settings_dao.dart';

part 'app_database.g.dart';

class OdometerEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime().unique()();
  IntColumn get odometerKm => integer()();
  TextColumn get note => text().nullable()();
}

@DataClassName('ContractSettingsData')
class ContractSettingsTable extends Table {
  @override
  String get tableName => 'contract_settings';

  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get leaseStartDate => dateTime()();
  DateTimeColumn get leaseEndDate => dateTime()();
  IntColumn get contractDurationDays => integer()();
  IntColumn get startingOdometerKm => integer()();
  IntColumn get maxKmPerContract => integer()();
}

@DriftDatabase(
  tables: [OdometerEntries, ContractSettingsTable],
  daos: [OdometerDao, SettingsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await customStatement('''
              CREATE TABLE odometer_entries_new (
                id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                date INTEGER NOT NULL UNIQUE,
                odometer_km INTEGER NOT NULL,
                note TEXT
              )
            ''');
            await customStatement('''
              INSERT OR IGNORE INTO odometer_entries_new (id, date, odometer_km, note)
              SELECT id, date, odometer_km, note
              FROM odometer_entries
              ORDER BY id DESC
            ''');
            await customStatement('DROP TABLE odometer_entries');
            await customStatement(
                'ALTER TABLE odometer_entries_new RENAME TO odometer_entries');
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'car_usage_tracker');
  }
}
