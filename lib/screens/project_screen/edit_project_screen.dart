import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../models/project_model.dart';
import '../../providers/project_provider.dart';
import '../../widgets/text_field_widget.dart';

class EditProjectScreen extends StatefulWidget {
  final ProjectModel project;

  const EditProjectScreen({super.key, required this.project});

  @override
  _EditProjectScreenState createState() => _EditProjectScreenState();
}

class _EditProjectScreenState extends State<EditProjectScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  DateTime? _finishedAt;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.project.name);
    _descriptionController =
        TextEditingController(text: widget.project.description);
    _finishedAt = widget.project.finishedAt;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _finishedAt = null;
    super.dispose();
  }

  void _updateProject(BuildContext context) {
    String name = _nameController.text.trim();
    String description = _descriptionController.text.trim();
    DateTime? finishedAt = _finishedAt;

    ProjectModel updatedProject = ProjectModel(
      id: widget.project.id,
      name: name,
      userId: widget.project.userId,
      description: description,
      createdAt: widget.project.createdAt,
      finishedAt: finishedAt,
    );

    Provider.of<ProjectProvider>(context, listen: false)
        .updateProject(updatedProject);

    Navigator.pop(context);
    Fluttertoast.showToast(
      msg: 'تم تحديث المشروع',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تعديل المشروع'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFieldWidget(
              label: "اسم المشروع",
              controller: _nameController,
            ),
            SizedBox(height: 16.0),
            TextFieldWidget(
              label: "وصف المشروع",
              controller: _descriptionController,
            ),
            SizedBox(height: 16.0),
            ListTile(
              title: Text(
                _finishedAt == null
                    ? 'تاريخ الانتهاء: لم يتم التحديد'
                    : 'تاريخ الانتهاء:  ' +
                        (_finishedAt!.toLocal()).toString().split(' ')[0],
                textDirection: TextDirection.rtl,
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _updateProject(context),
              child: Text('تحديث المشروع'),
            ),
          ],
        ),
      ),
    );
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _finishedAt ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _finishedAt) {
      setState(() {
        _finishedAt = picked;
      });
      print(_finishedAt);
    }
  }
}
