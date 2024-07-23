import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../providers/task_provider.dart';
import '../screens/task_screen/edit_task_screen.dart';
import '../screens/task_screen/task_details_screen.dart';

Widget BuildTaskItemWidget(
    {required TaskModel task,
    required BuildContext context,
    required TaskProvider taskProvider}) {
  return Dismissible(
    key: Key(task.id),
    direction: DismissDirection.endToStart,
    onDismissed: (direction) {
      taskProvider.deleteTask(task.id);
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(fontSize: 18.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      taskProvider.getProjectNameById(task.projectId),
                      style: TextStyle(fontSize: 14.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
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
