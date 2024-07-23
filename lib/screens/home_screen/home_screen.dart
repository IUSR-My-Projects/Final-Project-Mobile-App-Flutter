import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/project_provider.dart';
import '../../providers/task_provider.dart';
import '../../widgets/build_task_item_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الصفحة الرئيسية",
          textDirection: TextDirection.rtl,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // إحصائيات
              Text(
                'إحصائيات',
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Consumer<ProjectProvider>(
                builder: (context, projectProvider, child) {
                  projectProvider.getProjects();
                  return _buildStatCard(
                      'المشاريع', projectProvider.projects.length.toString());
                },
              ),
              SizedBox(height: 8.0),
              Consumer<TaskProvider>(
                builder: (context, taskProvider, child) {
                  taskProvider
                    ..getTasks()
                    ..getProjects();
                  return _buildStatCard(
                      'المهام', taskProvider.tasks.length.toString());
                },
              ),
              SizedBox(height: 8.0),
              Consumer<TaskProvider>(
                builder: (context, taskProvider, child) {
                  return _buildStatCard(
                      'المهام المتبقية',
                      taskProvider.tasks
                          .where((task) => task.startDate == null)
                          .length
                          .toString());
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'المهام الحديثة',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              // المهام الحديثة
              Consumer<TaskProvider>(
                builder: (context, taskProvider, child) {
                  return Column(
                    children: taskProvider.tasks.take(10).map((task) {
                      if (taskProvider.tasks.isEmpty) {
                        return Center(
                          child: Text('لا توجد مهام لهذا المشروع'),
                        );
                      }
                      return BuildTaskItemWidget(
                        context: context,
                        task: task,
                        taskProvider: taskProvider,
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(String title) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          title,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
