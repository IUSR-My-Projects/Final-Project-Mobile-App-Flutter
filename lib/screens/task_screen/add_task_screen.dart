import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/project_model.dart';
import '../../models/task_model.dart';
import '../../providers/project_provider.dart';
import '../../providers/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({
    super.key,
  });

  @override
  _AddTaskFromProjectScreenState createState() =>
      _AddTaskFromProjectScreenState();
}

class _AddTaskFromProjectScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  TaskStatus _status = TaskStatus.notStart;
  bool _priority = false;
  DateTime? _startDate;
  DateTime? _endDate;
  ProjectModel? _selectedProject;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (_startDate ?? DateTime.now())
          : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context)
      ..getProjects();
    final projects = projectProvider.projects;

    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة مهمة جديدة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<ProjectModel>(
                  decoration: InputDecoration(
                      filled: true,
                      labelText: projects.isEmpty
                          ? "ليس لديك أي مشاريع, يجب إنشاء مشروع أولا"
                          : 'اختر المشروع',
                      hintStyle: const TextStyle(
                          color: Color(0xffB0B0B0),
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                      fillColor: const Color(0xff333333),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(14))),
                  value: _selectedProject,
                  items: projects
                      .map((project) => DropdownMenuItem(
                            value: project,
                            child: Text(project.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedProject = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'يرجى اختيار المشروع';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      labelText: 'عنوان المهمة',
                      hintStyle: const TextStyle(
                          color: Color(0xffB0B0B0),
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                      fillColor: const Color(0xff333333),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(14))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال عنوان المهمة';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _title = value!;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      labelText: 'وصف المهمة',
                      hintStyle: const TextStyle(
                          color: Color(0xffB0B0B0),
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                      fillColor: const Color(0xff333333),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(14))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال وصف المهمة';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  readOnly: true,
                  initialValue: _startDate == null
                      ? ""
                      : (_startDate!.toLocal()).toString().split(' ')[0],
                  decoration: InputDecoration(
                    filled: true,
                    hintText: _startDate == null
                        ? 'اختر تاريخ البداية'
                        : (_startDate!.toLocal()).toString().split(' ')[0],
                    hintStyle: const TextStyle(
                        color: Color(0xffB0B0B0),
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                    fillColor: const Color(0xff333333),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  onTap: () => _selectDate(context, true),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  readOnly: true,
                  initialValue: _endDate == null
                      ? ""
                      : (_endDate!.toLocal()).toString().split(' ')[0],
                  decoration: InputDecoration(
                    filled: true,
                    hintText: _endDate == null
                        ? 'اختر تاريخ النهاية'
                        : (_endDate!.toLocal()).toString().split(' ')[0],
                    hintStyle: const TextStyle(
                        color: Color(0xffB0B0B0),
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                    fillColor: const Color(0xff333333),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  onTap: () => _selectDate(context, false),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<TaskStatus>(
                  decoration: InputDecoration(
                      filled: true,
                      labelText: 'حالة المهمة',
                      hintStyle: const TextStyle(
                          color: Color(0xffB0B0B0),
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                      fillColor: const Color(0xff333333),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(14))),
                  value: _status,
                  items: TaskStatus.values
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status.toString().split('.').last),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                SwitchListTile(
                  title: Text('أولوية المهمة'),
                  value: _priority,
                  onChanged: (value) {
                    setState(() {
                      _priority = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      TaskModel newTask = TaskModel(
                        id: '',
                        title: _title,
                        description: _description,
                        projectId: _selectedProject!.id,
                        status: _status,
                        priority: _priority,
                        startDate: _startDate,
                        endDate: _endDate,
                        createdAt: DateTime.now(),
                      );
                      Provider.of<TaskProvider>(context, listen: false)
                        ..addTask(newTask)
                        ..getTasks();
                      Navigator.pop(context);
                    }
                  },
                  child: Text('إضافة المهمة'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
