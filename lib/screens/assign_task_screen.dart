import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../core/app_state.dart';
import '../widgets/member_avatar.dart';
import '../widgets/primary_button.dart';

class AssignTaskScreen extends StatefulWidget {
  final String taskId;
  const AssignTaskScreen({super.key, required this.taskId});

  @override
  State<AssignTaskScreen> createState() => _AssignTaskScreenState();
}

class _AssignTaskScreenState extends State<AssignTaskScreen> {
  String? _selected;

  @override
  void initState() {
    super.initState();
    _selected = context.read<AppState>().taskById(widget.taskId)?.assignee;
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final task = s.taskById(widget.taskId);
    if (task == null) return const Scaffold(body: SizedBox());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: Text(
          'Affecter une tâche',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tâche',
              style: TextStyle(
                color: AppColors.navy,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                task.title,
                style: const TextStyle(color: AppColors.textSoft),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Membre',
              style: TextStyle(
                color: AppColors.navy,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: s.members.isEmpty
                  ? const Center(
                      child: Text(
                        'Ajoutez d\'abord des membres (onglet Équipe).',
                        style: TextStyle(color: AppColors.textSoft),
                      ),
                    )
                  : ListView.separated(
                      itemCount: s.members.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
                      itemBuilder: (_, i) {
                        final m = s.members[i];
                        final selected = _selected == m.id;
                        return GestureDetector(
                          onTap: () => setState(() => _selected = m.id),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.primary.withValues(alpha: 0.08)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: selected
                                    ? AppColors.primary
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                MemberAvatar(member: m, size: 38),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                if (selected)
                                  const Icon(
                                    Icons.check,
                                    color: AppColors.primary,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              label: 'Affecter',
              onPressed: () {
                context.read<AppState>().assignTask(widget.taskId, _selected);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
