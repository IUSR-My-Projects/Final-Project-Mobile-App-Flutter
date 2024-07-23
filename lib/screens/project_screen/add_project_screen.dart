import 'package:flutter/material.dart';
import 'package:final_project_mobile_app_flutter/widgets/elevated_button_widget.dart';
import 'package:final_project_mobile_app_flutter/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

import '../../models/project_model.dart';
import '../../providers/project_provider.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<AddProjectScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _finishedAt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة مشروع جديد'),
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
            SizedBox(height: 20.0),
            Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: Text("تاريخ الإنتهاء",
                    style: TextStyle(color: Colors.white70))),
            SizedBox(height: 16.0),
            TextFormField(
              readOnly: true,
              initialValue: _finishedAt == null
                  ? ""
                  : (_finishedAt!.toLocal()).toString().split(' ')[0],
              decoration: InputDecoration(
                filled: true,
                hintText: _finishedAt == null
                    ? 'اختر تاريخ إنتهاء المشروع'
                    : (_finishedAt!.toLocal()).toString().split(' ')[0],
                hintStyle: const TextStyle(
                    color: Color(0xffB0B0B0),
                    fontWeight: FontWeight.normal,
                    fontSize: 14),
                fillColor: const Color(0xff333333),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(14)),
              ),
              onTap: () => _pickDate(),
            ),

            // ListTile(
            //   title: Text(
            //     _finishedAt == null
            //         ? 'تاريخ الانتهاء: لم يتم التحديد'
            //         : 'تاريخ الانتهاء:  ' +
            //             (_finishedAt!.toLocal()).toString().split(' ')[0],
            //     textDirection: TextDirection.rtl,
            //   ),
            //   trailing: Icon(Icons.calendar_today),
            //   onTap: _pickDate,
            // ),
            SizedBox(height: 16.0),
            ElevatedButtonWidget(
                context: context,
                onPressed: () {
                  _addProject(context);
                },
                label: "إضافة"),
          ],
        ),
      ),
    );
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _finishedAt ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _finishedAt) {
      setState(() {
        _finishedAt = picked;
      });
      print(_finishedAt);
    }
  }

  void _addProject(BuildContext context) {
    String name = _nameController.text.trim();
    String description = _descriptionController.text.trim();
    DateTime now = DateTime.now();

    ProjectModel project = ProjectModel(
      id: '',
      name: name,
      description: description,
      createdAt: now,
      finishedAt: _finishedAt,
    );

    Provider.of<ProjectProvider>(context, listen: false).addProject(project);

    Navigator.pop(context);
  }
}
