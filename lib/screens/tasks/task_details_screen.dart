import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/app_state.dart';
import '../../core/project_ui.dart';
import '../../l10n/app_localizations.dart';
import '../../models/models.dart';
import '../../widgets/priority_chip.dart';
import 'assign_task_screen.dart';

class TaskDetailsScreen extends StatelessWidget {
  final String taskId;
  const TaskDetailsScreen({super.key, required this.taskId});

  Future<void> _confirmDelete(BuildContext context, Task t) async {
    final l = AppLocalizations.of(context)!;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.deleteTaskTitle),
        content: Text(l.deleteTaskBody(t.title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              l.delete,
              style: const TextStyle(color: AppColors.coral),
            ),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      context.read<AppState>().removeTask(t.id);
      Navigator.pop(context);
    }
  }

  Widget _row(String label, Widget value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.textSoft, fontSize: 14),
          ),
          value,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final l = AppLocalizations.of(context)!;
    final t = s.taskById(taskId);
    if (t == null) return const Scaffold(body: SizedBox());

    final project = s.projectById(t.projectId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.taskDetail,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            tooltip: l.delete,
            icon: const Icon(Icons.delete_outline, color: AppColors.coral),
            onPressed: () => _confirmDelete(context, t),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  t.title,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              PriorityChip(priority: t.priority),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l.projectNameLine(project?.name ?? l.deletedProject),
            style: const TextStyle(color: AppColors.textSoft, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Text(
            t.description.isEmpty ? l.noDescription : t.description,
            style: const TextStyle(
              color: AppColors.textSoft,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          _row(
            l.deadline,
            Text(
              fmtDate(t.dueDate),
              style: TextStyle(
                color: t.isLate ? AppColors.coral : AppColors.navy,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          _row(
            l.status,
            DropdownButton<TaskStatus>(
              value: t.status,
              underline: const SizedBox(),
              style: const TextStyle(
                color: AppColors.navy,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
              items: TaskStatus.values
                  .map(
                    (st) => DropdownMenuItem(
                      value: st,
                      child: Text(taskStatusLabel(st, l)),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                if (v != null) {
                  context.read<AppState>().setTaskStatus(t.id, v);
                }
              },
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AssignTaskScreen(taskId: t.id)),
            ),
            child: _row(
              l.assignedTo,
              Row(
                children: [
                  Text(
                    s.memberById(t.assignee ?? '')?.name ?? l.unassigned,
                    style: const TextStyle(
                      color: AppColors.navy,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.chevron_right,
                    color: AppColors.textSoft,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
