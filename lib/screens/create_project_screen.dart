import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../core/app_state.dart';
import '../core/project_ui.dart';
import '../l10n/app_localizations.dart';
import '../models/models.dart';
import '../widgets/primary_button.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  DateTime _start = DateTime.now();
  DateTime _deadline = DateTime.now().add(const Duration(days: 30));
  ProjectStatus _status = ProjectStatus.inProgress;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
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

  Future<void> _pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _start : _deadline,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() => isStart ? _start = picked : _deadline = picked);
  }

  Widget _dateField(String label, DateTime value, bool isStart) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(label),
          InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => _pickDate(isStart),
            child: InputDecorator(
              decoration: const InputDecoration(),
              child: Text(
                fmtDate(value),
                style: const TextStyle(color: AppColors.navy),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    final l = AppLocalizations.of(context)!;
    setState(() => _error = null);
    if (!_formKey.currentState!.validate()) return;

    if (_deadline.isBefore(_start)) {
      setState(() => _error = l.deadlineAfterStart);
      return;
    }

    final state = context.read<AppState>();
    state.addProject(
      Project(
        id: state.newId(),
        name: _nameController.text.trim(),
        description: _descController.text.trim(),
        startDate: _start,
        deadline: _deadline,
        status: _status,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.createProject,
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
              _label(l.projectName),
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(hintText: l.projectNameHint),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? l.enterProjectName : null,
              ),
              _label(l.description),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: InputDecoration(hintText: l.projectDescHint),
              ),
              Row(
                children: [
                  _dateField(l.startDate, _start, true),
                  const SizedBox(width: 12),
                  _dateField(l.deadline, _deadline, false),
                ],
              ),
              _label(l.status),
              DropdownButtonFormField<ProjectStatus>(
                initialValue: _status,
                decoration: const InputDecoration(),
                items: [
                  DropdownMenuItem(
                    value: ProjectStatus.inProgress,
                    child: Text(l.filterInProgress),
                  ),
                  DropdownMenuItem(
                    value: ProjectStatus.onHold,
                    child: Text(l.filterOnHold),
                  ),
                  DropdownMenuItem(
                    value: ProjectStatus.done,
                    child: Text(l.statusDone),
                  ),
                ],
                onChanged: (v) => setState(() => _status = v!),
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
              PrimaryButton(label: l.createTheProject, onPressed: _submit),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
