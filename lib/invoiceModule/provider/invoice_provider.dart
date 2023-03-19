import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:transport_app/invoiceModule/models/invoice.dart';
import 'package:transport_app/rideModule/model/ride_model.dart';
import 'package:transport_app/services/http_service.dart';

import '../../api.dart';

class InvoiceProvider with ChangeNotifier {
  List<Invoice> _invoices = [];

  List<Invoice> get invoices {
    return [..._invoices];
  }

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

    // print(response);
  }

  fetchInvoices() async {
    _invoices = [];
    try {
      final response = await HttpService.postRequest(
          url: domain + endPoints['fetchInvoices']!, body: {});

      if (response['success']) {
        response['result']
            .forEach((res) => _invoices.add(Invoice.jsonToInvoice(res)));
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }
}
