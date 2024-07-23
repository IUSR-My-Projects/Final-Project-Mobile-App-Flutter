import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget TextFieldWidget({
  required String label,
  required TextEditingController controller,
  bool isPassword = false,
  String hintText = '',
}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.normal,
                  fontSize: 16)),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          controller: controller,
          obscureText: isPassword,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              filled: true,
              hintText: hintText,
              hintStyle: const TextStyle(
                  color: Color(0xffB0B0B0),
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
              fillColor: const Color(0xff333333),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(14))),
        )
      ],
    ),
  );
}