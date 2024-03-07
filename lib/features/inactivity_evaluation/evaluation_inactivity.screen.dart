import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rfid77workflow/data/models/break_type.dart';
import 'package:rfid77workflow/features/app/app.dart';
import 'package:rfid77workflow/features/app/bloc/app_bloc.dart';
import 'package:rfid77workflow/features/app/router.dart';
import 'package:rfid77workflow/features/inactivity_evaluation/bloc/evaluation_inactivity_bloc.dart';
import 'package:rfid77workflow/features/inactivity_evaluation/components/done_button.dart';
import 'package:rfid77workflow/features/inactivity_evaluation/components/radio_list_tile.dart';

class EvaluationInactivityScreen extends StatelessWidget {
  const EvaluationInactivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EvaluationInactivityBloc(),
      child: const _EvaluationInactivityView(),
    );
  }
}

class _EvaluationInactivityView extends StatelessWidget {
  const _EvaluationInactivityView();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EvaluationInactivityBloc>();
    final size = MediaQuery.of(context).size;

    CustomRadioListTile radioListTile(BreakType value) {
      return CustomRadioListTile<BreakType>(
        title: value.displayName,
        groupValue: bloc.state.breakType,
        value: value,
        onChanged: (p0) => bloc.add(
          EvaluationInactivityBreakTypeSelectedEvent(
            breakType: value,
          ),
        ),
      );
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Przerwa w pracy magla'),
          actions: [
            TextButton.icon(
              onPressed: () => appBloc.add(
                AppOnRouteEvent(AppRouter.kEvaluationsRoute),
              ),
              icon: const Icon(Icons.list_alt),
              label: const Text('Historia operacji'),
            ),
          ],
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Aktualny czas nieaktywności:',
                        style: TextStyle(fontSize: 22),
                      ),
                      const SizedBox(height: 20),
                      StreamBuilder(
                        stream: bloc.formattedStopwatchStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data.toString(),
                              style: const TextStyle(fontSize: 30),
                            );
                          } else {
                            return const Text(
                              '00:00:00',
                              style: TextStyle(fontSize: 30),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<EvaluationInactivityBloc,
                      EvaluationInactivityState>(
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('Wybierz powód przerwy'),
                          radioListTile(BreakType.contrahentChange),
                          radioListTile(BreakType.waxing),
                          radioListTile(BreakType.breakTime),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                BlocBuilder<EvaluationInactivityBloc,
                    EvaluationInactivityState>(
                  builder: (context, state) {
                    return DoneButton(
                      width: size.width * 0.6,
                      icon: Icons.timer,
                      label: 'Rozpocznij maglowanie',
                      onPressed: state.isForwardEnabled
                          ? () => bloc.add(
                                EvaluationInactivityFinishedEvent(),
                              )
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
