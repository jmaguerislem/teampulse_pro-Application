import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/settings_state.dart';

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  static const _modes = [
    (ThemeMode.light, 'Clair', Icons.light_mode_outlined),
    (ThemeMode.dark, 'Sombre', Icons.dark_mode_outlined),
    (ThemeMode.system, 'Système', Icons.phone_android),
  ];

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SettingsState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: Text('Apparence', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: _modes.map((m) {
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
