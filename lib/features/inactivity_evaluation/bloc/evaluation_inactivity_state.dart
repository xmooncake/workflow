part of 'evaluation_inactivity_bloc.dart';

final class EvaluationInactivityState extends Equatable {
  const EvaluationInactivityState({
    this.breakType,
    this.isForwardEnabled = true,
  });

  final BreakType? breakType;
  final bool isForwardEnabled;

  EvaluationInactivityState copyWith({
    BreakType? breakType,
    bool? isForwardEnabled,
  }) {
    return EvaluationInactivityState(
      breakType: breakType ?? this.breakType,
      isForwardEnabled: isForwardEnabled ?? this.isForwardEnabled,
    );
  }

  @override
  List<Object?> get props => [breakType, isForwardEnabled];
}
