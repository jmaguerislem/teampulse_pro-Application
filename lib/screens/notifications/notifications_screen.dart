import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/app_state.dart';
import '../../core/settings_state.dart';
import '../../l10n/app_localizations.dart';
import '../../models/notification_item.dart';
import '../tasks/task_details_screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _onlyUnread = false;

  Widget _chip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.navy : Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.navy,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  (IconData, Color) _style(NotifType t) {
    switch (t) {
      case NotifType.overdue:
        return (Icons.priority_high_rounded, AppColors.coral);
      case NotifType.reminder:
        return (Icons.alarm, AppColors.amber);
      case NotifType.assignment:
        return (Icons.add, AppColors.primary);
    }
  }

  String _title(NotifType t, AppLocalizations l) {
    switch (t) {
      case NotifType.overdue:
        return l.notifOverdueTitle;
      case NotifType.reminder:
        return l.notifReminderTitle;
      case NotifType.assignment:
        return l.notifAssignTitle;
    }
  }

  String _message(AppNotification n, AppLocalizations l) {
    switch (n.type) {
      case NotifType.overdue:
        return l.notifOverdueMsg(n.taskTitle, n.days);
      case NotifType.reminder:
        if (n.days == 0) return l.notifReminderToday(n.taskTitle);
        if (n.days == 1) return l.notifReminderTomorrow(n.taskTitle);
        return l.notifReminderTwoDays(n.taskTitle);
      case NotifType.assignment:
        return l.notifAssignMsg(n.taskTitle, n.memberName ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final l = AppLocalizations.of(context)!;
    final prefs = context.watch<SettingsState>();
    final all = s.notifications.where((n) {
      switch (n.type) {
        case NotifType.overdue:
          return prefs.notifOverdue;
        case NotifType.reminder:
          return prefs.notifReminder;
        case NotifType.assignment:
          return prefs.notifAssignment;
      }
    }).toList();
    final unread = all.where((n) => !s.isRead(n.id)).length;
    final list = _onlyUnread ? all.where((n) => !s.isRead(n.id)).toList() : all;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.notificationsTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          if (unread > 0)
            TextButton(
              onPressed: () => context.read<AppState>().markAllRead(),
              child: Text(l.markAllRead),
            ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
            child: Row(
              children: [
                _chip(
                  l.filterAll,
                  !_onlyUnread,
                  () => setState(() => _onlyUnread = false),
                ),
                const SizedBox(width: 8),
                _chip(
                  l.filterUnread(unread),
                  _onlyUnread,
                  () => setState(() => _onlyUnread = true),
                ),
              ],
            ),
          ),
          Expanded(
            child: list.isEmpty
                ? Center(
                    child: Text(
                      l.noNotifications,
                      style: const TextStyle(color: AppColors.textSoft),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
                    itemCount: list.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      final n = list[i];
                      final read = s.isRead(n.id);
                      final (icon, color) = _style(n.type);
                      return GestureDetector(
                        onTap: () {
                          context.read<AppState>().markRead(n.id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  TaskDetailsScreen(taskId: n.taskId),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 46,
                                height: 46,
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(icon, color: color),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _title(n.type, l),
                                      style: TextStyle(
                                        color: AppColors.navy,
                                        fontWeight: read
                                            ? FontWeight.w600
                                            : FontWeight.w800,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      _message(n, l),
                                      style: const TextStyle(
                                        color: AppColors.textSoft,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (!read)
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
