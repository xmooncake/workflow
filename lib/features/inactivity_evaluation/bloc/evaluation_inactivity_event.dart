part of 'evaluation_inactivity_bloc.dart';

sealed class EvaluationInactivityEvent extends Equatable {
  const EvaluationInactivityEvent();

  @override
  List<Object> get props => [];
}

class EvaluationInactivityDisableForwardEvent
    extends EvaluationInactivityEvent {}

class EvaluationInactivityBreakTypeSelectedEvent
    extends EvaluationInactivityEvent {
  const EvaluationInactivityBreakTypeSelectedEvent({required this.breakType});

  final BreakType breakType;
}

class EvaluationInactivityFinishedEvent extends EvaluationInactivityEvent {}
