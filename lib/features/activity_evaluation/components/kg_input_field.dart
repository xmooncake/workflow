import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:rfid77workflow/features/activity_evaluation/components/labeled_field.dart';

class KgInputField extends StatelessWidget {
  const KgInputField({super.key, this.controller});

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.grey;

    final textEditingController = controller ?? TextEditingController();

    if (textEditingController.text != '') {
      borderColor = const Color.fromARGB(255, 58, 173, 61);
    }

    return LabeledField(
      shouldWrapInCard: false,
      widthModifier: 0.4,
      labelText: 'Kilogramy',
      child: TextField(
        controller: textEditingController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          hintText: 'Wpisz ilość kilogramów',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 1.8,
              color: borderColor, // Make sure to define this color
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 1.8,
              color: borderColor, // Make sure to define this color
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 1.8,
              color: borderColor, // Make sure to define this color
            ),
          ),
        ),
      ),
    );
  }
}
