part of 'evaluations_bloc.dart';

sealed class EvaluationsEvent extends Equatable {
  const EvaluationsEvent();

  @override
  List<Object> get props => [];
}

class EvaluationsInitializedEvent extends EvaluationsEvent {}
