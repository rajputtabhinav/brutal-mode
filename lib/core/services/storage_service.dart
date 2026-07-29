import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Two-tier storage:
///   - secure: tokens, auth state
///   - preferences: user toggles, onboarding flags
class StorageService {
  StorageService._();
  static final StorageService instance = StorageService._();

  final FlutterSecureStorage _secure = const FlutterSecureStorage();
  SharedPreferences? _prefs;

  Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Secure
  Future<void> setSecure(String key, String value) =>
      _secure.write(key: key, value: value);
  Future<String?> getSecure(String key) => _secure.read(key: key);
  Future<void> deleteSecure(String key) => _secure.delete(key: key);

  // Prefs
  bool getBool(String key, {bool fallback = false}) =>
      _prefs?.getBool(key) ?? fallback;
  Future<void> setBool(String key, bool value) async =>
      _prefs?.setBool(key, value);

  String? getString(String key) => _prefs?.getString(key);
  Future<void> setString(String key, String value) async =>
      _prefs?.setString(key, value);

  int getInt(String key, {int fallback = 0}) =>
      _prefs?.getInt(key) ?? fallback;
  Future<void> setInt(String key, int value) async =>
      _prefs?.setInt(key, value);
}

/// Centralized storage keys — keeps strings out of business code.
class StorageKeys {
  StorageKeys._();
  static const onboardingComplete = 'onboarding_complete';
  static const userName = 'user_name';
  static const wakeHour = 'wake_hour';
  static const sleepHour = 'sleep_hour';
  static const emotionalState = 'emotional_state';
}
