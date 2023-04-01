import 'package:flutter/foundation.dart';
import 'package:transport_app/api.dart';
import 'package:transport_app/services/http_service.dart';

class CommunityProvider with ChangeNotifier {
  List listOfPosts = [];
  List comments = [];

  createNewPost(body, filePath, token) async {
    final response = await HttpService.postFormData(
        url: domain + endPoints['createNewPost'].toString(),
        body: body,
        filePath: filePath,
        token: token);
    return response;
  }

  fetchPosts(token) async {
    final response = await HttpService.postRequest(
        url: domain + endPoints['fetchPosts'].toString(),
        body: {},
        token: token);

    if (response['success']) {
      listOfPosts = response['result'];
      notifyListeners();
    }
  }

  fetchCommentsByPost(token) async {
    final response = await HttpService.postRequest(
        url: domain + endPoints['fetchPosts'].toString(),
        body: {},
        token: token);

    if (response['success']) {
      listOfPosts = response['result'];
      notifyListeners();
    }
  }

  createComment(
      {required String token, required Map<String, String> body}) async {
    final response = await HttpService.postRequest(
        url: domain + endPoints['createComment'].toString(),
        body: body,
        token: token);

    if (response['success']) {
      comments.insert(0, response['result']);
      notifyListeners();
      return response;
    }
  }

  fetchComment(
      {required String token, required Map<String, String> body}) async {
    comments = [];
    notifyListeners();
    final response = await HttpService.postRequest(
        url: domain + endPoints['fetchComment'].toString(),
        body: body,
        token: token);

    if (response['success']) {
      comments = response['result'];
      notifyListeners();
    }
  }
}
