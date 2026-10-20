import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/auth_service.dart';
import '../core/user_session.dart';
import '../l10n/app_localizations.dart';
import '../widgets/primary_button.dart';
import 'main_shell.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8, top: 18),
    child: Text(
      text,
      style: const TextStyle(
        color: AppColors.navy,
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
    ),
  );

  void _submit() {
    final l = AppLocalizations.of(context)!;
    setState(() => _error = null);
    if (!_formKey.currentState!.validate()) return;

    final account = AuthService.login(
      _emailController.text,
      _passwordController.text,
    );

    if (account == null) {
      setState(() => _error = l.wrongCredentials);
      return;
    }

    UserSession.fullName = account.fullName;
    UserSession.email = account.email;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const MainShell()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.loginTitle,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                l.loginSubtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              _label(l.emailLabel),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: l.emailHint),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return l.enterEmail;
                  if (!AuthService.isValidEmail(v)) return l.invalidEmail;
                  return null;
                },
              ),
              _label(l.passwordLabel),
              TextFormField(
                controller: _passwordController,
                obscureText: _hidePassword,
                decoration: InputDecoration(
                  hintText: l.yourPasswordHint,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _hidePassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textSoft,
                    ),
                    onPressed: () =>
                        setState(() => _hidePassword = !_hidePassword),
                  ),
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? l.enterPassword : null,
              ),
              if (_error != null) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.coral.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.coral.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Text(
                    _error!,
                    style: const TextStyle(
                      color: AppColors.coral,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 28),
              PrimaryButton(label: l.signIn, onPressed: _submit),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const SignupScreen()),
                  ),
                  child: Text.rich(
                    TextSpan(
                      text: l.noAccountYet,
                      style: const TextStyle(color: AppColors.textSoft),
                      children: [
                        TextSpan(
                          text: l.createAccount,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
