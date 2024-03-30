part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

class OnInitLoginEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class OnLoginEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}
class OnLoginFieldChangedEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}
