import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/services/openai_service.dart';
import '../../../core/services/posthog_service.dart';
import '../../tasks/providers/tasks_provider.dart';
import '../models/mentor_message.dart';

final _uuid = const Uuid();

class MentorState {
  const MentorState({
    required this.messages,
    required this.isThinking,
  });

  final List<MentorMessage> messages;
  final bool isThinking;

  MentorState copyWith({
    List<MentorMessage>? messages,
    bool? isThinking,
  }) =>
      MentorState(
        messages: messages ?? this.messages,
        isThinking: isThinking ?? this.isThinking,
      );
}

class MentorNotifier extends Notifier<MentorState> {
  @override
  MentorState build() {
    return MentorState(
      messages: [
        MentorMessage(
          id: _uuid.v4(),
          sender: MentorSender.mentor,
          content:
              'Good to see you. What are we sharpening today?',
          timestamp: DateTime.now(),
        ),
      ],
      isThinking: false,
    );
  }

  Future<void> send(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || state.isThinking) return;

    final userMsg = MentorMessage(
      id: _uuid.v4(),
      sender: MentorSender.user,
      content: trimmed,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMsg],
      isThinking: true,
    );

    unawaited(PostHogService.instance.mentorMessageSent(trimmed.length));

    try {
      final history = state.messages
          .where((m) => !m.thinking)
          .map(
            (m) => ChatTurn(
              role: m.sender == MentorSender.user
                  ? ChatRole.user
                  : ChatRole.assistant,
              content: m.content,
            ),
          )
          .toList();

      final score = ref.read(disciplineScoreProvider);
      final reply = await OpenAiService.instance.complete(
        history: history,
        userContext: 'Discipline score today: $score/100',
      );

      final mentorMsg = MentorMessage(
        id: _uuid.v4(),
        sender: MentorSender.mentor,
        content: reply.isEmpty
            ? 'I\'m here. Try a smaller, more specific question.'
            : reply,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, mentorMsg],
        isThinking: false,
      );
    } catch (_) {
      state = state.copyWith(
        messages: [
          ...state.messages,
          MentorMessage(
            id: _uuid.v4(),
            sender: MentorSender.mentor,
            content:
                'I lost the connection for a moment. Try again — same thought, fresh attempt.',
            timestamp: DateTime.now(),
          ),
        ],
        isThinking: false,
      );
    }
  }

  void clear() {
    state = build();
  }
}

final mentorProvider =
    NotifierProvider<MentorNotifier, MentorState>(MentorNotifier.new);
