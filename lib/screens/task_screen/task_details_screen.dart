import 'package:flutter/material.dart';

import '../../models/task_model.dart';

class TaskDetailsScreen extends StatelessWidget {
  final TaskModel task;

  const TaskDetailsScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل المهمة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailContainer(
              context,
              title: task.title,
              titleStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 16),
            _buildDetailContainer(
              context,
              title: 'الوصف:',
              content: task.description,
            ),
            SizedBox(height: 16),
            _buildDetailContainer(
              context,
              title: 'تاريخ البداية: ' +
                  (task.startDate?.toLocal().toString().split(' ')[0] ??
                      'غير محدد'),
            ),
            SizedBox(height: 16),
            _buildDetailContainer(
              context,
              title: 'تاريخ النهاية: ' +
                  (task.endDate?.toLocal().toString().split(' ')[0] ??
                      'غير محدد'),
            ),
            SizedBox(height: 16),
            _buildDetailContainer(
              context,
              title: 'حالة المهمة: ' + task.status.toString().split('.').last,
            ),
            SizedBox(height: 16),
            _buildDetailContainer(
              context,
              title: 'أولوية المهمة: ' + (task.priority ? 'عالية' : 'عادية'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailContainer(
    BuildContext context, {
    required String title,
    String? content,
    Color textColor = Colors.white70,
    TextStyle? titleStyle,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ??
                TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
          ),
          if (content != null) ...[
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
