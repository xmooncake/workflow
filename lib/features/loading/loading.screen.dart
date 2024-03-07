import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/brand/pralnia77_logo.png',
              width: MediaQuery.of(context).size.width * 0.4,
            ),
            const SizedBox(height: 24),
            LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.blue,
              size: 36,
            ),
            const SizedBox(height: 24),
            const Text('Ładowanie...'),
          ],
        ),
      ),
    );
  }
}
