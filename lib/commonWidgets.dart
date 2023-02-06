import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

titleTextStyle() => const TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.65);
textformFeildDecoration(hintText) => InputDecoration(
      hintText: hintText,
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
    );
