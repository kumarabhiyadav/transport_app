import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:transport_app/invoiceModule/models/invoice.dart';

import '../../api.dart';

class InvoiceProvider with ChangeNotifier {
  createInvoice(Invoice invoice) async {
    final response =
        await http.post(Uri.parse(domain + endPoints['createInvoice']!), body: {
      'invoiceNo': invoice.invoiceNo,
      'customer': invoice.customer.id,
      'source': invoice.source,
      'destination': invoice.destination,
      'rides': invoice.rides.map((ride) => {
            'truckNumber': ride.truckNumber,
            'lrNo': ride.lrNo,
            'date': ride.date.toIso8601String(),
            'particular': ride.particular,
            'quantity': ride.quantity,
            'rate': ride.rate,
            'detention': ride.destination,
            'customer': invoice.customer.id,
            'source': invoice.source,
            'destination': invoice.destination
          })
    });
  }
}
