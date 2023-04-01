import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

textformFeildDecoration(hintText, suffixIcon) => InputDecoration(
      focusColor: primaryColor,
      iconColor: primaryColor,
      suffixIcon: suffixIcon == null ? null : suffixIcon,
      suffixIconColor: primaryColor,
      hintStyle: GoogleFonts.lato(
          fontSize: 16,
          letterSpacing: .56,
          fontWeight: FontWeight.w400,
          color: Colors.grey.shade300),
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
  final FontWeight? fontWeight;

  const CustomText(
      {super.key,
      required this.text,
      this.color = primaryColor,
      this.fontSize = 18,
      this.fontWeight = FontWeight.w400,
      required this.tS});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      style: GoogleFonts.lato(
          fontSize: tS * fontSize,
          letterSpacing: .56,
          fontWeight: fontWeight,
          color: color),
    );
  }
}
