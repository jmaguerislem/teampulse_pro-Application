import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/auth_service.dart';
import '../../core/user_session.dart';
import '../../widgets/primary_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _email;
  String? _error;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: UserSession.fullName);
    _email = TextEditingController(text: UserSession.email);
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
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

  void _save() {
    setState(() => _error = null);
    if (!_formKey.currentState!.validate()) return;

    final error = AuthService.updateProfile(
      currentEmail: UserSession.email,
      newName: _name.text,
      newEmail: _email.text,
    );
    if (error != null) {
      setState(() => _error = error);
      return;
    }

    UserSession.fullName = _name.text.trim();
    UserSession.email = _email.text.trim().toLowerCase();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Profil mis à jour.')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: Text(
          'Informations personnelles',
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
              _label('Nom complet'),
              TextFormField(
                controller: _name,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(hintText: 'Ex : Aya Jguirim'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Entrez votre nom complet.'
                    : null,
              ),
              _label('Adresse e-mail'),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'exemple@domaine.com',
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Entrez votre e-mail.';
                  }
                  if (!AuthService.isValidEmail(v)) {
                    return 'Format d\'e-mail invalide.';
                  }
                  return null;
                },
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
              PrimaryButton(label: 'Enregistrer', onPressed: _save),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
