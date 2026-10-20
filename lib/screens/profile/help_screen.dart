import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  static const _faq = [
    (
      'Comment créer un projet ?',
      'Ouvrez l\'onglet Projets puis touchez le bouton + en bas à droite.',
    ),
    (
      'Comment affecter une tâche ?',
      'Ouvrez la tâche, touchez « Assigné à » et choisissez un membre de l\'équipe.',
    ),
    (
      'Comment déplacer une tâche dans le Kanban ?',
      'Maintenez votre doigt sur la carte, puis glissez-la vers une autre colonne.',
    ),
    (
      'Que signifie « en retard » ?',
      'Une tâche est en retard quand sa date limite est passée et qu\'elle n\'est pas terminée.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: Text(
          'Aide et support',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          ..._faq.map((f) {
            final (q, a) = f;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 18),
                  childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  title: Text(
                    q,
                    style: const TextStyle(
                      color: AppColors.navy,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  children: [
                    Text(
                      a,
                      style: const TextStyle(
                        color: AppColors.textSoft,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Besoin d\'aide ? Écrivez-nous à support@teampulse.example',
              style: TextStyle(color: AppColors.navy, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
