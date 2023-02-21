import 'package:transport_app/customerModule/model/customer.dart';
import 'package:transport_app/rideModule/model/ride_model.dart';

class Invoice {
  final String id;
  final String invoiceNo;
  final Customer customer;
  final DateTime date;
  final String source;
  final String destination;
  final double advance;
  final List<Ride> rides;

  Invoice(
      {required this.advance,
      required this.customer,
      required this.date,
      required this.destination,
      required this.id,
      required this.invoiceNo,
      required this.rides,
      required this.source});


      static jsonToInvoice(value) => Invoice(advance: value['advance'], customer: Customer.jsonToCustomer(value['customer']), date: DateTime.parse(value['date']), destination: value['destination'], id: value['_id'], invoiceNo: value['invoiceNo'], rides: value['rides'].map((value)), source: source)
}
