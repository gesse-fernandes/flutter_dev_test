import 'dart:convert';

import 'package:http/http.dart';

class ApiResponse {
  final Map<String, dynamic> data;
  final int status;

  ApiResponse({required this.data, required this.status});

  factory ApiResponse.fromHttp(Response response) {
    final body = response.body.isNotEmpty ? response.body : '{}';
    return ApiResponse(
      data: _parseJson(body),
      status: response.statusCode,
    );
  }

  static Map<String, dynamic> _parseJson(String body) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      } else if (decoded is List) {
        return {'responses': decoded};
      } else {
        return {'response': decoded};
      }
    } catch (e) {
      return {'error': 'Invalid JSON'};
    }
  }
}
