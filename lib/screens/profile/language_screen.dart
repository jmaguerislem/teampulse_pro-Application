import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/settings_state.dart';
import '../../l10n/app_localizations.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  static const _languages = [
    ('Français', true),
    ('English', true),
    ('العربية', false),
  ];

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SettingsState>();
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.languageItem,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: _languages.map((entry) {
          final (name, available) = entry;
          final selected = s.language == name;
          return GestureDetector(
            onTap: () {
              if (!available) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(l.languageComingSoon)));
                return;
              }
              context.read<SettingsState>().setLanguage(name);
            },
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
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        color: available ? AppColors.navy : AppColors.textSoft,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  if (!available)
                    Text(
                      l.comingSoonShort,
                      style: const TextStyle(
                        color: AppColors.textSoft,
                        fontSize: 12,
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
