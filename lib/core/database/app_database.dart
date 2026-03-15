import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'odometer_dao.dart';
import 'settings_dao.dart';

part 'app_database.g.dart';

class OdometerEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
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
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'car_usage_tracker');
  }
}
