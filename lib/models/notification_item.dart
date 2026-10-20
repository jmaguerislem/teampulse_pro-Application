enum NotifType { overdue, reminder, assignment }

class AppNotification {
  final String id;
  final NotifType type;
  final String title;
  final String message;
  final String taskId;

  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.taskId,
  });
}
