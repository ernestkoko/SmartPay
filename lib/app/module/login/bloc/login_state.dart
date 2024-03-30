part of 'login_bloc.dart';

abstract class LoginState extends Equatable {}

class LoginInitState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginState {
  LoginSuccessState({required this.token});
  final String token;
  @override
  List<Object?> get props => [token];
}

class LoginErrorState extends LoginState {
  LoginErrorState({this.message = "A glitch occurred! Try again later."});

  final String message;

  @override
  List<Object?> get props => [message];
}

class LoginLoadingState extends LoginState {
  LoginLoadingState({
    this.loading = false,
  });

  final bool loading;

  @override
  List<Object?> get props => [loading];
}
