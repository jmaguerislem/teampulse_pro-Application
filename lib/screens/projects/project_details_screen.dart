import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/app_state.dart';
import '../../core/project_ui.dart';
import '../../l10n/app_localizations.dart';
import '../../models/models.dart';
import '../../widgets/member_avatar.dart';
import '../tasks/create_task_screen.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final String projectId;
  const ProjectDetailsScreen({super.key, required this.projectId});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  int _tab = 0;

  Future<void> _confirmDelete(Project p) async {
    final l = AppLocalizations.of(context)!;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.deleteProjectTitle),
        content: Text(l.deleteProjectBody(p.name)),
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
    if (ok == true && mounted) {
      context.read<AppState>().removeProject(p.id);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final l = AppLocalizations.of(context)!;
    final p = s.projectById(widget.projectId);

    if (p == null) return const Scaffold(body: SizedBox());

    final tabs = [l.tabDescription, l.tabTasks, l.tabMembers];
    final info = projectStatusInfo(s, p, l);
    final percent = (s.projectProgress(p.id) * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.projectDetails,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (_) => _confirmDelete(p),
            itemBuilder: (_) => [
              PopupMenuItem(value: 'delete', child: Text(l.delete)),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.folder_outlined,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.name,
                            style: const TextStyle(
                              color: AppColors.navy,
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: info.color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              info.label,
                              style: TextStyle(
                                color: info.color,
                                fontWeight: FontWeight.w700,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '$percent%',
                      style: const TextStyle(
                        color: AppColors.navy,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: s.projectProgress(p.id),
                    minHeight: 7,
                    backgroundColor: AppColors.background,
                    valueColor: AlwaysStoppedAnimation(info.color),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${fmtDate(p.startDate)}  →  ${fmtDate(p.deadline)}',
                  style: const TextStyle(
                    color: AppColors.textSoft,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: List.generate(tabs.length, (i) {
              final selected = i == _tab;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => setState(() => _tab = i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.navy : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tabs[i],
                      style: TextStyle(
                        color: selected ? Colors.white : AppColors.navy,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          if (_tab == 0)
            Text(
              p.description.isEmpty ? l.noDescription : p.description,
              style: const TextStyle(
                color: AppColors.textSoft,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          if (_tab == 1) _tasksTab(s, p, l),
          if (_tab == 2) _membersTab(s, p, l),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.tasksDoneLabel(s.tasksDoneOf(p.id)),
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l.lateCountLabel(s.tasksLateOf(p.id)),
                  style: const TextStyle(
                    color: AppColors.textSoft,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _membersTab(AppState s, Project p, AppLocalizations l) {
    final ids = s
        .tasksOf(p.id)
        .map((t) => t.assignee)
        .whereType<String>()
        .toSet();
    final members = s.members.where((m) => ids.contains(m.id)).toList();

    if (members.isEmpty) {
      return Text(
        l.noMemberAssigned,
        style: const TextStyle(color: AppColors.textSoft),
      );
    }
    return Column(
      children: members
          .map(
            (m) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  MemberAvatar(member: m, size: 36),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m.name,
                          style: const TextStyle(
                            color: AppColors.navy,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          m.role,
                          style: const TextStyle(
                            color: AppColors.textSoft,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _tasksTab(AppState s, Project p, AppLocalizations l) {
    final tasks = s.tasksOf(p.id);
    final addButton = Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CreateTaskScreen(projectId: p.id)),
        ),
        icon: const Icon(Icons.add, size: 18),
        label: Text(l.addTask),
      ),
    );

    if (tasks.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addButton,
          Text(
            l.noTaskForProject,
            style: const TextStyle(color: AppColors.textSoft),
          ),
        ],
      );
    }

    return Column(
      children: [
        addButton,
        ...tasks.map((t) {
          final done = t.status == TaskStatus.done;
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Material(
              color: Colors.transparent,
              child: CheckboxListTile(
                value: done,
                activeColor: AppColors.mint,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  t.title,
                  style: TextStyle(
                    color: AppColors.navy,
                    fontWeight: FontWeight.w600,
                    decoration: done ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text(
                  t.isLate ? l.lateOn(fmtDate(t.dueDate)) : fmtDate(t.dueDate),
                  style: TextStyle(
                    color: t.isLate ? AppColors.coral : AppColors.textSoft,
                    fontSize: 12,
                  ),
                ),
                onChanged: (v) => context.read<AppState>().setTaskStatus(
                  t.id,
                  v == true ? TaskStatus.done : TaskStatus.todo,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
