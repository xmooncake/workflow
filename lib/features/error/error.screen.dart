import 'package:flutter/material.dart';

import 'package:rfid77workflow/features/app/app.dart';
import 'package:rfid77workflow/features/app/bloc/app_bloc.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nie udało się uruchomić aplikacji',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text((appBloc.state as AppErrorState).message),
          ],
        ),
      ),
    );
  }
}
