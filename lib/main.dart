import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_state.dart';
import 'core/app_theme.dart';
import 'core/settings_state.dart';
import 'l10n/app_localizations.dart';
import 'screens/auth/welcome_screen.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppState()),
      ChangeNotifierProvider(create: (_) => SettingsState()),
    ],
    child: const TeamPulseApp(),
  ),
);

class TeamPulseApp extends StatelessWidget {
  const TeamPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsState>();
    return MaterialApp(
      title: 'TeamPulse Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: settings.themeMode,
      locale: settings.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const WelcomeScreen(),
    );
  }
}
