import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  static postRequest(
      {required String url, required Map<String, dynamic> body}) async {
    const Map<String, String> headers = {"Content-Type": "application/json"};

    // try {
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));

    final responseData = json.decode(response.body);

    return responseData;
    // } catch (e) {
    //   rethrow;
    // }
  }
}
