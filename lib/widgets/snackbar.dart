import 'dart:io';

import 'package:flutter/material.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:overlay_support/overlay_support.dart';

class Utils {
  static void showTopSnackBar(
          BuildContext context, String message, Color color, int bottom) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        duration: const Duration(seconds: 2),
        // animation: ,
        // animation:
        dismissDirection: DismissDirection.up,
        backgroundColor: color,
        elevation: .1,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - bottom,
            right: 20,
            left: 20),
      ));
}
