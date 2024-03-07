import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router/go_router.dart';

import 'package:rfid77workflow/data/models/contrahent.dart';
import 'package:rfid77workflow/data/models/evaluation.dart';
import 'package:rfid77workflow/data/models/user.dart';
import 'package:rfid77workflow/data/repositories/data_repository.dart';
import 'package:rfid77workflow/data/repositories/evaluations_repository.dart';
import 'package:rfid77workflow/features/app/router.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppLoadingState()) {
    on<AppOnStartEvent>((event, emit) async {
      _repository = await DataRepository.instance();

      await EvaluationsRepository.postEvaluationsThatFailed();

      try {
        final users = await _repository.getUsers();
        final contrahents = await _repository.getContrahents();

        emit(AppSuccessState(users: users, contrahents: contrahents));

        add(AppOnRouteEvent(AppRouter.kEvaluationActivityRoute));
      } catch (e) {
        emit(AppErrorState(message: e.toString()));

        add(AppOnRouteEvent(AppRouter.kErrorRoute));
      }
    });

    on<AppOnRouteEvent>(
      (event, emit) async => await router.pushReplacement(event.route),
    );
  }
  late DataRepository _repository;

  late GoRouter router;
}
