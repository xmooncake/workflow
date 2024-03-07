import 'package:go_router/go_router.dart';

import 'package:rfid77workflow/data/models/evaluation.dart';
import 'package:rfid77workflow/features/activity_evaluation/activity_evaluation.screen.dart';
import 'package:rfid77workflow/features/error/error.screen.dart';
import 'package:rfid77workflow/features/evaluations/evaluations.screen.dart';
import 'package:rfid77workflow/features/hive/hive.service.dart';
import 'package:rfid77workflow/features/inactivity_evaluation/evaluation_inactivity.screen.dart';
import 'package:rfid77workflow/features/loading/loading.screen.dart';

class AppRouter {
  AppRouter() {
    _router = GoRouter(
      initialLocation: kLoadingRoute,
      routes: [
        GoRoute(
          path: kLoadingRoute,
          builder: (context, state) => const LoadingScreen(),
        ),
        GoRoute(
          path: kEvaluationActivityRoute,
          builder: (context, state) => const EvaluationActivityScreen(),
        ),
        GoRoute(
          path: kEvaluationInactivityRoute,
          builder: (context, state) => const EvaluationInactivityScreen(),
        ),
        GoRoute(
          path: kEvaluationsRoute,
          builder: (context, state) => const EvaluationsScreen(),
          routes: [
            GoRoute(
              path: 'edit-evaluation',
              builder: (context, state) {
                final String evaluationId =
                    GoRouterState.of(context).extra! as String;

                final evaluationToEdit =
                    HiveService.getEvaluation(evaluationId);

                return EvaluationActivityScreen(
                  evaluationToEdit: evaluationToEdit as ActivityEvaluation?,
                );
              },
            ),
          ],
        ),
        GoRoute(path: kErrorRoute, builder: (context, state) => ErrorScreen()),
      ],
    );
  }

  late final GoRouter _router;

  GoRouter get router => _router;

  static String kLoadingRoute = '/';
  static String kErrorRoute = '/error';
  static String kEvaluationActivityRoute = '/evaluation-activity';
  static String kEvaluationInactivityRoute = '/evaluation-inactivity';
  static String kEvaluationsRoute = '/evaluations';
  static String kEditEvaluationRoute = '/evaluations/edit-evaluation';
}
