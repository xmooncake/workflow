part of 'activity_evaluation_bloc.dart';

enum ActivityStatus {
  initial,
  running,
  stopped,
  sending,
}

class EvaluationActivityState extends Equatable {
  const EvaluationActivityState({
    this.activityStatus = ActivityStatus.initial,
    this.startedAt,
    this.finishedAt,
    this.selectedUser,
    this.selectedContrahent,
    this.selectedContract,
    this.selectedAssortmentType,
    this.isInEditMode = false,
    this.isMissingRequiredFields = false,
    this.forceDisplayTime,
  });

  final ActivityStatus activityStatus;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  final User? selectedUser;
  final Contrahent? selectedContrahent;
  final Contract? selectedContract;
  final String? selectedAssortmentType;
  final bool isInEditMode;
  final bool isMissingRequiredFields;
  final String? forceDisplayTime;

  EvaluationActivityState copyWith({
    ActivityStatus? activityStatus,
    User? selectedUser,
    Contrahent? selectedContrahent,
    Contract? selectedContract,
    String? selectedAssortmentType,
    bool? isMissingRequiredFields,
    String? forceDisplayTime,
  }) {
    return EvaluationActivityState(
      activityStatus: activityStatus ?? this.activityStatus,
      selectedUser: selectedUser ?? this.selectedUser,
      selectedContrahent: selectedContrahent ?? this.selectedContrahent,
      selectedContract: selectedContract ?? this.selectedContract,
      selectedAssortmentType:
          selectedAssortmentType ?? this.selectedAssortmentType,
      isMissingRequiredFields:
          isMissingRequiredFields ?? this.isMissingRequiredFields,
      isInEditMode: isInEditMode,
      forceDisplayTime: forceDisplayTime ?? this.forceDisplayTime,
    );
  }

  @override
  List<Object?> get props => [
        activityStatus,
        selectedUser,
        selectedContrahent,
        selectedContract,
        selectedAssortmentType,
        isMissingRequiredFields,
      ];
}
