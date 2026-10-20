import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/auth_service.dart';
import '../../core/user_session.dart';
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
    setState(() => _error = null);
    if (!_formKey.currentState!.validate()) return;

    final error = AuthService.changePassword(
      email: UserSession.email,
      oldPassword: _old.text,
      newPassword: _new.text,
    );
    if (error != null) {
      setState(() => _error = error);
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Mot de passe modifié.')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: Text(
          'Mot de passe',
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
              _label('Ancien mot de passe'),
              TextFormField(
                controller: _old,
                obscureText: _hide,
                decoration: _deco('Votre mot de passe actuel'),
                validator: (v) => (v == null || v.isEmpty)
                    ? 'Entrez votre ancien mot de passe.'
                    : null,
              ),
              _label('Nouveau mot de passe'),
              TextFormField(
                controller: _new,
                obscureText: _hide,
                decoration: _deco('Minimum 8 caractères'),
                validator: (v) => (v == null || v.length < 8)
                    ? 'Minimum 8 caractères.'
                    : null,
              ),
              _label('Confirmer le nouveau mot de passe'),
              TextFormField(
                controller: _confirm,
                obscureText: _hide,
                decoration: _deco('Répétez le mot de passe'),
                validator: (v) => v != _new.text
                    ? 'Les mots de passe ne correspondent pas.'
                    : null,
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
              PrimaryButton(label: 'Modifier', onPressed: _save),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
