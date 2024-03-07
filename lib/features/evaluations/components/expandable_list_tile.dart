import 'package:flutter/material.dart';

import 'package:rfid77workflow/data/models/evaluation.dart';
import 'package:rfid77workflow/features/app/app.dart';
import 'package:rfid77workflow/features/app/bloc/app_bloc.dart';
import 'package:rfid77workflow/features/app/router.dart';

class ExpandableListTile extends StatelessWidget {
  const ExpandableListTile({
    super.key,
    required this.evaluation,
    required this.size,
  });

  final ActivityEvaluation evaluation;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final contrahent = (appBloc.state as AppSuccessState)
        .contrahents
        .where((element) => element.id == evaluation.contrahentId)
        .first;

    final contract = contrahent.contracts
        .where((element) => element.id == evaluation.contractId)
        .first;

    return ListTile(
      leading: SizedBox(
        width: size.width * 0.1,
        child: Align(
          child: Text(
            '${evaluation.startedAt.day}/${evaluation.startedAt.month}/${evaluation.startedAt.year}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ),
      title: Text(
        '${contract.name} - ${contrahent.name}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: const Text(
        'Wymagane uzupełnienie wagi',
        style: TextStyle(color: Colors.red),
      ),
      onTap: () => appBloc.router
          .go(AppRouter.kEditEvaluationRoute, extra: '${evaluation.id}'),
      trailing: const Icon(Icons.edit),
    );
  }

  Row tileContents(Evaluation currentEval) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        tileContentsData(
          'Data rozpoczęcia',
          currentEval.startedAt.toString(),
        ),
        const SizedBox(height: 12),
        tileContentsData(
          'Data zakończenia',
          currentEval.finishedAt.toString(),
        ),
      ],
    );
  }

  Column tileContentsData(String title, String subtitle) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Text(subtitle),
      ],
    );
  }
}
