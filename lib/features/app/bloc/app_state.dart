part of 'app_bloc.dart';

sealed class AppState extends Equatable {}

class AppLoadingState extends AppState {
  @override
  List<Object?> get props => [];
}

class AppSuccessState extends AppState {
  AppSuccessState({
    required this.users,
    required this.contrahents,
  });

  final List<User> users;
  final List<Contrahent> contrahents;

  @override
  List<Object?> get props => [users, contrahents];
}

class AppErrorState extends AppState {
  AppErrorState({required this.message});

  final String message;

  @override
  List<Object?> get props => [];
}
