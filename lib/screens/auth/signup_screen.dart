import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/auth_service.dart';
import '../../core/user_session.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/primary_button.dart';
import 'login_screen.dart';
import '../dashboard/main_shell.dart';
import '../../core/project_ui.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
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
    setState(() => _error = null);
    if (!_formKey.currentState!.validate()) return;

    final error = AuthService.register(
      fullName: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (error != null) {
      setState(
        () => _error = authErrorText(error, AppLocalizations.of(context)!),
      );
      return;
    }

    UserSession.fullName = _nameController.text.trim();
    UserSession.email = _emailController.text.trim().toLowerCase();
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
                l.signupTitle,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                l.signupSubtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              _label(l.fullNameLabel),
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(hintText: l.fullNameHint),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? l.enterFullName : null,
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
                  hintText: l.passwordMinHint,
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
                    (v == null || v.length < 8) ? l.passwordMinError : null,
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
              PrimaryButton(label: l.signUp, onPressed: _submit),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  ),
                  child: Text.rich(
                    TextSpan(
                      text: l.alreadyAccount,
                      style: const TextStyle(color: AppColors.textSoft),
                      children: [
                        TextSpan(
                          text: l.signIn,
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
