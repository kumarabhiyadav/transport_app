import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  static postRequest(
      {required String url,
      required Map<String, String> body,
      required String token}) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    try {
      final response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      final responseData = json.decode(response.body);

      return responseData;
    } catch (e) {
      rethrow;
    }
  }

  static postFormData(
      {required String url,
      required Map<String, String> body,
      required filePath,
      required String token}) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    request.headers.addAll({"Authorization": "Bearer $token"});
    if (filePath != '') {
      request.files.add(await http.MultipartFile.fromPath("photo", filePath));
    }
    request.fields.addAll(body);
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);
    print(responseData);
    return responseData;
  }
}
