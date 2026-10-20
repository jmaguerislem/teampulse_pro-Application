import 'package:flutter/material.dart';

import '../models/models.dart';
import 'app_colors.dart';
import 'app_state.dart';
import '../l10n/app_localizations.dart';

String fmtDate(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

class StatusInfo {
  final String label;
  final Color color;
  const StatusInfo(this.label, this.color);
}

StatusInfo projectStatusInfo(AppState s, Project p, AppLocalizations l) {
  if (p.status == ProjectStatus.done) {
    return StatusInfo(l.statusDone, AppColors.mint);
  }
  if (s.isProjectLate(p)) {
    return StatusInfo(l.late, AppColors.coral);
  }
  if (p.status == ProjectStatus.onHold) {
    return StatusInfo(l.filterOnHold, AppColors.amber);
  }
  return StatusInfo(l.filterInProgress, AppColors.primary);
}

const projectIconColors = [
  AppColors.primary,
  AppColors.mint,
  AppColors.amber,
  AppColors.coral,
];
StatusInfo priorityInfo(TaskPriority p) {
  switch (p) {
    case TaskPriority.high:
      return const StatusInfo('Haute', AppColors.coral);
    case TaskPriority.medium:
      return const StatusInfo('Moyenne', AppColors.amber);
    case TaskPriority.low:
      return const StatusInfo('Basse', AppColors.mint);
  }
}

String taskStatusLabel(TaskStatus s) {
  switch (s) {
    case TaskStatus.todo:
      return 'À faire';
    case TaskStatus.inProgress:
      return 'En cours';
    case TaskStatus.done:
      return 'Terminée';
  }
}
