part of 'home_bloc.dart';

abstract class HomeState extends Equatable {}

class HomeInitState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {
  HomeLoadingState({this.loading = false});

  final bool loading;

  @override
  List<Object?> get props => [loading];
}

class HomeErrorState extends HomeState {
  HomeErrorState({this.message = 'A glitch occurred. Please try again later'});

  final String message;

  @override
  List<Object?> get props => [message];
}
