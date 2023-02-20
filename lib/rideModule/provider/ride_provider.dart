import 'package:flutter/foundation.dart';
import 'package:transport_app/api.dart';
import 'package:transport_app/rideModule/model/ride_model.dart';
import 'package:transport_app/services/http_service.dart';

class RideProvider with ChangeNotifier {
  List<Ride> rides = [];

  fetchRides() async {
    rides = [];
    final response = await HttpService.postRequest(
        url: domain + endPoints['fetchRides']!, body: {});
    if (response['success']) {
      response['result'].forEach((value) {
        rides.add(Ride.jsonToRide(value));
      });
      notifyListeners();
    }
  }

  createRide(Ride ride) async {
    try {
      final response = await HttpService.postRequest(
          url: domain + endPoints['createRide']!,
          body: {
            "truckNumber": ride.truckNumber,
            "lrNo": ride.lrNo,
            "date": ride.date.toIso8601String(),
            "particular": ride.particular,
            "quantity": ride.quantity,
            "rate": ride.rate,
            "detention": ride.detention,
            "customer": ride.customer,
            "source": ride.source,
            "destination": ride.destination
          });
      if (response['success']) {
        rides.add(Ride.jsonToRide(response['result']));
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
