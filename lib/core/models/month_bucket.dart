class MonthBucket {
  final int year;
  final int month;
  final double kmDriven;

  const MonthBucket({
    required this.year,
    required this.month,
    required this.kmDriven,
  });

  DateTime get date => DateTime(year, month);
}
