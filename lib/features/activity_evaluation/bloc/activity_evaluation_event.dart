part of 'activity_evaluation_bloc.dart';

sealed class EvaluationActivityEvent extends Equatable {
  const EvaluationActivityEvent();

  @override
  List<Object> get props => [];
}

final class EvaluationActivityStartedEvent extends EvaluationActivityEvent {}

final class EvaluationActivityStoppedEvent extends EvaluationActivityEvent {}

final class EvaluationActivityFinishedEvent extends EvaluationActivityEvent {
  const EvaluationActivityFinishedEvent(this.context);

  final BuildContext context;
}

final class _SaveEvaluationEvent extends EvaluationActivityEvent {
  const _SaveEvaluationEvent({this.context});

  final BuildContext? context;
}

final class EvaluationUserSelectedEvent extends EvaluationActivityEvent {
  const EvaluationUserSelectedEvent({this.user});

  final User? user;
}

final class EvaluationContrahentSelectedEvent extends EvaluationActivityEvent {
  const EvaluationContrahentSelectedEvent({this.contrahent});

  final Contrahent? contrahent;
}

final class EvaluationContractSelectedEvent extends EvaluationActivityEvent {
  const EvaluationContractSelectedEvent({this.contract});

  final Contract? contract;
}

final class EvaluationAssortmentTypeSelectedEvent
    extends EvaluationActivityEvent {
  const EvaluationAssortmentTypeSelectedEvent({this.assortmentType});

  final String? assortmentType;
}

final class EvaluationWeightChangedEvent extends EvaluationActivityEvent {}

final class InitializeEditEvaluationEvent extends EvaluationActivityEvent {
  const InitializeEditEvaluationEvent(this.evaluationId);

  final int evaluationId;
}
