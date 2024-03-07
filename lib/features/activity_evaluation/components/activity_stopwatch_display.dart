import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rfid77workflow/features/activity_evaluation/bloc/activity_evaluation_bloc.dart';
import 'package:rfid77workflow/features/activity_evaluation/components/labeled_field.dart';

class ActivityStopwatchDisplay extends StatelessWidget {
  const ActivityStopwatchDisplay({
    super.key,
    this.displayText = '00:00:00',
    this.activityStatus = ActivityStatus.initial,
  });

  final String displayText;
  final ActivityStatus activityStatus;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<EvaluationActivityBloc, EvaluationActivityState>(
      builder: (context, state) {
        MaterialColor borderColor;

        switch (state.activityStatus) {
          case ActivityStatus.initial:
            borderColor = Colors.grey;
          case ActivityStatus.running:
            borderColor = Colors.orange;
          case ActivityStatus.stopped || ActivityStatus.sending:
            borderColor = Colors.green;
        }

        return LabeledField(
          shouldWrapInCard: false,
          labelText: 'Czas pracy magla',
          child: Container(
            width: size.width * 0.4,
            padding: const EdgeInsets.symmetric(vertical: 42),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1.8,
                color: borderColor,
              ),
            ),
            child: Center(
              child: SizedBox(
                width: size.width * 0.35, // Fixed width for the text container
                child: Text(
                  state.forceDisplayTime ?? displayText,
                  textAlign: TextAlign.center, // Ensure text is always centered
                  style: GoogleFonts.chivoMono(
                    fontSize:
                        Theme.of(context).textTheme.headlineLarge?.fontSize,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
