import 'dart:developer';

import 'package:rfid77workflow/data/api/api_provider.dart';
import 'package:rfid77workflow/data/models/evaluation.dart';
import 'package:rfid77workflow/features/hive/hive.service.dart';

class EvaluationsRepository {
  static Future<void> onEvaluationFinished({
    required Evaluation evaluation,
  }) async {
    try {
      await _postEvaluations([evaluation]);

      await HiveService.removeEvaluations([evaluation.id]);
    } catch (e) {
      log('Error posting evaluation: $e');

      HiveService.addEvaluation(
        evaluation: evaluation.copyWith(hasFailedToSend: true),
      );
    }
  }

  static Future<void> postEvaluationsThatFailed() async {
    final evaluations = HiveService.getFailedToSendEvaluations();

    try {
      if (evaluations.isEmpty) return;

      await _postEvaluations(evaluations);

      await HiveService.removeEvaluations([for (final e in evaluations) e.id]);
    } catch (e) {
      log('Error posting evaluation: $e');
    }
  }

  static Future<void> _postEvaluations(
    List<Evaluation> evaluations,
  ) async {
    final List<Map<String, dynamic>> jsonList =
        evaluations.map((evaluation) => evaluation.toJson()).toList();

    log(jsonList.toString());

    final ApiProvider apiProvider = await ApiProvider.instance();

    await apiProvider.postEvaluations(evaluationsJson: jsonList);
  }
}
