class OdometerEntryModel {
  final int id;
  final DateTime date;
  final int odometerKm;
  final String? note;

  /// Null for the first entry (no previous reading to subtract from).
  final int? kmDriven;

  const OdometerEntryModel({
    required this.id,
    required this.date,
    required this.odometerKm,
    this.note,
    this.kmDriven,
  });
}
