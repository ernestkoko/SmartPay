part of 'reg_bloc.dart';

abstract class RegState extends Equatable {}

class RegInitState extends RegState {
  @override
  List<Object?> get props => [];
}

class RegCodeAddedState extends RegState {
  RegCodeAddedState({this.success = false});

  final bool success;

  @override
  List<Object?> get props => [success];
}

class RegLoadingState extends RegState {
  RegLoadingState({this.loading = false});

  final bool loading;

  @override
  List<Object?> get props => [loading];
}

class RegErrorState extends RegState {
  RegErrorState({this.message = 'A glitch occurred! Try again later'});

  final String message;

  @override
  List<Object?> get props => [message];
}

class RegPageChangesState extends RegState {
  RegPageChangesState({required this.page, this.showSnack = false,});

  final RegPageState page;
  final bool showSnack;

  @override
  List<Object?> get props => [page,showSnack];
}
