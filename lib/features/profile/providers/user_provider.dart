import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/emotional_theme.dart';

class UserProfile {
  const UserProfile({
    required this.name,
    required this.emotionalState,
    required this.disciplineGoal,
  });

  final String name;
  final EmotionalState emotionalState;
  final String disciplineGoal;

  UserProfile copyWith({
    String? name,
    EmotionalState? emotionalState,
    String? disciplineGoal,
  }) =>
      UserProfile(
        name: name ?? this.name,
        emotionalState: emotionalState ?? this.emotionalState,
        disciplineGoal: disciplineGoal ?? this.disciplineGoal,
      );
}

class UserProfileNotifier extends Notifier<UserProfile> {
  @override
  UserProfile build() {
    return const UserProfile(
      name: 'Abhinav',
      emotionalState: EmotionalState.neutral,
      disciplineGoal: 'Operate from identity, not motivation.',
    );
  }

  void setEmotionalState(EmotionalState state) {
    this.state = this.state.copyWith(emotionalState: state);
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }
}

final userProfileProvider =
    NotifierProvider<UserProfileNotifier, UserProfile>(UserProfileNotifier.new);

final emotionalThemeProvider = Provider<EmotionalTheme>((ref) {
  final state = ref.watch(
    userProfileProvider.select((p) => p.emotionalState),
  );
  return EmotionalTheme.from(state);
});
