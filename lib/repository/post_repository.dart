import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:api_with_bloc/model/post_model.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  final String url = 'https://jsonplaceholder.typicode.com/comments';

  Future<List<PostModel>> fetchPost() async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as List;

        return body.map((dynamic e) {
          return PostModel(
            id: e['id'] as int,
            postId: e['postId'] as int,
            email: e['email'] as String,
            body: e['body'] as String,
          );
        }).toList();
      } else {
        throw Exception('Failed to load posts with status code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('Internet Exception: Please check your internet connection.');
    } on TimeoutException {
      throw Exception('Timeout Exception: The request timed out.');
    } on FormatException {
      throw Exception('Format Exception: Invalid response format.');
    } catch (e) {
      throw Exception('Error While Fetching Data: $e');
    }
  }
}
