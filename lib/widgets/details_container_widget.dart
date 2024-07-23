import 'package:flutter/material.dart';

Widget DetailContainerWidget(
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
