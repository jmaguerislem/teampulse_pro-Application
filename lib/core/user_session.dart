import 'package:flutter/foundation.dart';

class UserSession {
  static final ValueNotifier<int> changes = ValueNotifier<int>(0);

  static String _fullName = '';
  static String _email = '';

  static String get fullName => _fullName;
  static set fullName(String v) {
    _fullName = v;
    changes.value++;
  }

  static String get email => _email;
  static set email(String v) {
    _email = v;
    changes.value++;
  }

  static String get firstName {
    final parts = _fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    return parts.isEmpty ? '' : parts.first;
  }

  static String get initials {
    final parts = _fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  static void clear() {
    _fullName = '';
    _email = '';
    changes.value++;
  }
}
