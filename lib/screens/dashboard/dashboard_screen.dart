import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_state.dart';
import '../../core/user_session.dart';
import '../../l10n/app_localizations.dart';
import '../team/deadlines_screen.dart';
import '../profile/profile_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final l = AppLocalizations.of(context)!;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context, l),
            const SizedBox(height: 20),
            _progressCard(s, l),
            const SizedBox(height: 16),
            Row(
              children: [
                _StatCard(label: l.statProjects, value: '${s.projectCount}'),
                const SizedBox(width: 12),
                _StatCard(label: l.statTasks, value: '${s.taskCount}'),
                const SizedBox(width: 12),
                _StatCard(label: l.statDone, value: '${s.tasksDone}'),
              ],
            ),
            const SizedBox(height: 16),
            _lateCard(s, l),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l.upcomingDeadlines,
                    style: Theme.of(context).textTheme.titleMedium),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const DeadlinesScreen()),
                  ),
                  child: Text(
                    l.seeAll,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (s.upcomingProjects.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(l.noDeadlines,
                      style: const TextStyle(color: AppColors.textSoft)),
                ),
              )
            else
              ...s.upcomingProjects.map((p) {
                final days = _daysLeft(p.deadline);
                final urgent = days <= 2;
                final nbTasks = s.tasksOf(p.id).length;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _DeadlineTile(
                    title: p.name,
                    subtitle:
                        '${_dateLabel(p.deadline, days, l)} · ${l.tasksCount(nbTasks)}',
                    badge: urgent ? l.urgent : l.soon,
                    badgeColor: urgent ? AppColors.coral : AppColors.amber,
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  static int _daysLeft(DateTime d) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return DateTime(d.year, d.month, d.day).difference(today).inDays;
  }

  static String _dateLabel(DateTime d, int days, AppLocalizations l) {
    if (days < 0) return l.late;
    if (days == 0) return l.today;
    if (days == 1) return l.tomorrow;
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    return '$dd/$mm';
  }

  Widget _header(BuildContext context, AppLocalizations l) {
    return ValueListenableBuilder<int>(
      valueListenable: UserSession.changes,
      builder: (context, value, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                UserSession.firstName.isEmpty
                    ? l.hello
                    : l.helloName(UserSession.firstName),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 2),
              Text(l.yourActivity,
                  style: Theme.of(context).textTheme.headlineLarge),
            ],
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.gradientPrimary,
              ),
              child: Text(
                UserSession.initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _progressCard(AppState s, AppLocalizations l) {
    final percent = (s.globalProgress * 100).round();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          colors: [Color(0xFF6C5CFF), Color(0xFF3A2BD6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 84,
            height: 84,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 84,
                  height: 84,
                  child: CircularProgressIndicator(
                    value: s.globalProgress,
                    strokeWidth: 9,
                    strokeCap: StrokeCap.round,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    valueColor:
                        const AlwaysStoppedAnimation(AppColors.mint),
                  ),
                ),
                Text(
                  '$percent%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.globalProgress,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(l.projectsInProgress(s.projectsInProgress),
                    style: const TextStyle(
                        color: AppColors.mint, fontSize: 13)),
                const SizedBox(height: 2),
                Text(l.projectsDoneCount(s.projectsDone),
                    style: const TextStyle(
                        color: AppColors.mint, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _lateCard(AppState s, AppLocalizations l) {
    final late = s.tasksLate;
    final hasLate = late > 0;
    final color = hasLate ? AppColors.coral : AppColors.mint;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              hasLate ? Icons.priority_high_rounded : Icons.check_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasLate ? l.lateTasks(late) : l.noLateTasks,
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  hasLate ? l.reactQuickly : l.allOnTime,
                  style: const TextStyle(
                      color: AppColors.textSoft, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style:
                    const TextStyle(color: AppColors.textSoft, fontSize: 13)),
            const SizedBox(height: 4),
            Text(value,
                style: const TextStyle(
                  color: AppColors.navy,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                )),
          ],
        ),
      ),
    );
  }
}

class _DeadlineTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badge;
  final Color badgeColor;

  const _DeadlineTile({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      color: AppColors.navy,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    )),
                const SizedBox(height: 3),
                Text(subtitle,
                    style: const TextStyle(
                        color: AppColors.textSoft, fontSize: 13)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: badgeColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              badge,
              style: TextStyle(
                color: badgeColor,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}