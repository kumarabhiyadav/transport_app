import 'package:flutter/foundation.dart';
import 'package:transport_app/api.dart';
import 'package:transport_app/rideModule/model/ride_model.dart';
import 'package:transport_app/services/http_service.dart';

class RideProvider with ChangeNotifier {
  List<Ride> rides = [];

  fetchRides() async {
    final response = await HttpService.postRequest(
        url: domain + endPoints['fetchRides']!, body: {});
    if (response['success']) {
      response['result'].forEach((value) {
        rides.add(Ride.rideToJson(value));
      });
      notifyListeners();
    }
  }
}
