import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:rfid77workflow/data/models/assortment.dart';
import 'package:rfid77workflow/data/models/evaluation.dart';

class HiveService {
  static const String kEvaluationsBoxName = 'evaluationsBox';

  static Box<Evaluation> get evaluationsBox =>
      Hive.box<Evaluation>(kEvaluationsBoxName);

  static Future<void> initialize() async {
    try {
      await Hive.initFlutter();
      Hive
        ..registerAdapter<Evaluation>(EvaluationAdapter())
        ..registerAdapter<ActivityEvaluation>(ActivityEvaluationAdapter())
        ..registerAdapter<InactivityEvaluation>(InactivityEvaluationAdapter());

      if (!Hive.isBoxOpen(kEvaluationsBoxName)) {
        await Hive.openBox<Evaluation>(kEvaluationsBoxName);
      }
    } catch (e) {
      log('Error initializing Hive database: $e');
    }
  }

  static Future<List<Evaluation>> getSavedEvaluations() async {
    return evaluationsBox.values.toList();
  }

  static Evaluation getEvaluation(String id) {
    return evaluationsBox.values.firstWhere((e) => e.id.toString() == id);
  }

  static Future<void> addEvaluation({required Evaluation evaluation}) async {
    try {
      await evaluationsBox.add(evaluation);
      log('Added evaluation with seconds: ${evaluation.seconds}');
    } catch (e) {
      log('Error adding evaluation: $e');
    }
  }

  static Future<void> removeEvaluations(List<int> ids) async {
    for (final id in ids) {
      final key = evaluationsBox.keys.firstWhere(
        (k) => evaluationsBox.get(k)?.id == id,
        orElse: () => null,
      );
      if (key != null) {
        await evaluationsBox.delete(key);
      }
    }
  }

  static Future<int> getNextEvaluationId() async {
    final maxId =
        evaluationsBox.values.fold<int>(0, (max, e) => e.id > max ? e.id : max);
    return maxId + 1;
  }

  static List<Evaluation> getFailedToSendEvaluations() {
    final evaluations = evaluationsBox.values;

    return evaluations.where((e) => e.hasFailedToSend).toList();
  }

  static Future<void> addMockupEvaluations() async {
    final evaluations = List.generate(
      30,
      (index) => ActivityEvaluation(
        id: index,
        startedAt: DateTime.now(),
        finishedAt: DateTime.now(),
        seconds: index * 69,
        weight: index.toDouble(),
        contrahentId: 28,
        contractId: 66,
        assortmentType: usedAssortment[0],
        userId: 57,
        hasFailedToSend: true,
      ),
    );

    log('Adding mockup evaluations to Hive: $evaluations');

    evaluations.forEach((evaluation) async {
      await HiveService.addEvaluation(evaluation: evaluation);
    });
  }
}
