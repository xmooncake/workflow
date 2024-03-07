import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rfid77workflow/features/activity_evaluation/bloc/activity_evaluation_bloc.dart';

class ReactiveFAB extends StatelessWidget {
  const ReactiveFAB({
    super.key,
    required this.widthModifier,
  });

  final double widthModifier;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<EvaluationActivityBloc, EvaluationActivityState>(
      builder: (context, state) {
        Widget selectedFAB = const SizedBox(); // Initialize an empty widget
        final bloc = context.read<EvaluationActivityBloc>();

        switch (state.activityStatus) {
          case ActivityStatus.initial:
            selectedFAB = FloatingActionButton.extended(
              onPressed: () => bloc.add(EvaluationActivityStartedEvent()),
              icon: const Icon(Icons.start),
              label: const Text('Rozpocznij'),
            );
          case ActivityStatus.running:
            selectedFAB = FloatingActionButton.extended(
              onPressed: () => bloc.add(EvaluationActivityStoppedEvent()),
              icon: const Icon(Icons.stop),
              label: const Text('Zakończ'),
            );
          case ActivityStatus.stopped:
            selectedFAB = FloatingActionButton.extended(
              onPressed: () =>
                  bloc.add(EvaluationActivityFinishedEvent(context)),
              icon: const Icon(Icons.save),
              label: const Text('Zapisz'),
            );
          case ActivityStatus.sending:
            selectedFAB = FloatingActionButton.extended(
              onPressed: () {},
              icon: const CircularProgressIndicator(),
              label: const Text('Wysyłanie'),
            );
        }

        return SizedBox(
          width: size.width * widthModifier,
          child: selectedFAB,
        );
      },
    );
  }
}
