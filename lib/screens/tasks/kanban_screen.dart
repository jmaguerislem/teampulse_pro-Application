import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/app_state.dart';
import '../../core/project_ui.dart';
import '../../l10n/app_localizations.dart';
import '../../models/models.dart';
import '../../widgets/priority_chip.dart';
import 'task_details_screen.dart';

class KanbanScreen extends StatelessWidget {
  const KanbanScreen({super.key});

  static const _columns = [
    TaskStatus.todo,
    TaskStatus.inProgress,
    TaskStatus.done,
  ];

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.kanbanBoard,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: _columns.map((status) {
          final tasks = s.tasks.where((t) => t.status == status).toList();
          return _Column(status: status, tasks: tasks);
        }).toList(),
      ),
    );
  }
}

class _Column extends StatelessWidget {
  final TaskStatus status;
  final List<Task> tasks;
  const _Column({required this.status, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return DragTarget<Task>(
      onWillAcceptWithDetails: (d) => d.data.status != status,
      onAcceptWithDetails: (d) =>
          context.read<AppState>().setTaskStatus(d.data.id, status),
      builder: (context, candidate, _) {
        final hovering = candidate.isNotEmpty;
        return Container(
          width: 240,
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: hovering
                ? AppColors.primary.withValues(alpha: 0.18)
                : AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    taskStatusLabel(status, l),
                    style: const TextStyle(
                      color: AppColors.navy,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${tasks.length}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: tasks.isEmpty
                    ? Center(
                        child: Text(
                          l.dropTaskHere,
                          style: const TextStyle(
                            color: AppColors.textSoft,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: tasks.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (_, i) => _KanbanCard(task: tasks[i]),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _KanbanCard extends StatelessWidget {
  final Task task;
  const _KanbanCard({required this.task});

  Widget _card({double opacity = 1}) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: 216,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(
                color: AppColors.navy,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              fmtDate(task.dueDate),
              style: TextStyle(
                color: task.isLate ? AppColors.coral : AppColors.textSoft,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            PriorityChip(priority: task.priority),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<Task>(
      data: task,
      feedback: Material(
        color: Colors.transparent,
        child: Transform.rotate(angle: 0.03, child: _card()),
      ),
      childWhenDragging: _card(opacity: 0.35),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TaskDetailsScreen(taskId: task.id)),
        ),
        child: _card(),
      ),
    );
  }
}
