import 'package:equatable/equatable.dart';

enum MentorSender { user, mentor }

class MentorMessage extends Equatable {
  const MentorMessage({
    required this.id,
    required this.sender,
    required this.content,
    required this.timestamp,
    this.thinking = false,
  });

  final String id;
  final MentorSender sender;
  final String content;
  final DateTime timestamp;
  final bool thinking;

  @override
  List<Object?> get props => [id, sender, content, timestamp, thinking];
}
