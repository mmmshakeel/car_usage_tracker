import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart' show ContractSettingsTableCompanion;
import '../../../core/models/contract_settings_model.dart';
import '../../../core/providers/contract_settings_provider.dart';
import '../../../core/providers/database_provider.dart';
import '../../../core/theme/app_theme.dart';
import 'contract_summary_card.dart';
import 'date_field.dart';
import 'stepper_field.dart';

class SettingsForm extends ConsumerStatefulWidget {
  const SettingsForm({super.key});

  @override
  ConsumerState<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends ConsumerState<SettingsForm> {
  late ContractSettingsModel _model;
  bool _hasPopulated = false;
  bool _isSaving = false;

  static ContractSettingsModel _defaultModel() => ContractSettingsModel(
        leaseStartDate: DateTime(2026, 3, 13),
        leaseEndDate: DateTime(2027, 3, 13),
        contractDurationDays: 365,
        startingOdometerKm: 0,
        maxKmPerContract: 10000,
      );

  @override
  void initState() {
    super.initState();
    // Populate immediately if data is already cached in the stream.
    final cached = ref.read(contractSettingsProvider).valueOrNull;
    if (cached != null) {
      _model = cached;
      _hasPopulated = true;
    } else {
      _model = _defaultModel();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Populate once when the DB stream first emits (handles cold start).
    ref.listen(contractSettingsProvider, (_, next) {
      if (!_hasPopulated && next.hasValue) {
        setState(() {
          _model = next.value ?? _defaultModel();
          _hasPopulated = true;
        });
      }
    });

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  DateField(
                    label: 'Lease Start Date',
                    value: _model.leaseStartDate,
                    onChanged: (date) => setState(() {
                      _model = _model.copyWith(
                        leaseStartDate: date,
                        contractDurationDays:
                            _model.leaseEndDate.difference(date).inDays,
                      );
                    }),
                  ),
                  const Divider(height: AppSpacing.lg),
                  DateField(
                    label: 'Lease End Date',
                    value: _model.leaseEndDate,
                    onChanged: (date) => setState(() {
                      _model = _model.copyWith(
                        leaseEndDate: date,
                        contractDurationDays:
                            date.difference(_model.leaseStartDate).inDays,
                      );
                    }),
                  ),
                  const Divider(height: AppSpacing.lg),
                  StepperField(
                    label: 'Contract Duration (Days)',
                    value: _model.contractDurationDays,
                    onChanged: (v) => setState(
                        () => _model = _model.copyWith(contractDurationDays: v)),
                  ),
                  const Divider(height: AppSpacing.lg),
                  StepperField(
                    label: 'Starting Odometer (km)',
                    value: _model.startingOdometerKm,
                    step: 100,
                    onChanged: (v) => setState(
                        () => _model = _model.copyWith(startingOdometerKm: v)),
                  ),
                  const Divider(height: AppSpacing.lg),
                  StepperField(
                    label: 'Maximum KM per Contract',
                    value: _model.maxKmPerContract,
                    step: 1000,
                    onChanged: (v) => setState(
                        () => _model = _model.copyWith(maxKmPerContract: v)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ContractSummaryCard(model: _model),
          const SizedBox(height: AppSpacing.lg),
          ElevatedButton(
            onPressed: _isSaving ? null : _save,
            child: _isSaving
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : const Text('Save'),
          ),
        ],
      ),
    );
  }

  bool _validate() {
    if (!_model.leaseEndDate.isAfter(_model.leaseStartDate)) {
      _showError('End date must be after start date');
      return false;
    }
    if (_model.contractDurationDays <= 0) {
      _showError('Contract duration must be greater than 0');
      return false;
    }
    if (_model.maxKmPerContract <= 0) {
      _showError('Max KM per contract must be greater than 0');
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red.shade700),
    );
  }

  Future<void> _save() async {
    if (!_validate()) return;
    setState(() => _isSaving = true);
    try {
      final db = ref.read(databaseProvider);
      await db.settingsDao.saveSettings(
        ContractSettingsTableCompanion(
          leaseStartDate: Value(_model.leaseStartDate),
          leaseEndDate: Value(_model.leaseEndDate),
          contractDurationDays: Value(_model.contractDurationDays),
          startingOdometerKm: Value(_model.startingOdometerKm),
          maxKmPerContract: Value(_model.maxKmPerContract),
        ),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Settings saved')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}
