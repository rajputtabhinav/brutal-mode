import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Centralized typed access to environment variables.
///
/// Missing values return empty strings — caller decides how strict to be.
class Env {
  Env._();

  static String get supabaseUrl => dotenv.maybeGet('SUPABASE_URL') ?? '';
  static String get supabaseAnonKey =>
      dotenv.maybeGet('SUPABASE_ANON_KEY') ?? '';

  static String get openAiKey => dotenv.maybeGet('OPENAI_API_KEY') ?? '';
  static String get openAiModel =>
      dotenv.maybeGet('OPENAI_MODEL') ?? 'gpt-4o-mini';

  static String get postHogKey => dotenv.maybeGet('POSTHOG_API_KEY') ?? '';
  static String get postHogHost =>
      dotenv.maybeGet('POSTHOG_HOST') ?? 'https://us.i.posthog.com';

  static String get oneSignalAppId =>
      dotenv.maybeGet('ONESIGNAL_APP_ID') ?? '';

  static bool get hasSupabase =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
  static bool get hasOpenAi => openAiKey.isNotEmpty;
  static bool get hasPostHog => postHogKey.isNotEmpty;
  static bool get hasOneSignal => oneSignalAppId.isNotEmpty;
}
