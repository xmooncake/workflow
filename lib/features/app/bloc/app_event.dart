part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppOnStartEvent extends AppEvent {}

class AppOnRouteEvent extends AppEvent {
  const AppOnRouteEvent(this.route);

  final String route;
}

class AppOnEvaluationCreatedEvent extends AppEvent {
  const AppOnEvaluationCreatedEvent(this.evaluation);

  final Evaluation evaluation;
}
