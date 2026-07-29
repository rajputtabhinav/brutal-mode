import 'package:equatable/equatable.dart';

enum TaskPriority { low, normal, high }

class BrutalTask extends Equatable {
  const BrutalTask({
    required this.id,
    required this.title,
    this.notes,
    required this.priority,
    required this.completed,
    required this.createdAt,
    this.dueAt,
    this.tag,
  });

  final String id;
  final String title;
  final String? notes;
  final TaskPriority priority;
  final bool completed;
  final DateTime createdAt;
  final DateTime? dueAt;
  final String? tag;

  BrutalTask copyWith({
    String? title,
    String? notes,
    TaskPriority? priority,
    bool? completed,
    DateTime? dueAt,
    String? tag,
  }) {
    return BrutalTask(
      id: id,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      priority: priority ?? this.priority,
      completed: completed ?? this.completed,
      createdAt: createdAt,
      dueAt: dueAt ?? this.dueAt,
      tag: tag ?? this.tag,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, notes, priority, completed, createdAt, dueAt, tag];
}
