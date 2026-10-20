import 'package:flutter/material.dart';
import '../core/project_ui.dart';
import '../l10n/app_localizations.dart';
import '../models/models.dart';

class PriorityChip extends StatelessWidget {
  final TaskPriority priority;
  const PriorityChip({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    final info = priorityInfo(priority, AppLocalizations.of(context)!);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: info.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        info.label,
        style: TextStyle(
          color: info.color,
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
      ),
    );
  }
}