import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/task_model.dart';
import '../../providers/task_provider.dart';
import '../../widgets/build_task_item_widget.dart';
import 'add_task_screen.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مهامي'),
      ),
      body: FutureBuilder<void>(
        future: Future.wait([
          Provider.of<TaskProvider>(context, listen: false).getTasks(),
          Provider.of<TaskProvider>(context, listen: false).getProjects(),
        ]),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/task_done.png',
                          height: 100,
                        ),
                        Text('لا توجد لديك مهام',
                            style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    TaskModel task = tasks[index];
                    return BuildTaskItemWidget(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
