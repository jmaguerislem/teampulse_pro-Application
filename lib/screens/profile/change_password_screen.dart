import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/auth_service.dart';
import '../../core/project_ui.dart';
import '../../core/user_session.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/primary_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _old = TextEditingController();
  final _new = TextEditingController();
  final _confirm = TextEditingController();
  bool _hide = true;
  String? _error;

  @override
  void dispose() {
    _old.dispose();
    _new.dispose();
    _confirm.dispose();
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

  InputDecoration _deco(String hint) => InputDecoration(
    hintText: hint,
    suffixIcon: IconButton(
      icon: Icon(
        _hide ? Icons.visibility_off : Icons.visibility,
        color: AppColors.textSoft,
      ),
      onPressed: () => setState(() => _hide = !_hide),
    ),
  );

  void _save() {
    final l = AppLocalizations.of(context)!;
    setState(() => _error = null);
    if (!_formKey.currentState!.validate()) return;

    final error = AuthService.changePassword(
      email: UserSession.email,
      oldPassword: _old.text,
      newPassword: _new.text,
    );
    if (error != null) {
      setState(() => _error = authErrorText(error, l));
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(l.passwordChanged)));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.passwordItem,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label(l.oldPasswordLabel),
              TextFormField(
                controller: _old,
                obscureText: _hide,
                decoration: _deco(l.oldPasswordHint),
                validator: (v) =>
                    (v == null || v.isEmpty) ? l.enterOldPassword : null,
              ),
              _label(l.newPasswordLabel),
              TextFormField(
                controller: _new,
                obscureText: _hide,
                decoration: _deco(l.passwordMinHint),
                validator: (v) =>
                    (v == null || v.length < 8) ? l.passwordMinError : null,
              ),
              _label(l.confirmPasswordLabel),
              TextFormField(
                controller: _confirm,
                obscureText: _hide,
                decoration: _deco(l.confirmPasswordHint),
                validator: (v) => v != _new.text ? l.passwordsDontMatch : null,
              ),
              if (_error != null) ...[
                const SizedBox(height: 16),
                Text(
                  _error!,
                  style: const TextStyle(
                    color: AppColors.coral,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
              const SizedBox(height: 28),
              PrimaryButton(label: l.changePasswordButton, onPressed: _save),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
