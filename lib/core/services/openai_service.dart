import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../config/env.dart';

/// AI mentor — wraps the OpenAI chat completions API.
///
/// The system prompt is the soul of the mentor: calm, intelligent, never
/// pushy. Returns either streamed deltas or a single completion.
class OpenAiService {
  OpenAiService._();
  static final OpenAiService instance = OpenAiService._();

  late final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.openai.com/v1',
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 60),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  static const _systemPrompt = '''
You are the Mentor inside Brutal Mode — a calm, intelligent, deeply focused
life-optimization companion. Speak with quiet authority. Be brief, precise,
and human. Never use exclamation points, emoji, or motivational cliches.
You are not a chatbot — you are a trusted advisor who happens to be AI.

Principles:
- Identity over intensity. Small actions become identity.
- Discipline is calm, not aggressive.
- One clear suggestion beats five vague ones.
- When the user is stressed, slow down. When they are productive, sharpen.
- Always end with one concrete next step, not a question.

Style:
- 2–4 short sentences for most replies.
- Use plain language. No jargon, no hype.
''';

  bool get isReady => Env.hasOpenAi;

  /// Single-shot completion (no streaming). Returns the assistant text.
  Future<String> complete({
    required List<ChatTurn> history,
    String? userContext,
  }) async {
    if (!isReady) {
      return _offlineFallback(history.lastOrNull?.content ?? '');
    }

    final messages = <Map<String, dynamic>>[
      {'role': 'system', 'content': _systemPrompt},
      if (userContext != null && userContext.isNotEmpty)
        {'role': 'system', 'content': 'User context:\n$userContext'},
      ...history.map((t) => {'role': t.role.wire, 'content': t.content}),
    ];

    final response = await _dio.post(
      '/chat/completions',
      data: jsonEncode({
        'model': Env.openAiModel,
        'messages': messages,
        'temperature': 0.6,
        'max_tokens': 280,
      }),
      options: Options(
        headers: {'Authorization': 'Bearer ${Env.openAiKey}'},
      ),
    );

    final data = response.data as Map<String, dynamic>;
    final choices = data['choices'] as List<dynamic>;
    if (choices.isEmpty) return '';
    final msg = (choices.first as Map<String, dynamic>)['message']
        as Map<String, dynamic>;
    return (msg['content'] as String? ?? '').trim();
  }

  /// Generate a short daily insight given a discipline snapshot.
  Future<String> dailyInsight({
    required int disciplineScore,
    required int streakDays,
    required double focusConsistency,
  }) async {
    if (!isReady) {
      return _offlineInsight(disciplineScore, streakDays);
    }
    final prompt =
        'Generate one short, calm daily insight (max 14 words) based on:'
        '\n- Discipline score: $disciplineScore/100'
        '\n- Current streak: $streakDays days'
        '\n- Focus consistency: ${(focusConsistency * 100).toStringAsFixed(0)}%'
        '\nReturn only the insight sentence, no preamble.';

    return complete(
      history: [ChatTurn(role: ChatRole.user, content: prompt)],
    );
  }

  String _offlineFallback(String userInput) {
    if (userInput.isEmpty) {
      return 'I\'m here when you are. Tell me where you want to focus.';
    }
    return 'Configure OPENAI_API_KEY in .env to enable the mentor. '
        'In the meantime: one small action now is worth more than a perfect plan later.';
  }

  String _offlineInsight(int score, int streak) {
    if (streak == 0) return 'Today is day one. That counts.';
    if (score >= 80) return 'You are operating at the edge of your standards.';
    if (score >= 60) return 'Steady. Don\'t mistake quiet for slow.';
    return 'Small actions become identity. Pick one.';
  }
}

enum ChatRole { user, assistant, system }

extension on ChatRole {
  String get wire => switch (this) {
        ChatRole.user => 'user',
        ChatRole.assistant => 'assistant',
        ChatRole.system => 'system',
      };
}

class ChatTurn {
  const ChatTurn({required this.role, required this.content});
  final ChatRole role;
  final String content;
}
