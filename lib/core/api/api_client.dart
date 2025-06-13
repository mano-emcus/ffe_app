import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final http.Client _client;
  
  // Default timeout duration
  static const Duration timeoutDuration = Duration(seconds: 30);

  ApiClient({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  // Generic GET request
  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse(baseUrl + endpoint).replace(
        queryParameters: queryParameters,
      );

      final response = await _client
          .get(uri, headers: headers)
          .timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Generic POST request
  Future<dynamic> post(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse(baseUrl + endpoint).replace(
        queryParameters: queryParameters,
      );

      final response = await _client
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              ...?headers,
            },
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Generic PUT request
  Future<dynamic> put(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse(baseUrl + endpoint).replace(
        queryParameters: queryParameters,
      );

      final response = await _client
          .put(
            uri,
            headers: {
              'Content-Type': 'application/json',
              ...?headers,
            },
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Generic DELETE request
  Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse(baseUrl + endpoint).replace(
        queryParameters: queryParameters,
      );

      final response = await _client
          .delete(uri, headers: headers)
          .timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    } else {
      throw ApiException(
        statusCode: response.statusCode,
        message: response.body,
      );
    }
  }

  Exception _handleError(dynamic error) {
    if (error is ApiException) return error;
    if (error is http.ClientException) {
      return ApiException(
        statusCode: 0,
        message: 'Network error: ${error.message}',
      );
    }
    return ApiException(
      statusCode: 0,
      message: 'Unexpected error: $error',
    );
  }

  void dispose() {
    _client.close();
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException({
    required this.statusCode,
    required this.message,
  });

  @override
  String toString() => 'ApiException: [$statusCode] $message';
} 