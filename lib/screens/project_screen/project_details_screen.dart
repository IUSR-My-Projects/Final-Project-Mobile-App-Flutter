import 'package:flutter/material.dart';
import 'package:final_project_mobile_app_flutter/models/project_model.dart';
import 'package:final_project_mobile_app_flutter/screens/project_screen/project_tasks_screen.dart';

import '../../widgets/details_container_widget.dart';
import '../task_screen/add_task_from_project_screen.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailsScreen({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل المشروع'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailContainerWidget(
              context,
              title: project.name,
              titleStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 16),
            DetailContainerWidget(
              context,
              title: 'الوصف:',
              content: project.description,
            ),
            SizedBox(height: 16),
            DetailContainerWidget(
              context,
              title: 'تاريخ الإنشاء: ' +
                  (project.createdAt.toLocal()).toString().split(' ')[0],
            ),
            SizedBox(height: 16),
            DetailContainerWidget(
              context,
              title: project.finishedAt != null
                  ? 'تاريخ الانتهاء: ' +
                      (project.finishedAt!.toLocal()).toString().split(' ')[0]
                  : 'تاريخ الانتهاء: لم يتم التحديد',
            ),
            SizedBox(height: 16),
            if (project.finishedAt != null)
              DetailContainerWidget(
                context,
                title:
                    'الأيام المتبقية: ${project.finishedAt!.difference(DateTime.now()).inDays} يوم',
                textColor: Colors.green,
              ),

            // Tasks for this project
            SizedBox(height: 26),
            Container(
                width: double.infinity,
                child: Text("المهام لهذا المشروع",
                    textDirection: TextDirection.rtl)),
            Expanded(
              child: ProjectTasksScreen(projectId: project.id),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddTaskFromProjectScreen(projectId: project.id),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
