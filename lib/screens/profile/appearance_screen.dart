import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/settings_state.dart';
import '../../l10n/app_localizations.dart';

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SettingsState>();
    final l = AppLocalizations.of(context)!;
    final modes = [
      (ThemeMode.light, l.themeLight, Icons.light_mode_outlined),
      (ThemeMode.dark, l.themeDark, Icons.dark_mode_outlined),
      (ThemeMode.system, l.themeSystem, Icons.phone_android),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.appearanceItem,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: modes.map((m) {
          final (mode, label, icon) = m;
          final selected = s.themeMode == mode;
          return GestureDetector(
            onTap: () => context.read<SettingsState>().setThemeMode(mode),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected ? AppColors.primary : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(icon, color: AppColors.primary),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: AppColors.navy,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  if (selected)
                    const Icon(Icons.check, color: AppColors.primary),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
