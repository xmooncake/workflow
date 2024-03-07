// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'evaluations_bloc.dart';

enum EvaluationsStatus { loading, success }

class EvaluationsState extends Equatable {
  const EvaluationsState({
    this.status = EvaluationsStatus.loading,
    this.evaluations = const [],
  });

  final EvaluationsStatus status;
  final List<ActivityEvaluation> evaluations;

  @override
  List<Object> get props => [];

  EvaluationsState copyWith({
    EvaluationsStatus? status,
    List<ActivityEvaluation>? evaluations,
  }) {
    return EvaluationsState(
      status: status ?? this.status,
      evaluations: evaluations ?? this.evaluations,
    );
  }
}
