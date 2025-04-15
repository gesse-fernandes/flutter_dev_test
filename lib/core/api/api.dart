import 'dart:convert';
import 'package:flutter_dev_test/core/api/api_config.dart';
import 'package:flutter_dev_test/core/api/models/api_response.dart';
import 'package:flutter_dev_test/core/api/response_parser.dart';
import 'package:flutter_dev_test/core/api/restClient.dart';
import 'package:http/http.dart' as http;

class HttpClientService {
  final String _baseUrl = ApiConfig.baseUrl;
  final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
  };

  Future<ApiResponse> request({
    required String method,
    required String endpoint,
    Map<String, dynamic>? query,
    dynamic data,
    int retries = 2,
  }) async {
    final uri = Uri.http(_baseUrl, endpoint, query);

    try {
      final response = await _sendRequest(method, uri, data);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse.fromHttp(response);
      }

      //parser customizado
      throw parseRestClientError(response);
    } on http.ClientException catch (e) {
      throw RestClientException(message: e.message);
    } catch (e) {
      if (retries > 0) {
        return await request(
          method: method,
          endpoint: endpoint,
          query: query,
          data: data,
          retries: retries - 1,
        );
      }
      rethrow;
    }
  }

  Future<http.Response> _sendRequest(
    String method,
    Uri uri,
    dynamic data,
  ) async {
    switch (method.toUpperCase()) {
      case 'POST':
        return await http.post(uri,
            headers: _defaultHeaders, body: jsonEncode(data));

      default:
        throw UnsupportedError('Método HTTP não suportado: $method');
    }
  }

  Future<ApiResponse> post(String path, {dynamic data}) =>
      request(method: 'POST', endpoint: path, data: data);
}
