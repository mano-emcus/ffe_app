import 'package:shared_preferences/shared_preferences.dart';

class TokenStorageService {
  static const String _idTokenKey = 'id_token';
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _tokenTypeKey = 'token_type';
  static const String _expiresInKey = 'expires_in';

  final SharedPreferences _prefs;

  TokenStorageService(this._prefs);

  // Save all tokens from the auth response
  Future<void> saveTokens(Map<String, dynamic> tokens) async {
    await Future.wait([
      _prefs.setString(_idTokenKey, tokens['IdToken'] ?? ''),
      _prefs.setString(_accessTokenKey, tokens['AccessToken'] ?? ''),
      _prefs.setString(_refreshTokenKey, tokens['RefreshToken'] ?? ''),
      _prefs.setString(_tokenTypeKey, tokens['TokenType'] ?? ''),
      _prefs.setInt(_expiresInKey, tokens['ExpiresIn'] ?? 0),
    ]);
  }

  // Get the ID token
  String? getIdToken() => _prefs.getString(_idTokenKey);

  // Get the access token
  String? getAccessToken() => _prefs.getString(_accessTokenKey);

  // Get the refresh token
  String? getRefreshToken() => _prefs.getString(_refreshTokenKey);

  // Get the token type
  String? getTokenType() => _prefs.getString(_tokenTypeKey);

  // Get the expiration time
  int? getExpiresIn() => _prefs.getInt(_expiresInKey);

  // Check if user is logged in
  bool isLoggedIn() {
    final idToken = getIdToken();
    return idToken != null && idToken.isNotEmpty;
  }

  // Clear all tokens (logout)
  Future<void> clearTokens() async {
    await Future.wait([
      _prefs.remove(_idTokenKey),
      _prefs.remove(_accessTokenKey),
      _prefs.remove(_refreshTokenKey),
      _prefs.remove(_tokenTypeKey),
      _prefs.remove(_expiresInKey),
    ]);
  }
} 