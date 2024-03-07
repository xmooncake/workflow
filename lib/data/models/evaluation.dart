// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import 'package:rfid77workflow/data/models/break_type.dart';

part 'evaluation.g.dart';

@HiveType(typeId: 0)
class Evaluation extends HiveObject {
  Evaluation({
    required this.id,
    required this.startedAt,
    required this.finishedAt,
    required this.seconds,
    this.hasFailedToSend = false,
  });

  @HiveField(0)
  final int id;

  @HiveField(1)
  final DateTime startedAt;

  @HiveField(2)
  final DateTime finishedAt;

  @HiveField(3)
  final int seconds;

  @HiveField(4)
  final bool hasFailedToSend;

  Map<String, dynamic> toJson() {
    return {
      'started_at': startedAt.toIso8601String(),
      'finished_at': finishedAt.toIso8601String(),
      'seconds': seconds,
    };
  }

  @override
  String toString() {
    return 'Evaluation(id: $id, startedAt: $startedAt, finishedAt: $finishedAt, seconds: $seconds, hasFailedToSend: $hasFailedToSend)';
  }

  Evaluation copyWith({
    int? id,
    DateTime? startedAt,
    DateTime? finishedAt,
    int? seconds,
    bool? hasFailedToSend,
  }) {
    return Evaluation(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      seconds: seconds ?? this.seconds,
      hasFailedToSend: hasFailedToSend ?? this.hasFailedToSend,
    );
  }
}

@HiveType(typeId: 1)
class ActivityEvaluation extends Evaluation {
  ActivityEvaluation({
    required super.id,
    required super.startedAt,
    required super.finishedAt,
    required super.seconds,
    super.hasFailedToSend,

    //
    required this.contrahentId,
    required this.contractId,
    required this.assortmentType,
    required this.userId,
    this.weight,
  });

  @HiveField(5)
  final int contrahentId;

  @HiveField(6)
  final int contractId;

  @HiveField(7)
  final String assortmentType;

  @HiveField(8)
  final int userId;

  @HiveField(9)
  double? weight;

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    map.addAll({
      'contrahent_id': contrahentId,
      'contract_id': contractId,
      'user_id': userId,
      'assortment': assortmentType,
      'weight': weight,
    });
    return map;
  }

  @override
  Evaluation copyWith({
    int? id,
    DateTime? startedAt,
    DateTime? finishedAt,
    int? seconds,
    bool? hasFailedToSend,
    int? contrahentId,
    int? contractId,
    String? assortmentType,
    int? userId,
    double? weight,
  }) {
    return ActivityEvaluation(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      seconds: seconds ?? this.seconds,
      contrahentId: contrahentId ?? this.contrahentId,
      contractId: contractId ?? this.contractId,
      assortmentType: assortmentType ?? this.assortmentType,
      userId: userId ?? this.userId,
      weight: weight ?? this.weight,
    );
  }
}

@HiveType(typeId: 2)
class InactivityEvaluation extends Evaluation {
  InactivityEvaluation({
    required super.id,
    required super.startedAt,
    required super.finishedAt,
    required super.seconds,
    //
    required this.breakType,
  });

  @HiveField(10)
  BreakType breakType;

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    map.addAll({
      'break_type': breakType.toString().split('.').last,
    });
    return map;
  }
}
