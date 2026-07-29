import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/services/onesignal_service.dart';
import 'core/services/posthog_service.dart';
import 'core/services/storage_service.dart';
import 'core/services/supabase_service.dart';
import 'core/theme/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.background,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Env first — every service depends on it.
  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {
    // No .env file is OK during initial scaffolding; services run offline.
  }

  // Initialize app services in parallel where possible.
  await Future.wait([
    StorageService.instance.initialize(),
    SupabaseService.instance.initialize(),
    OneSignalService.instance.initialize(),
    PostHogService.instance.initialize(),
  ]);

  runApp(const ProviderScope(child: BrutalModeApp()));
}
