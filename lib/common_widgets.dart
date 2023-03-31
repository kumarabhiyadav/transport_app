import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

textformFeildDecoration(hintText, suffixIcon) => InputDecoration(
      focusColor: primaryColor,
      iconColor: primaryColor,
      suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
      suffixIconColor: primaryColor,
      hintStyle: TextStyle(color: Colors.grey.shade300, fontSize: 18),
      contentPadding: const EdgeInsets.symmetric(vertical: 6),
      isDense: true,
      hintText: hintText,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
      disabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
    );

class CustomText extends StatelessWidget {
  final double tS;
  final double fontSize;
  final Color? color;
  final String text;

  const CustomText(
      {super.key,
      required this.text,
      this.color = primaryColor,
      this.fontSize = 18,
      required this.tS});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      style: GoogleFonts.lato(
          fontSize: tS * fontSize,
          letterSpacing: .56,
          fontWeight: FontWeight.w400,
          color: color),
    );
  }
}
