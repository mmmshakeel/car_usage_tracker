class ContractSettingsModel {
  final DateTime leaseStartDate;
  final DateTime leaseEndDate;
  final int contractDurationDays;
  final int startingOdometerKm;
  final int maxKmPerContract;

  const ContractSettingsModel({
    required this.leaseStartDate,
    required this.leaseEndDate,
    required this.contractDurationDays,
    required this.startingOdometerKm,
    required this.maxKmPerContract,
  });

  double get maxKmPerDayIdeal =>
      contractDurationDays > 0 ? maxKmPerContract / contractDurationDays : 0;

  ContractSettingsModel copyWith({
    DateTime? leaseStartDate,
    DateTime? leaseEndDate,
    int? contractDurationDays,
    int? startingOdometerKm,
    int? maxKmPerContract,
  }) {
    return ContractSettingsModel(
      leaseStartDate: leaseStartDate ?? this.leaseStartDate,
      leaseEndDate: leaseEndDate ?? this.leaseEndDate,
      contractDurationDays: contractDurationDays ?? this.contractDurationDays,
      startingOdometerKm: startingOdometerKm ?? this.startingOdometerKm,
      maxKmPerContract: maxKmPerContract ?? this.maxKmPerContract,
    );
  }
}
