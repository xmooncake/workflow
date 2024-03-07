import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'package:rfid77workflow/data/models/break_type.dart';
import 'package:rfid77workflow/data/models/evaluation.dart';
import 'package:rfid77workflow/data/repositories/evaluations_repository.dart';
import 'package:rfid77workflow/features/app/app.dart';
import 'package:rfid77workflow/features/app/bloc/app_bloc.dart';
import 'package:rfid77workflow/features/app/router.dart';
import 'package:rfid77workflow/features/hive/hive.service.dart';

part 'evaluation_inactivity_event.dart';
part 'evaluation_inactivity_state.dart';

class EvaluationInactivityBloc
    extends Bloc<EvaluationInactivityEvent, EvaluationInactivityState> {
  EvaluationInactivityBloc() : super(const EvaluationInactivityState()) {
    _stopwatch.onStartTimer();
    _startedAt = DateTime.now();
    _stopwatch.secondTime.listen((value) {
      if (value == 10 && state.breakType == null) {
        add(EvaluationInactivityDisableForwardEvent());
      }
    });
    on<EvaluationInactivityDisableForwardEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            isForwardEnabled: false,
          ),
        );
      },
    );
    on<EvaluationInactivityBreakTypeSelectedEvent>(
      (event, emit) async {
        emit(
          EvaluationInactivityState(
            breakType: event.breakType,
          ),
        );
      },
    );
    on<EvaluationInactivityFinishedEvent>(
      (event, emit) async {
        _stopwatch.onStopTimer();

        if (state.breakType != null) {
          final newEvaluation = InactivityEvaluation(
            id: await HiveService.getNextEvaluationId(),
            startedAt: _startedAt,
            finishedAt: DateTime.now(),
            seconds: _stopwatch.secondTime.value,
            breakType: state.breakType!,
          );

          await EvaluationsRepository.onEvaluationFinished(
            evaluation: newEvaluation,
          );
        }

        appBloc.add(AppOnRouteEvent(AppRouter.kEvaluationActivityRoute));
      },
    );
  }

  @override
  Future<void> close() {
    _stopwatch.dispose();
    return super.close();
  }

  final StopWatchTimer _stopwatch = StopWatchTimer();

  Stream<int> get _stopwatchValues => Stream.periodic(
        const Duration(milliseconds: 100),
        (_) => _stopwatch.rawTime.value,
      );

  Stream<String> get formattedStopwatchStream {
    return _stopwatchValues.map((milliseconds) {
      final hours = (milliseconds ~/ 3600000).toString().padLeft(2, '0');
      final minutes =
          ((milliseconds % 3600000) ~/ 60000).toString().padLeft(2, '0');
      final seconds =
          ((milliseconds % 60000) ~/ 1000).toString().padLeft(2, '0');
      return '$hours:$minutes:$seconds';
    });
  }

  late DateTime _startedAt;
}
