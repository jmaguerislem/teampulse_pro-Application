import 'package:flutter/material.dart';

class SettingsState extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  bool _notifOverdue = true;
  bool _notifReminder = true;
  bool _notifAssignment = true;
  String _language = 'Français';

  ThemeMode get themeMode => _themeMode;
  bool get notifOverdue => _notifOverdue;
  bool get notifReminder => _notifReminder;
  bool get notifAssignment => _notifAssignment;
  String get language => _language;
  Locale get locale =>
      _language == 'English' ? const Locale('en') : const Locale('fr');

  String get themeLabel {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Clair';
      case ThemeMode.dark:
        return 'Sombre';
      case ThemeMode.system:
        return 'Système';
    }
  }

  String get notifSummary {
    final active = [
      _notifOverdue,
      _notifReminder,
      _notifAssignment,
    ].where((v) => v).length;
    if (active == 3) return 'Toutes les alertes';
    if (active == 0) return 'Aucune alerte';
    if (_notifOverdue && active == 1) return 'Alertes de retard';
    return '$active sur 3 actives';
  }

  void setThemeMode(ThemeMode m) {
    _themeMode = m;
    notifyListeners();
  }

  void setNotifOverdue(bool v) {
    _notifOverdue = v;
    notifyListeners();
  }

  void setNotifReminder(bool v) {
    _notifReminder = v;
    notifyListeners();
  }

  void setNotifAssignment(bool v) {
    _notifAssignment = v;
    notifyListeners();
  }

  void setLanguage(String l) {
    _language = l;
    notifyListeners();
  }
}
