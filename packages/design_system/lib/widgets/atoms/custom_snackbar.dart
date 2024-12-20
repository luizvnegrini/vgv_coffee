import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    super.key,
    required String message,
    super.backgroundColor,
  }) : super(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 108),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          action: SnackBarAction(
            label: 'Close',
            textColor: Colors.white,
            onPressed: () {},
          ),
          duration: const Duration(seconds: 1),
        );
}
