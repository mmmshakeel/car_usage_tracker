class SummaryStats {
  final int kmDrivenInContract;
  final int remainingKm;
  final int remainingDays;
  final double maxKmPerDayIdeal;
  final double maxKmPerDayRemaining;
  final int latestOdometerKm;
  final DateTime? lastUpdated;

  const SummaryStats({
    required this.kmDrivenInContract,
    required this.remainingKm,
    required this.remainingDays,
    required this.maxKmPerDayIdeal,
    required this.maxKmPerDayRemaining,
    required this.latestOdometerKm,
    this.lastUpdated,
  });
}
