import 'package:posthog_flutter/posthog_flutter.dart';
import '../config/env.dart';

/// Wraps PostHog so the rest of the app uses one named method per event.
class PostHogService {
  PostHogService._();
  static final PostHogService instance = PostHogService._();

  bool _initialized = false;
  bool get isReady => _initialized && Env.hasPostHog;

  /// Must be called from main() before runApp.
  Future<void> initialize() async {
    if (_initialized || !Env.hasPostHog) return;
    final config = PostHogConfig(Env.postHogKey)
      ..host = Env.postHogHost
      ..captureApplicationLifecycleEvents = true
      ..debug = false;
    await Posthog().setup(config);
    _initialized = true;
  }

  Future<void> identify(
    String userId, {
    Map<String, dynamic>? props,
  }) async {
    if (!isReady) return;
    await Posthog().identify(userId: userId, userProperties: props);
  }

  Future<void> screen(String name, {Map<String, dynamic>? props}) async {
    if (!isReady) return;
    await Posthog().screen(screenName: name, properties: props);
  }

  Future<void> event(String name, {Map<String, dynamic>? props}) async {
    if (!isReady) return;
    await Posthog().capture(eventName: name, properties: props);
  }

  // Domain-specific helpers — event names typed in one place.
  Future<void> taskCompleted(String taskId) =>
      event('task_completed', props: {'task_id': taskId});

  Future<void> reflectionSubmitted({required String mood}) =>
      event('reflection_submitted', props: {'mood': mood});

  Future<void> mentorMessageSent(int charLength) =>
      event('mentor_message_sent', props: {'length': charLength});
}
