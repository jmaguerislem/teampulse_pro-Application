import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/settings_state.dart';
import '../../l10n/app_localizations.dart';

class NotificationPrefsScreen extends StatelessWidget {
  const NotificationPrefsScreen({super.key});

  Widget _switch(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        activeThumbColor: AppColors.primary,
        value: value,
        onChanged: onChanged,
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.navy,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: AppColors.textSoft, fontSize: 13),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SettingsState>();
    final read = context.read<SettingsState>();
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.notifPrefsItem,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          _switch(
            l.prefOverdueTitle,
            l.prefOverdueSub,
            s.notifOverdue,
            read.setNotifOverdue,
          ),
          _switch(
            l.prefReminderTitle,
            l.prefReminderSub,
            s.notifReminder,
            read.setNotifReminder,
          ),
          _switch(
            l.prefAssignTitle,
            l.prefAssignSub,
            s.notifAssignment,
            read.setNotifAssignment,
          ),
        ],
      ),
    );
  }
}
