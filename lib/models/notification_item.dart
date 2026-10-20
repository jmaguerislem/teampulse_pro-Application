enum NotifType { overdue, reminder, assignment }

class AppNotification {
  final String id;
  final NotifType type;
  final String taskId;
  final String taskTitle;
  final int days; // retard (overdue) ou jours restants (reminder)
  final String? memberName;

  const AppNotification({
    required this.id,
    required this.type,
    required this.taskId,
    required this.taskTitle,
    this.days = 0,
    this.memberName,
  });
}