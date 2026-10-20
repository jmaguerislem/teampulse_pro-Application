enum ProjectStatus { inProgress, done, onHold }

enum TaskStatus { todo, inProgress, done }

enum TaskPriority { high, medium, low }

class Project {
  final String id;
  String name;
  String description;
  DateTime startDate;
  DateTime deadline;
  ProjectStatus status;

  Project({
    required this.id,
    required this.name,
    this.description = '',
    required this.startDate,
    required this.deadline,
    this.status = ProjectStatus.inProgress,
  });
}

class Task {
  final String id;
  final String projectId;
  String title;
  String description;
  DateTime dueDate;
  TaskPriority priority;
  TaskStatus status;
  String? assignee;
  DateTime createdAt;
  DateTime? completedAt;

  Task({
    required this.id,
    required this.projectId,
    required this.title,
    this.description = '',
    required this.dueDate,
    this.priority = TaskPriority.medium,
    this.status = TaskStatus.todo,
    this.assignee,
    DateTime? createdAt,
    this.completedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  bool get isLate {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return status != TaskStatus.done && dueDate.isBefore(today);
  }
}

class Member {
  final String id;
  String name;
  String role;
  bool isLead;

  Member({
    required this.id,
    required this.name,
    required this.role,
    this.isLead = false,
  });

  String get initials {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}