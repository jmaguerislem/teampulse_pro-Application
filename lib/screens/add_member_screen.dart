import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../core/app_state.dart';
import '../models/models.dart';
import '../widgets/primary_button.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
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
    if (!_formKey.currentState!.validate()) return;
    final state = context.read<AppState>();
    state.addMember(
      Member(
        id: state.newId(),
        name: _nameController.text.trim(),
        role: _roleController.text.trim(),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: Text(
          'Nouveau membre',
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
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: 'Ex : Amina Ben Ali',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Entrez le nom du membre.'
                    : null,
              ),
              _label('Rôle'),
              TextFormField(
                controller: _roleController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Ex : Développeuse front',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Entrez le rôle du membre.'
                    : null,
              ),
              const SizedBox(height: 28),
              PrimaryButton(label: 'Ajouter le membre', onPressed: _submit),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
