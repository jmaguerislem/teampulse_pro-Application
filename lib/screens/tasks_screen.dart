import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../core/app_state.dart';
import '../core/project_ui.dart';
import '../l10n/app_localizations.dart';
import '../models/models.dart';
import '../widgets/priority_chip.dart';
import 'create_task_screen.dart';
import 'kanban_screen.dart';
import 'task_details_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  int _filter = 0;

  List<Task> _apply(List<Task> all) {
    switch (_filter) {
      case 1:
        return all.where((t) => t.status == TaskStatus.todo).toList();
      case 2:
        return all.where((t) => t.status == TaskStatus.inProgress).toList();
      case 3:
        return all.where((t) => t.status == TaskStatus.done).toList();
      default:
        return all;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final l = AppLocalizations.of(context)!;
    final filters = [
      l.filterAllFem,
      l.taskTodo,
      l.filterInProgress,
      l.taskStatusDone,
    ];
    final list = List<Task>.of(_apply(s.tasks))
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));

    return SafeArea(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l.navTasks,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    IconButton(
                      tooltip: l.kanbanBoard,
                      icon: const Icon(
                        Icons.view_kanban_outlined,
                        color: AppColors.primary,
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const KanbanScreen()),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 44,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (_, i) {
                    final selected = i == _filter;
                    return GestureDetector(
                      onTap: () => setState(() => _filter = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: selected ? AppColors.navy : Colors.white,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Text(
                          filters[i],
                          style: TextStyle(
                            color: selected ? Colors.white : AppColors.navy,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: list.isEmpty
                    ? Center(
                        child: Text(
                          l.noTaskHere,
                          style: const TextStyle(color: AppColors.textSoft),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 4, 20, 140),
                        itemCount: list.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (_, i) => _TaskCard(task: list[i]),
                      ),
              ),
            ],
          ),
          Positioned(
            right: 20,
            bottom: 110,
            child: GestureDetector(
              onTap: () {
                if (s.projects.isEmpty) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(l.createProjectFirst)));
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateTaskScreen()),
                );
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.gradientPrimary,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final Task task;
  const _TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final l = AppLocalizations.of(context)!;
    final project = s.projectById(task.projectId);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => TaskDetailsScreen(taskId: task.id)),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.navy,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      decoration: task.status == TaskStatus.done
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
                PriorityChip(priority: task.priority),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              l.projectDateLine(
                project?.name ?? l.deletedProject,
                fmtDate(task.dueDate),
              ),
              style: const TextStyle(color: AppColors.textSoft, fontSize: 13),
            ),
            if (task.isLate) ...[
              const SizedBox(height: 6),
              Text(
                l.late,
                style: const TextStyle(
                  color: AppColors.coral,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
