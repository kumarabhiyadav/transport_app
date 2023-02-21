import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../api.dart';

class InvoiceProvider with ChangeNotifier {
  createInvoice() async {
    final response = await http
        .post(Uri.parse(domain + endPoints['createInvoice']!), body: {});
  }
}
