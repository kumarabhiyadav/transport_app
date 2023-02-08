import 'package:flutter/material.dart';

import 'colors.dart';

titleTextStyle() => const TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.65);
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
