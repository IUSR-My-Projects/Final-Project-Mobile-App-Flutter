import 'package:flutter/material.dart';
import 'package:final_project_mobile_app_flutter/screens/task_screen/edit_task_screen.dart';
import 'package:final_project_mobile_app_flutter/screens/task_screen/task_details_screen.dart';
import 'package:provider/provider.dart';

import '../../models/task_model.dart';
import '../../providers/task_provider.dart';

class ProjectTasksScreen extends StatelessWidget {
  final String projectId;

  const ProjectTasksScreen({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: FutureBuilder<void>(
        future: Provider.of<TaskProvider>(context, listen: false)
            .getTasksByProjectId(projectId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('حدث خطأ أثناء جلب المهام'),
            );
          } else {
            return Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                List<TaskModel> tasks = taskProvider.tasks;

                if (tasks.isEmpty) {
                  return Center(
                    child: Text('لا توجد مهام لهذا المشروع'),
                  );
                }

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    TaskModel task = tasks[index];
                    return _buildTaskItem(
                        context: context,
                        task: task,
                        taskProvider: taskProvider);
                    // return DetailContainerWidget(context, title: task.title);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildTaskItem(
      {required TaskModel task,
      required BuildContext context,
      required TaskProvider taskProvider}) {
    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        taskProvider.deleteTask(task.id);
        // Provider.of<TaskProvider>(context, listen: false).getTasks();
      },
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('تأكيد الحذف'),
              content: Text('هل أنت متأكد أنك تريد حذف هذه المهمة؟'),
              actions: [
                TextButton(
                  child: Text('إلغاء'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: Text('حذف'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        );
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TaskDetailsScreen(task: task)),
          );
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      task.description,
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditTaskScreen(
                                task: task,
                              )),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
