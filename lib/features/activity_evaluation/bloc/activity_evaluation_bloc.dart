import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'package:rfid77workflow/data/models/contract.dart';
import 'package:rfid77workflow/data/models/contrahent.dart';
import 'package:rfid77workflow/data/models/evaluation.dart';
import 'package:rfid77workflow/data/models/user.dart';
import 'package:rfid77workflow/data/repositories/evaluations_repository.dart';
import 'package:rfid77workflow/features/app/app.dart';
import 'package:rfid77workflow/features/app/bloc/app_bloc.dart';
import 'package:rfid77workflow/features/app/router.dart';
import 'package:rfid77workflow/features/shared/toasts.dart';
import 'package:rfid77workflow/features/hive/hive.service.dart';

part 'activity_evaluation_event.dart';
part 'activity_evaluation_state.dart';

class EvaluationActivityBloc
    extends Bloc<EvaluationActivityEvent, EvaluationActivityState> {
  EvaluationActivityBloc({
    ActivityEvaluation? evaluationToEdit,
  }) : super(
          evaluationToEdit == null
              ? const EvaluationActivityState()
              : EvaluationActivityState(
                  activityStatus: ActivityStatus.stopped,
                  selectedUser:
                      (appBloc.state as AppSuccessState).users.firstWhere(
                            (element) => element.id == evaluationToEdit.userId,
                          ),
                  isInEditMode: true,
                  selectedContrahent:
                      (appBloc.state as AppSuccessState).contrahents.firstWhere(
                            (element) =>
                                element.id == evaluationToEdit.contrahentId,
                          ),
                  selectedContract: (appBloc.state as AppSuccessState)
                      .contrahents
                      .firstWhere(
                        (element) =>
                            element.id == evaluationToEdit.contrahentId,
                      )
                      .contracts
                      .firstWhere(
                        (element) => element.id == evaluationToEdit.contractId,
                      ),
                  selectedAssortmentType: evaluationToEdit.assortmentType,
                  forceDisplayTime:
                      _secondsToDisplayText(evaluationToEdit.seconds),
                ),
        ) {
    _startTime = DateTime.now();
    kilogramsController.addListener(() {
      add(EvaluationWeightChangedEvent());
    });
    on<EvaluationActivityStartedEvent>(
      (event, emit) {
        _stopwatch.onStartTimer();
        emit(
          state.copyWith(
            activityStatus: ActivityStatus.running,
          ),
        );
      },
    );
    on<EvaluationActivityStoppedEvent>(
      (event, emit) async {
        _stopwatch.onStopTimer();

        emit(
          state.copyWith(
            activityStatus: ActivityStatus.stopped,
          ),
        );
      },
    );
    on<EvaluationActivityFinishedEvent>(
      (event, emit) async {
        if (_areRequiredFieldsEmpty) {
          ToastsProvider.showRequiredFieldsEmpty(event.context);
          emit(state.copyWith(isMissingRequiredFields: true));
        } else {
          add(_SaveEvaluationEvent(context: event.context));
        }
      },
    );
    on<_SaveEvaluationEvent>(
      (event, emit) async {
        emit(state.copyWith(activityStatus: ActivityStatus.sending));

        if (state.isInEditMode) {
          if (kilogramsController.text.isEmpty && event.context != null) {
            ToastsProvider.showRequiredFieldsEmpty(event.context!);
            return;
          }

          log('Editing evaluation seconds: ${evaluationToEdit!.seconds}');

          final newEvaluation = ActivityEvaluation(
            id: evaluationToEdit.id,
            startedAt: evaluationToEdit.startedAt,
            finishedAt: evaluationToEdit.finishedAt,
            seconds: evaluationToEdit.seconds,
            contrahentId: state.selectedContrahent!.id,
            contractId: state.selectedContract!.id,
            assortmentType: state.selectedAssortmentType!,
            userId: state.selectedUser!.id,
            weight: double.tryParse(kilogramsController.text),
          );

          await EvaluationsRepository.onEvaluationFinished(
            evaluation: newEvaluation,
          );

          appBloc.add(AppOnRouteEvent(AppRouter.kEvaluationsRoute));
        } else {
          final id = await HiveService.getNextEvaluationId();

          final evaluation = ActivityEvaluation(
            id: id,
            startedAt: _startTime,
            finishedAt: DateTime.now(),
            seconds: _stopwatch.secondTime.value,
            contrahentId: state.selectedContrahent!.id,
            contractId: state.selectedContract!.id,
            assortmentType: state.selectedAssortmentType!,
            userId: state.selectedUser!.id,
            weight: double.tryParse(kilogramsController.text),
          );

          if (evaluation.weight != null) {
            await EvaluationsRepository.onEvaluationFinished(
              evaluation: evaluation,
            );
          } else {
            await HiveService.addEvaluation(evaluation: evaluation);
          }

          appBloc.add(AppOnRouteEvent(AppRouter.kEvaluationInactivityRoute));
        }
      },
    );
    on<EvaluationUserSelectedEvent>(
      (event, emit) => emit(
        state.copyWith(selectedUser: event.user),
      ),
    );
    on<EvaluationContrahentSelectedEvent>(
      (event, emit) => emit(
        state.copyWith(selectedContrahent: event.contrahent),
      ),
    );
    on<EvaluationWeightChangedEvent>(
      (event, emit) {
        emit(state);
      },
    );
    on<EvaluationContractSelectedEvent>(
      (event, emit) => emit(
        state.copyWith(selectedContract: event.contract),
      ),
    );
    on<EvaluationAssortmentTypeSelectedEvent>(
      (event, emit) =>
          emit(state.copyWith(selectedAssortmentType: event.assortmentType)),
    );
    on<InitializeEditEvaluationEvent>((event, emit) {
      final id = event.evaluationId;
      final box = Hive.box<Evaluation>(HiveService.kEvaluationsBoxName);

      final ActivityEvaluation evaluation = box.values
          .firstWhere((element) => element.id == id) as ActivityEvaluation;

      final user = (appBloc.state as AppSuccessState)
          .users
          .firstWhere((element) => element.id == evaluation.userId);
      final contrahent = (appBloc.state as AppSuccessState)
          .contrahents
          .firstWhere((element) => element.id == evaluation.contrahentId);
      final contract = contrahent.contracts
          .firstWhere((element) => element.id == evaluation.contractId);

      kilogramsController.text = evaluation.weight?.toString() ?? '';

      emit(
        state.copyWith(
          activityStatus: ActivityStatus.stopped,
          selectedUser: user,
          selectedContrahent: contrahent,
          selectedContract: contract,
          selectedAssortmentType: evaluation.assortmentType,
          forceDisplayTime: _secondsToDisplayText(evaluation.seconds),
        ),
      );
    });
  }

  static String _formatTime(int time) => time.toString().padLeft(2, '0');

  static String _secondsToDisplayText(int totalSeconds) {
    final int hours = totalSeconds ~/ 3600;
    final int minutes = (totalSeconds % 3600) ~/ 60;
    final int seconds = totalSeconds % 60;

    return '${_formatTime(hours)}:${_formatTime(minutes)}:${_formatTime(seconds)}';
  }

  late DateTime _startTime;

  final TextEditingController kilogramsController = TextEditingController();
  final StopWatchTimer _stopwatch = StopWatchTimer();

  Stream<int> get _stopwatchValues => _stopwatch.rawTime;

  Stream<String> get formattedStopwatchValues => _stopwatchValues.map(
        (milliseconds) {
          final hours = ((milliseconds / (1000 * 60 * 60)) % 24).floor();
          final minutes = ((milliseconds / (1000 * 60)) % 60).floor();
          final seconds = ((milliseconds / 1000) % 60).floor();

          return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
        },
      );

  bool get _areRequiredFieldsEmpty =>
      state.selectedAssortmentType == null ||
      state.selectedContract == null ||
      state.selectedContrahent == null ||
      state.selectedUser == null;
}
