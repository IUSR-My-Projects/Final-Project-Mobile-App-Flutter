import 'package:flutter/material.dart';

Widget ElevatedButtonWidget({
  required BuildContext context,
  required String label,
  required VoidCallback onPressed,
  Color color = Colors.deepPurple,
}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 60),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(color: Colors.white)),
    ),
  );
}
