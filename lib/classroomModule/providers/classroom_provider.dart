import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:transport_app/api.dart';
import 'package:transport_app/services/http_service.dart';

class ClassRoomProvider with ChangeNotifier {
  List classRooms = [];

  createClassRoom({required String token, required String name}) async {
    final response = await HttpService.postRequest(
        url: domain + endPoints['createClassroom']!,
        body: {'name': name},
        token: token);
    if (response['success']) {
      classRooms.insert(0, response['result']);
    }
  }
}
