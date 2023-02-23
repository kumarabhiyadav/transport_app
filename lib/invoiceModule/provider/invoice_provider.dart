import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:transport_app/invoiceModule/models/invoice.dart';
import 'package:transport_app/rideModule/model/ride_model.dart';
import 'package:transport_app/services/http_service.dart';

import '../../api.dart';

class InvoiceProvider with ChangeNotifier {
  createInvoice(Invoice invoice) async {
    final response = await HttpService.postRequest(
        url: domain + endPoints['createInvoice']!,
        body: {
          'invoiceNo': invoice.invoiceNo,
          'customer': invoice.customer.id,
          'source': invoice.source,
          'destination': invoice.destination,
          'date': invoice.date.toIso8601String(),
          'advance': invoice.advance,
          'rides':
              jsonEncode(invoice.rides.map((e) => Ride.rideToJson(e)).toList()),
        });

    print(response);
  }
}
