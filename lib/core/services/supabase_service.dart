import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/env.dart';

/// Thin wrapper around Supabase initialization and access.
///
/// In dev, if no keys are configured the service runs in "offline" mode —
/// the rest of the app falls back to local mock data.
class SupabaseService {
  SupabaseService._();
  static final SupabaseService instance = SupabaseService._();

  bool _initialized = false;

  bool get isReady => _initialized && Env.hasSupabase;

  SupabaseClient? get clientOrNull => isReady ? Supabase.instance.client : null;

  SupabaseClient get client {
    final c = clientOrNull;
    if (c == null) {
      throw StateError(
        'Supabase is not configured. Set SUPABASE_URL and SUPABASE_ANON_KEY '
        'in your .env file.',
      );
    }
    return c;
  }

  Future<void> initialize() async {
    if (_initialized) return;
    if (!Env.hasSupabase) return;

    await Supabase.initialize(
      url: Env.supabaseUrl,
      anonKey: Env.supabaseAnonKey,
      debug: false,
    );
    _initialized = true;
  }

  Session? get currentSession => clientOrNull?.auth.currentSession;
  User? get currentUser => clientOrNull?.auth.currentUser;
}
