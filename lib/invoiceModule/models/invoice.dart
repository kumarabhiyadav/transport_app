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
  final double total;

  Invoice(
      {required this.advance,
      required this.customer,
      required this.date,
      required this.destination,
      required this.id,
      required this.invoiceNo,
      required this.rides,
      required this.source,
      required this.total});

  static jsonToInvoice(value) => Invoice(
      advance: value['advance'].toDouble(),
      customer: Customer.jsonToCustomer(value['customer']),
      date: DateTime.parse(value['date']),
      destination: value['destination'],
      id: value['_id'],
      invoiceNo: value['invoiceNo'],
      rides: List<Ride>.from(
          value['rides'].map((ride) => Ride.jsonToRide(ride)).toList()),
      source: value['source'],
      total: value['total'] == null ? 0.0 : value['total'].toDouble());

       double getRideTotal (){
        double total = 0.0;
        for (var ride in rides) { 
          total+=(ride.rate * ride.quantity);
        }
        return total;
        }
        
}
