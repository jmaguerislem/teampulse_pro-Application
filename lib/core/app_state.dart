import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../models/notification_item.dart';

class DayStat {
  final int done;
  final int inProgress;
  final int overdue;
  const DayStat(this.done, this.inProgress, this.overdue);
}

class ReportData {
  final int total;
  final int done;
  final int overdue;
  final Duration? avgResolution;
  const ReportData({
    required this.total,
    required this.done,
    required this.overdue,
    required this.avgResolution,
  });

  double get successRate => total == 0 ? 0 : done / total;
}

class AppState extends ChangeNotifier {
  final List<Project> _projects = [];
  final List<Task> _tasks = [];
  final List<Member> _members = [];
  final Set<String> _readNotifs = {};

  List<Project> get projects => List.unmodifiable(_projects);
  List<Task> get tasks => List.unmodifiable(_tasks);
  List<Member> get members => List.unmodifiable(_members);

  // ---------- Statistiques globales ----------
  int get projectCount => _projects.length;
  int get projectsInProgress =>
      _projects.where((p) => p.status == ProjectStatus.inProgress).length;
  int get projectsDone =>
      _projects.where((p) => p.status == ProjectStatus.done).length;

  int get taskCount => _tasks.length;
  int get tasksDone =>
      _tasks.where((t) => t.status == TaskStatus.done).length;
  int get tasksLate => _tasks.where((t) => t.isLate).length;
  int get tasksActive => taskCount - tasksDone - tasksLate;

  double get globalProgress => taskCount == 0 ? 0 : tasksDone / taskCount;

  // ---------- Par projet ----------
  Project? projectById(String id) {
    for (final p in _projects) {
      if (p.id == id) return p;
    }
    return null;
  }

  List<Task> tasksOf(String projectId) =>
      _tasks.where((t) => t.projectId == projectId).toList();

  int tasksDoneOf(String projectId) => tasksOf(projectId)
      .where((t) => t.status == TaskStatus.done)
      .length;

  int tasksLateOf(String projectId) =>
      tasksOf(projectId).where((t) => t.isLate).length;

  double projectProgress(String projectId) {
    final total = tasksOf(projectId).length;
    return total == 0 ? 0 : tasksDoneOf(projectId) / total;
  }

  bool isProjectLate(Project p) {
    if (p.status == ProjectStatus.done) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return p.deadline.isBefore(today);
  }

  List<Project> get upcomingProjects {
    final list =
        _projects.where((p) => p.status != ProjectStatus.done).toList();
    list.sort((a, b) => a.deadline.compareTo(b.deadline));
    return list.take(2).toList();
  }

  // ---------- Membres ----------
  Member? memberById(String id) {
    for (final m in _members) {
      if (m.id == id) return m;
    }
    return null;
  }

  int tasksOfMember(String memberId) =>
      _tasks.where((t) => t.assignee == memberId).length;

  List<Task> tasksOnDay(DateTime day) => _tasks
      .where((t) =>
          t.dueDate.year == day.year &&
          t.dueDate.month == day.month &&
          t.dueDate.day == day.day)
      .toList();

  // ---------- Notifications (générées automatiquement) ----------
  List<AppNotification> get notifications {
    final list = <AppNotification>[];
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    for (final t in _tasks) {
      if (t.status == TaskStatus.done) continue;
      final due = DateTime(t.dueDate.year, t.dueDate.month, t.dueDate.day);
      final diff = due.difference(today).inDays;

      if (diff < 0) {
        list.add(AppNotification(
          id: 'overdue_${t.id}',
          type: NotifType.overdue,
          taskId: t.id,
          taskTitle: t.title,
          days: -diff,
        ));
      } else if (diff <= 2) {
        list.add(AppNotification(
          id: 'reminder_${t.id}',
          type: NotifType.reminder,
          taskId: t.id,
          taskTitle: t.title,
          days: diff,
        ));
      }

      if (t.assignee != null) {
        final m = memberById(t.assignee!);
        if (m != null) {
          list.add(AppNotification(
            id: 'assign_${t.id}_${m.id}',
            type: NotifType.assignment,
            taskId: t.id,
            taskTitle: t.title,
            memberName: m.name,
          ));
        }
      }
    }

    list.sort((a, b) => a.type.index.compareTo(b.type.index));
    return list;
  }

  bool isRead(String id) => _readNotifs.contains(id);

  int get unreadCount =>
      notifications.where((n) => !_readNotifs.contains(n.id)).length;

  void markRead(String id) {
    if (_readNotifs.add(id)) notifyListeners();
  }

  void markAllRead() {
    for (final n in notifications) {
      _readNotifs.add(n.id);
    }
    notifyListeners();
  }

  // ---------- Graphique : évolution jour par jour ----------
  List<DayStat> statsSeries(int days) {
    final now = DateTime.now();
    return List.generate(days, (i) {
      final day = DateTime(now.year, now.month, now.day - (days - 1 - i));
      final end = DateTime(day.year, day.month, day.day + 1);
      var done = 0;
      var active = 0;
      var overdue = 0;

      for (final t in _tasks) {
        if (!t.createdAt.isBefore(end)) continue;
        final completed = t.status == TaskStatus.done &&
            t.completedAt != null &&
            t.completedAt!.isBefore(end);
        if (completed) {
          done++;
          continue;
        }
        final due = DateTime(t.dueDate.year, t.dueDate.month, t.dueDate.day);
        if (due.isBefore(day)) {
          overdue++;
        } else {
          active++;
        }
      }
      return DayStat(done, active, overdue);
    });
  }

  // ---------- Rapports ----------
  /// projectId null = rapport global
  ReportData reportFor(String? projectId) {
    final list = projectId == null ? _tasks : tasksOf(projectId);
    final done = list.where((t) => t.status == TaskStatus.done).toList();

    final times = done
        .where((t) => t.completedAt != null)
        .map((t) => t.completedAt!.difference(t.createdAt))
        .toList();

    Duration? avg;
    if (times.isNotEmpty) {
      final sum = times.fold<int>(0, (a, b) => a + b.inMicroseconds);
      final micro = sum ~/ times.length;
      avg = Duration(microseconds: micro < 0 ? 0 : micro);
    }

    return ReportData(
      total: list.length,
      done: done.length,
      overdue: list.where((t) => t.isLate).length,
      avgResolution: avg,
    );
  }

  // ---------- Actions ----------
  String newId() => DateTime.now().microsecondsSinceEpoch.toString();

  void addProject(Project p) {
    _projects.add(p);
    notifyListeners();
  }

  void removeProject(String id) {
    _projects.removeWhere((p) => p.id == id);
    _tasks.removeWhere((t) => t.projectId == id);
    notifyListeners();
  }

  void addTask(Task t) {
    _tasks.add(t);
    notifyListeners();
  }

  void removeTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void setTaskStatus(String id, TaskStatus status) {
    final t = taskById(id);
    if (t == null) return;
    t.status = status;
    t.completedAt = status == TaskStatus.done ? DateTime.now() : null;
    notifyListeners();
  }

  Task? taskById(String id) {
    for (final t in _tasks) {
      if (t.id == id) return t;
    }
    return null;
  }

  void updateTask(Task updated) {
    final i = _tasks.indexWhere((t) => t.id == updated.id);
    if (i == -1) return;
    _tasks[i] = updated;
    notifyListeners();
  }

  void addMember(Member m) {
    _members.add(m);
    notifyListeners();
  }

  void removeMember(String id) {
    _members.removeWhere((m) => m.id == id);
    for (final t in _tasks) {
      if (t.assignee == id) t.assignee = null;
    }
    notifyListeners();
  }

  void assignTask(String taskId, String? memberId) {
    final t = taskById(taskId);
    if (t == null) return;
    t.assignee = memberId;
    notifyListeners();
  }
}