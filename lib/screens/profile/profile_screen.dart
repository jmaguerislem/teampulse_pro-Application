import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/settings_state.dart';
import '../../core/user_session.dart';
import '../../l10n/app_localizations.dart';
import '../auth/welcome_screen.dart';
import 'appearance_screen.dart';
import 'change_password_screen.dart';
import 'edit_profile_screen.dart';
import 'help_screen.dart';
import 'language_screen.dart';
import 'notification_prefs_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _open(Widget page) async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => page));
    if (mounted) setState(() {});
  }

  Future<void> _logout() async {
    final l = AppLocalizations.of(context)!;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.logoutTitle),
        content: Text(l.logoutBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              l.logoutConfirm,
              style: const TextStyle(color: AppColors.coral),
            ),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    UserSession.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      (route) => false,
    );
  }

  Widget _item(String title, {String? value, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.navy,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
            if (value != null)
              Flexible(
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textSoft,
                    fontSize: 13,
                  ),
                ),
              ),
            const SizedBox(width: 4),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textSoft,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsState>();
    final l = AppLocalizations.of(context)!;
    final name = UserSession.fullName.isEmpty
        ? l.defaultUserName
        : UserSession.fullName;
    final email = UserSession.email.isEmpty ? l.noEmail : UserSession.email;

    final notifSummary = settings.activeNotifCount == 3
        ? l.notifSummaryAll
        : settings.activeNotifCount == 0
        ? l.notifSummaryNone
        : (settings.activeNotifCount == 1 && settings.notifOverdue)
        ? l.notifSummaryOverdue
        : l.notifSummaryCount(settings.activeNotifCount);
    final themeLabel = settings.themeMode == ThemeMode.light
        ? l.themeLight
        : settings.themeMode == ThemeMode.dark
        ? l.themeDark
        : l.themeSystem;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.profileTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.gradientPrimary,
                  ),
                  child: Text(
                    UserSession.initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: AppColors.navy,
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        email,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textSoft,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          l.projectLead,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _item(l.personalInfo, onTap: () => _open(const EditProfileScreen())),
          _item(
            l.passwordItem,
            onTap: () => _open(const ChangePasswordScreen()),
          ),
          _item(
            l.notifPrefsItem,
            value: notifSummary,
            onTap: () => _open(const NotificationPrefsScreen()),
          ),
          _item(
            l.languageItem,
            value: settings.language,
            onTap: () => _open(const LanguageScreen()),
          ),
          _item(
            l.appearanceItem,
            value: themeLabel,
            onTap: () => _open(const AppearanceScreen()),
          ),
          _item(l.helpItem, onTap: () => _open(const HelpScreen())),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: _logout,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  l.logout,
                  style: const TextStyle(
                    color: AppColors.coral,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
