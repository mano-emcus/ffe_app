import 'dart:convert';
import 'package:ffe_app/core/api/api_client.dart';
import 'package:ffe_app/core/services/token_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final ApiClient _apiClient;
  static const String _baseUrl = 'https://ipgsm.emcus.co.in';
  TokenStorageService? _tokenStorage;
  bool _isInitialized = false;

  AuthService() : _apiClient = ApiClient(baseUrl: _baseUrl);

  Future<void> initTokenStorage() async {
    if (_isInitialized) return;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      _tokenStorage = TokenStorageService(prefs);
      _isInitialized = true;
    } catch (e) {
      _isInitialized = false;
      rethrow;
    }
  }

  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    if (!_isInitialized) {
      await initTokenStorage();
    }

    try {
      final response = await _apiClient.post(
        '/api/auth/signin',
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response is! Map<String, dynamic>) {
        throw ApiException(
          statusCode: 0,
          message: 'Invalid response format from server',
        );
      }

      if (response['statusCode'] == 1) {
        final data = response['data'];
        if (data is! List || data.isEmpty) {
          throw ApiException(
            statusCode: 0,
            message: 'Invalid data format in response',
          );
        }

        final tokenData = data.first;
        if (tokenData is! Map<String, dynamic>) {
          throw ApiException(
            statusCode: 0,
            message: 'Invalid token data format',
          );
        }

        // Store tokens
        await _tokenStorage?.saveTokens(tokenData);
        return tokenData;
      } else {
        throw ApiException(
          statusCode: response['statusCode'] ?? 0,
          message: response['message'] ?? 'Unknown error occurred',
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        statusCode: 0,
        message: 'Failed to sign in: ${e.toString()}',
      );
    }
  }

  Future<void> signOut() async {
    if (!_isInitialized) {
      await initTokenStorage();
    }
    await _tokenStorage?.clearTokens();
  }

  Future<bool> isLoggedIn() async {
    if (!_isInitialized) {
      await initTokenStorage();
    }
    return _tokenStorage?.isLoggedIn() ?? false;
  }

  Future<String?> getIdToken() async {
    if (!_isInitialized) {
      await initTokenStorage();
    }
    return _tokenStorage?.getIdToken();
  }

  Future<String?> getAccessToken() async {
    if (!_isInitialized) {
      await initTokenStorage();
    }
    return _tokenStorage?.getAccessToken();
  }
} 