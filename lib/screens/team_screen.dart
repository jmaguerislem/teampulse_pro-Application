import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../core/app_state.dart';
import '../models/models.dart';
import '../widgets/member_avatar.dart';
import 'add_member_screen.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  Future<void> _confirmDelete(BuildContext context, Member m) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Retirer ce membre ?'),
        content: Text(
          '« ${m.name} » sera retiré. Ses tâches redeviendront non assignées.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Retirer',
              style: TextStyle(color: AppColors.coral),
            ),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      context.read<AppState>().removeMember(m.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final members = s.members;

    return SafeArea(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Text(
                  'Équipe',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Expanded(
                child: members.isEmpty
                    ? const Center(
                        child: Text(
                          'Aucun membre pour le moment',
                          style: TextStyle(color: AppColors.textSoft),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 4, 20, 140),
                        itemCount: members.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (_, i) {
                          final m = members[i];
                          final n = s.tasksOfMember(m.id);
                          return Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Row(
                              children: [
                                MemberAvatar(member: m),
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
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${m.role} · $n tâche${n > 1 ? 's' : ''}',
                                        style: const TextStyle(
                                          color: AppColors.textSoft,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (m.isLead)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.12,
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: const Text(
                                      'Cheffe de projet',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10,
                                      ),
                                    ),
                                  )
                                else
                                  IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      color: AppColors.textSoft,
                                      size: 20,
                                    ),
                                    onPressed: () => _confirmDelete(context, m),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          Positioned(
            right: 20,
            bottom: 110,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddMemberScreen()),
              ),
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
