import 'package:drift/drift.dart';

import 'app_database.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [ContractSettingsTable])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.db);

  Stream<ContractSettingsData?> watchSettings() =>
      (select(contractSettingsTable)..where((t) => t.id.equals(1)))
          .watchSingleOrNull();

  Future<void> saveSettings(ContractSettingsTableCompanion settings) =>
      into(contractSettingsTable).insertOnConflictUpdate(
        settings.copyWith(id: const Value(1)),
      );
}
