import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class DataEmptyWidget extends StatelessWidget {
  const DataEmptyWidget({this.imageHeight = 350});

  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(
          'assets/lottie/empty.json',
          height: imageHeight,
        ),
        const SizedBox(height: 5),
        Text(
          'Brak danych do wyświetlenia',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
