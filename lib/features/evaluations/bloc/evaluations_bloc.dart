import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'package:rfid77workflow/data/models/evaluation.dart';
import 'package:rfid77workflow/features/hive/hive.service.dart';

part 'evaluations_event.dart';
part 'evaluations_state.dart';

class EvaluationsBloc extends Bloc<EvaluationsEvent, EvaluationsState> {
  EvaluationsBloc() : super(const EvaluationsState()) {
    on<EvaluationsInitializedEvent>((event, emit) {
      final evaluations =
          Hive.box<Evaluation>(HiveService.kEvaluationsBoxName).values;
      final List<ActivityEvaluation> activityEvaluations = evaluations
          .whereType<ActivityEvaluation>()
          .where((element) => element.weight == null)
          .toList();

      emit(
        EvaluationsState(
          evaluations: activityEvaluations,
          status: EvaluationsStatus.success,
        ),
      );
    });
  }
}
