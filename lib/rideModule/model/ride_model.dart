class Ride {
  final String truckNumber;
  final DateTime date;
  final String lrNo;
  final String particular;
  final double quantity;
  final double rate;
  final double? detention;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Ride(
      {required this.date,
      required this.detention,
      required this.lrNo,
      required this.particular,
      required this.quantity,
      required this.rate,
      required this.truckNumber,
      this.createdAt,
      this.updatedAt});

  static rideToJson(value) => Ride(
        date: DateTime.parse(value["date"]),
        detention: double.parse(value["detention"].toString()),
        lrNo: value["lrno"],
        particular: value["particular"],
        quantity: double.parse(value["quantity"].toString()),
        rate: double.parse(value["rate"].toString()),
        truckNumber: value["truckNumber"],
        createdAt: DateTime.parse(value['createdAt']),
        updatedAt: DateTime.parse(value['updatedAt']),
      );
}
