import 'package:flutter/material.dart';

class CustomRadioListTile<T> extends StatelessWidget {
  const CustomRadioListTile({
    required this.title,
    required this.value,
    required this.onChanged,
    this.groupValue,
    super.key,
  });

  final String title;

  final T value;
  final T? groupValue;

  final void Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.6,
      child: RadioListTile<T>(
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color.fromARGB(255, 158, 158, 158),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.all(16),
        title: Text(title),
        groupValue: groupValue,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
