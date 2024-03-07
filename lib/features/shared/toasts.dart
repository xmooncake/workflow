import 'dart:async';

import 'package:flutter/material.dart';

import 'package:cherry_toast/cherry_toast.dart';

class ToastsProvider {
  // Prevents showing multiple toasts at the same time and causing an error
  static bool isToastBeingShown = false;

  static void showRequiredFieldsEmpty(BuildContext context) {
    if (!isToastBeingShown) {
      isToastBeingShown = true;

      CherryToast.error(
        title: const Text('Uzupełnij wymagane pola aby kontynuować'),
        displayCloseButton: false,
      ).show(context);

      Timer(
        const Duration(milliseconds: 5000),
        () => isToastBeingShown = false,
      );
    }
  }
}
