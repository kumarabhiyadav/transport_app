class Ride {
  final String id;
  final String truckNumber;
  final DateTime date;
  final String lrNo;
  final String particular;
  final double quantity;
  final double rate;
  final String customer;
  final double? detention;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? source;
  final String? destination;

  Ride(
      {required this.id,
      required this.date,
      required this.detention,
      required this.lrNo,
      required this.particular,
      required this.quantity,
      required this.rate,
      required this.truckNumber,
      required this.customer,
      this.createdAt,
      this.updatedAt,
      this.source,
      this.destination});

  static jsonToRide(value) => Ride(
      id: value['_id'],
      customer: value['customer'],
      date: DateTime.parse(value["date"]),
      detention: double.parse(value["detention"].toString()),
      lrNo: value["lrNo"],
      particular: value["particular"],
      quantity: double.parse(value["quantity"].toString()),
      rate: double.parse(value["rate"].toString()),
      truckNumber: value["truckNumber"],
      createdAt: DateTime.parse(value['createdAt']),
      updatedAt: DateTime.parse(value['updatedAt']),
      source: value['source'],
      destination: value['destination']);
}
