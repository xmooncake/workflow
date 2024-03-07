import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rfid77workflow/data/models/evaluation.dart';
import 'package:rfid77workflow/features/app/app.dart';
import 'package:rfid77workflow/features/app/bloc/app_bloc.dart';
import 'package:rfid77workflow/features/app/router.dart';
import 'package:rfid77workflow/features/evaluations/bloc/evaluations_bloc.dart';
import 'package:rfid77workflow/features/evaluations/components/data_empty.dart';
import 'package:rfid77workflow/features/evaluations/components/expandable_list_tile.dart';

class EvaluationsScreen extends StatelessWidget {
  const EvaluationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) =>
          EvaluationsBloc()..add(EvaluationsInitializedEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                onPressed: () => appBloc
                    .add(AppOnRouteEvent(AppRouter.kEvaluationInactivityRoute)),
                icon: const Icon(Icons.arrow_back_ios),
              ),
              const SizedBox(width: 5),
              const Text('Historia operacji'),
            ],
          ),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(25),
          child: BlocBuilder<EvaluationsBloc, EvaluationsState>(
            builder: (context, state) {
              switch (state.status) {
                case EvaluationsStatus.loading:
                  return const Center(
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: CircularProgressIndicator(),
                    ),
                  );
                case EvaluationsStatus.success:
                  if (state.evaluations.isEmpty) {
                    return const Center(child: DataEmptyWidget());
                  }

                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.only(bottom: 10),
                    shrinkWrap: true,
                    itemCount: state.evaluations.length,
                    itemBuilder: (context, index) {
                      final Evaluation evaluation = state.evaluations[index];
                      return Card(
                        child: ExpandableListTile(
                          evaluation: evaluation as ActivityEvaluation,
                          size: size,
                        ),
                      );
                    },
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
