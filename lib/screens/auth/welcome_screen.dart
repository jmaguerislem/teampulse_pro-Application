import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../l10n/app_localizations.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Widget _whiteButton(String label, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.navy,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3D3A8C), Color(0xFF1A1A4B), Color(0xFF14143A)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Spacer(flex: 3),
                const Icon(
                  Icons.monitor_heart_outlined,
                  size: 80,
                  color: AppColors.mint,
                ),
                const SizedBox(height: 24),
                const Text(
                  'TeamPulse Pro',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l.welcomeTagline,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                const Spacer(flex: 4),
                _whiteButton(l.signIn, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                }),
                const SizedBox(height: 14),
                _whiteButton(l.createAccount, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignupScreen()),
                  );
                }),
                const SizedBox(height: 18),
                Text(
                  l.continueWithoutAccount,
                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
