import 'package:flutter/material.dart';

import '../../../core/models/contract_settings_model.dart';
import '../../../core/theme/app_theme.dart';

class ContractSummaryCard extends StatelessWidget {
  const ContractSummaryCard({super.key, required this.model});

  final ContractSettingsModel model;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final remainingDays = model.leaseEndDate.difference(today).inDays;

    final remainingLabel = remainingDays > 0 && model.maxKmPerContract > 0
        ? '${(model.maxKmPerContract / remainingDays).toStringAsFixed(2)} km'
        : '— km';

    final idealLabel = model.maxKmPerDayIdeal > 0
        ? '${model.maxKmPerDayIdeal.toStringAsFixed(2)} km/day'
        : '—';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.directions_car, color: AppColors.primary, size: 28),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    remainingLabel,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const Text(
                    'Max KM per day',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Ideal pace: $idealLabel',
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
