import 'dart:convert';

import '../gameCore/PlayerClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static Future<void> remove(String key) {
    return _prefs.remove(key);
  }

  static Future<void> addSessionTokensObject({
    required String roomCode,
    required SessionTokens tokens,
  }) async {
    final String? stored = _prefs.getString('sessionTokens');
    final Map<String, dynamic> sessions = stored != null ? jsonDecode(stored) : {};

    sessions[roomCode] = {
      'answering': tokens.answering,
      'reconnection': tokens.reconnection,
    };

    await _prefs.setString('sessionTokens', jsonEncode(sessions));
  }

  static Future<void> addHostToken({
    required String roomCode,
    required String token,
  }) async {
    final String? stored = _prefs.getString('hostTokens');
    final Map<String, dynamic> hosts = stored != null ? jsonDecode(stored) : {};

    hosts[roomCode] = token;

    await _prefs.setString('hostTokens', jsonEncode(hosts));
  }
}