import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../core/app_state.dart';
import '../core/project_ui.dart';
import '../l10n/app_localizations.dart';
import '../models/models.dart';
import 'create_project_screen.dart';
import 'project_details_screen.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  int _filter = 0;

  List<Project> _apply(List<Project> all) {
    switch (_filter) {
      case 1:
        return all.where((p) => p.status == ProjectStatus.inProgress).toList();
      case 2:
        return all.where((p) => p.status == ProjectStatus.done).toList();
      case 3:
        return all.where((p) => p.status == ProjectStatus.onHold).toList();
      default:
        return all;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final l = AppLocalizations.of(context)!;
    final filters = [
      l.filterAll,
      l.filterInProgress,
      l.filterDone,
      l.filterOnHold,
    ];
    final list = _apply(s.projects);

    return SafeArea(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Text(
                  l.myProjects,
                  style: Theme.of(context).textTheme.headlineLarge,
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
                          l.noProjectHere,
                          style: const TextStyle(color: AppColors.textSoft),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 4, 20, 140),
                        itemCount: list.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (_, i) =>
                            _ProjectCard(project: list[i], colorIndex: i),
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
                MaterialPageRoute(builder: (_) => const CreateProjectScreen()),
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

class _ProjectCard extends StatelessWidget {
  final Project project;
  final int colorIndex;
  const _ProjectCard({required this.project, required this.colorIndex});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final l = AppLocalizations.of(context)!;
    final info = projectStatusInfo(s, project, l);
    final total = s.tasksOf(project.id).length;
    final done = s.tasksDoneOf(project.id);
    final iconColor = projectIconColors[colorIndex % projectIconColors.length];

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProjectDetailsScreen(projectId: project.id),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(Icons.folder_outlined, color: iconColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.navy,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l.tasksProgress(done, total),
                        style: const TextStyle(
                          color: AppColors.textSoft,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
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
                ),
              ],
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: s.projectProgress(project.id),
                minHeight: 7,
                backgroundColor: AppColors.background,
                valueColor: AlwaysStoppedAnimation(info.color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
