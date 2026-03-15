import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/app_database.dart';
import '../models/contract_settings_model.dart';
import 'database_provider.dart';

part 'contract_settings_provider.g.dart';

/// Raw stream from the DB, converted to the domain model.
@riverpod
Stream<ContractSettingsModel?> contractSettings(ContractSettingsRef ref) {
  return ref
      .watch(databaseProvider)
      .settingsDao
      .watchSettings()
      .map((data) => data == null ? null : _toModel(data));
}

ContractSettingsModel _toModel(ContractSettingsData data) {
  return ContractSettingsModel(
    leaseStartDate: data.leaseStartDate,
    leaseEndDate: data.leaseEndDate,
    contractDurationDays: data.contractDurationDays,
    startingOdometerKm: data.startingOdometerKm,
    maxKmPerContract: data.maxKmPerContract,
  );
}
