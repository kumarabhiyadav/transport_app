class Ride {
  final String truckNumber;
  final DateTime date;
  final String lrNo;
  final String particular;
  final double quantity;
  final double rate;
  final double? detention;

  Ride(
      {required this.date,
      required this.detention,
      required this.lrNo,
      required this.particular,
      required this.quantity,
      required this.rate,
      required this.truckNumber});
}
