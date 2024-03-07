import 'package:flutter/cupertino.dart';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';

class ErrorToast extends StatelessWidget {
  const ErrorToast({super.key});

  @override
  Widget build(BuildContext context) {
    return CherryToast.error(
      title: const Text('Uzupełnij wymagane pola aby kontynuować'),
      animationType: AnimationType.fromRight,
      displayCloseButton: false,
    );
  }
}
