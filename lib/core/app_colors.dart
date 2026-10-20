import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF5B4CFF); // bleu pulse
  static const primaryLight = Color(0xFF7C6CFF);
  static const mint = Color(0xFF2ED8A7); // avancement
  static const coral = Color(0xFFFF5C7A); // retards
  static const amber = Color(0xFFFFB84D); // moyenne / bientôt
  static const navy = Color(0xFF1A1A4B); // titres
  static const textSoft = Color(0xFF7A7A9D); // textes secondaires
  static const background = Color(0xFFF4F2FF); // fond des écrans
  static const card = Colors.white;

  static const gradientPrimary = LinearGradient(
    colors: [primaryLight, primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
