import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../config/env.dart';

class OneSignalService {
  OneSignalService._();
  static final OneSignalService instance = OneSignalService._();

  bool _initialized = false;
  bool get isReady => _initialized && Env.hasOneSignal;

  Future<void> initialize() async {
    if (_initialized || !Env.hasOneSignal) return;

    OneSignal.initialize(Env.oneSignalAppId);
    OneSignal.Notifications.requestPermission(false);

    _initialized = true;
  }

  Future<void> login(String userId) async {
    if (!isReady) return;
    await OneSignal.login(userId);
  }

  Future<void> logout() async {
    if (!isReady) return;
    await OneSignal.logout();
  }
}
