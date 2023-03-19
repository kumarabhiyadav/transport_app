import 'package:flutter/cupertino.dart';
import 'package:transport_app/customerModule/model/customer.dart';

import '../../api.dart';
import '../../services/http_service.dart';

class CustomerProvider with ChangeNotifier {
  List<Customer> customers = [];

  createCustomer({required Map<String, dynamic> body}) async {
    final response = await HttpService.postRequest(
        url: domain + endPoints['createCustomer']!, body: body);

    if (response['success']) {
      customers.add(Customer.jsonToCustomer(response['result']));
      notifyListeners();
      return response['result'];
    } else {
      return null;
    }
  }

  fetchCustomers() async {
    customers = [];
    final response = await HttpService.postRequest(
        url: domain + endPoints['fetchCustomers']!, body: {});

    if (response['success']) {
      // customers.add(Customer.jsonToRide(response['result']));
      response['result']
          .forEach((value) => customers.add(Customer.jsonToCustomer(value)));
      notifyListeners();
      return response['result'];
    } else {
      return null;
    }
  }

  searchCustomer(String query) async {
    customers = [];
    final response = await HttpService.postRequest(
        url: domain + endPoints['fetchCustomers']!, body: {'query': query});

    if (response['success']) {
      // customers.add(Customer.jsonToRide(response['result']));
      response['result']
          .forEach((value) => customers.add(Customer.jsonToCustomer(value)));
      notifyListeners();
      return customers;
    } else {
      return null;
    }
  }
}
