import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../core/app_state.dart';
import '../l10n/app_localizations.dart';
import 'notifications_screen.dart';
import 'profile/profile_screen.dart';
import 'progress_screen.dart';
import 'reports_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  Widget _tile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget page,
    int badge = 0,
  }) {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.navy,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textSoft,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            if (badge > 0)
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.coral,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$badge',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            const Icon(Icons.chevron_right, color: AppColors.textSoft),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unread = context.watch<AppState>().unreadCount;
    final l = AppLocalizations.of(context)!;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
        children: [
          Text(l.moreTitle, style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 20),
          _tile(
            context,
            icon: Icons.notifications_none_rounded,
            title: l.notificationsTitle,
            subtitle: l.notificationsSubtitle,
            page: const NotificationsScreen(),
            badge: unread,
          ),
          const SizedBox(height: 12),
          _tile(
            context,
            icon: Icons.show_chart_rounded,
            title: l.statsTile,
            subtitle: l.statsTileSubtitle,
            page: const ProgressScreen(),
          ),
          const SizedBox(height: 12),
          _tile(
            context,
            icon: Icons.description_outlined,
            title: l.reportsTile,
            subtitle: l.reportsTileSubtitle,
            page: const ReportsScreen(),
          ),
          const SizedBox(height: 12),
          _tile(
            context,
            icon: Icons.person_outline_rounded,
            title: l.profileTile,
            subtitle: l.profileTileSubtitle,
            page: const ProfileScreen(),
          ),
        ],
      ),
    );
  }
}
