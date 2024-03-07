import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rfid77workflow/data/models/assortment.dart';
import 'package:rfid77workflow/data/models/contract.dart';
import 'package:rfid77workflow/data/models/contrahent.dart';
import 'package:rfid77workflow/data/models/evaluation.dart';
import 'package:rfid77workflow/data/models/user.dart';
import 'package:rfid77workflow/features/activity_evaluation/bloc/activity_evaluation_bloc.dart';
import 'package:rfid77workflow/features/activity_evaluation/components/activity_stopwatch_display.dart';
import 'package:rfid77workflow/features/activity_evaluation/components/dropdown_button_with_search.dart';
import 'package:rfid77workflow/features/activity_evaluation/components/kg_input_field.dart';
import 'package:rfid77workflow/features/activity_evaluation/components/reactive_fab.dart';
import 'package:rfid77workflow/features/app/app.dart';
import 'package:rfid77workflow/features/app/bloc/app_bloc.dart';

class EvaluationActivityScreen extends StatelessWidget {
  const EvaluationActivityScreen({super.key, this.evaluationToEdit});

  final ActivityEvaluation? evaluationToEdit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        if (evaluationToEdit != null) {
          return EvaluationActivityBloc(
            evaluationToEdit: evaluationToEdit,
          )..add(InitializeEditEvaluationEvent(evaluationToEdit!.id));
        } else {
          return EvaluationActivityBloc();
        }
      },
      child: const _EvaluationActivityView(),
    );
  }
}

class _EvaluationActivityView extends StatelessWidget {
  const _EvaluationActivityView();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Ewaluacja pracy magla'),
          backgroundColor: Colors.white,
        ),
        floatingActionButton: const ReactiveFAB(
          widthModifier: 0.15,
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<EvaluationActivityBloc, EvaluationActivityState>(
                builder: (context, state) {
                  final bloc = context.read<EvaluationActivityBloc>();

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      KgInputField(
                        controller: context
                            .read<EvaluationActivityBloc>()
                            .kilogramsController,
                      ),
                      userDropdown(state, bloc),
                      contrahentDropdown(state, bloc),
                      contractDropdown(state, bloc),
                      assortmentDropdown(state, bloc),
                    ],
                  );
                },
              ),
              stopwatchStreamBuilder(context),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<String> stopwatchStreamBuilder(BuildContext context) {
    return StreamBuilder<String>(
      stream: context.read<EvaluationActivityBloc>().formattedStopwatchValues,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ActivityStopwatchDisplay(
            displayText: snapshot.data!,
            activityStatus:
                context.read<EvaluationActivityBloc>().state.activityStatus,
          );
        } else {
          return const ActivityStopwatchDisplay();
        }
      },
    );
  }

  LabeledDropdownButtonWithSearch<User> userDropdown(
    EvaluationActivityState state,
    EvaluationActivityBloc bloc,
  ) {
    return LabeledDropdownButtonWithSearch<User>(
      labelText: 'Użytkownik',
      hintText: 'Wybierz użytkownika',
      isError: state.isMissingRequiredFields,
      widthModifier: 0.4,
      items: (appBloc.state as AppSuccessState)
          .users
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      selectedValue: state.selectedUser,
      onChanged: (user) => bloc.add(
        EvaluationUserSelectedEvent(user: user),
      ),
    );
  }

  LabeledDropdownButtonWithSearch<String> assortmentDropdown(
    EvaluationActivityState state,
    EvaluationActivityBloc bloc,
  ) {
    return LabeledDropdownButtonWithSearch<String>(
      labelText: 'Asortyment',
      hintText: 'Wybierz kategorię asortymentu',
      isError: state.isMissingRequiredFields,
      widthModifier: 0.4,
      items: usedAssortment
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      selectedValue: state.selectedAssortmentType,
      onChanged: (assortment) => bloc.add(
        EvaluationAssortmentTypeSelectedEvent(assortmentType: assortment),
      ),
    );
  }

  LabeledDropdownButtonWithSearch<Contrahent> contrahentDropdown(
    EvaluationActivityState state,
    EvaluationActivityBloc bloc,
  ) {
    return LabeledDropdownButtonWithSearch<Contrahent>(
      labelText: 'Kontrahent',
      hintText: 'Wybierz kontrahenta',
      isError: state.isMissingRequiredFields,
      widthModifier: 0.4,
      items: (appBloc.state as AppSuccessState)
          .contrahents
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      selectedValue: state.selectedContrahent,
      onChanged: (value) => bloc.add(
        EvaluationContrahentSelectedEvent(
          contrahent: value,
        ),
      ),
    );
  }

  LabeledDropdownButtonWithSearch<Contract> contractDropdown(
    EvaluationActivityState state,
    EvaluationActivityBloc bloc,
  ) {
    return LabeledDropdownButtonWithSearch<Contract>(
      labelText: 'Umowa',
      hintText: 'Wybierz umowę',
      isError: state.isMissingRequiredFields,
      widthModifier: 0.4,
      items: state.selectedContrahent?.contracts
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList() ??
          [],
      selectedValue: state.selectedContract,
      onChanged: (contract) => bloc.add(
        EvaluationContractSelectedEvent(
          contract: contract,
        ),
      ),
    );
  }
}
