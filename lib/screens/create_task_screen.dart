import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../core/app_state.dart';
import '../core/project_ui.dart';
import '../models/models.dart';
import '../widgets/primary_button.dart';

class CreateTaskScreen extends StatefulWidget {
  final String? projectId;
  const CreateTaskScreen({super.key, this.projectId});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  late String _projectId;
  DateTime _due = DateTime.now().add(const Duration(days: 7));
  TaskPriority _priority = TaskPriority.medium;

  @override
  void initState() {
    super.initState();
    final projects = context.read<AppState>().projects;
    _projectId = widget.projectId ?? projects.first.id;
  }

  @override
  void dispose() {
    _titleController.dispose();
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

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _due,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _due = picked);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final state = context.read<AppState>();
    state.addTask(
      Task(
        id: state.newId(),
        projectId: _projectId,
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        dueDate: _due,
        priority: _priority,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final projects = context.watch<AppState>().projects;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: Text(
          'Nouvelle tâche',
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
              _label('Titre'),
              TextFormField(
                controller: _titleController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Ex : Conception de l\'UI',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Entrez le titre de la tâche.'
                    : null,
              ),
              _label('Description'),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Décrivez brièvement la tâche…',
                ),
              ),
              _label('Projet'),
              DropdownButtonFormField<String>(
                initialValue: _projectId,
                decoration: const InputDecoration(),
                items: projects
                    .map(
                      (p) => DropdownMenuItem(value: p.id, child: Text(p.name)),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _projectId = v!),
              ),
              _label('Date limite'),
              InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: const InputDecoration(),
                  child: Text(
                    fmtDate(_due),
                    style: const TextStyle(color: AppColors.navy),
                  ),
                ),
              ),
              _label('Priorité'),
              DropdownButtonFormField<TaskPriority>(
                initialValue: _priority,
                decoration: const InputDecoration(),
                items: const [
                  DropdownMenuItem(
                    value: TaskPriority.high,
                    child: Text('Haute'),
                  ),
                  DropdownMenuItem(
                    value: TaskPriority.medium,
                    child: Text('Moyenne'),
                  ),
                  DropdownMenuItem(
                    value: TaskPriority.low,
                    child: Text('Basse'),
                  ),
                ],
                onChanged: (v) => setState(() => _priority = v!),
              ),
              const SizedBox(height: 28),
              PrimaryButton(label: 'Créer la tâche', onPressed: _submit),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
