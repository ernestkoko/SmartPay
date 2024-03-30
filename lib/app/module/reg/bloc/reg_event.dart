part of 'reg_bloc.dart';

abstract class RegEvent extends Equatable {}

class OnInitRegEvent extends RegEvent {
  @override
  List<Object?> get props => [];
}

class OnAddCodeRegEvent extends RegEvent {
  OnAddCodeRegEvent({
    this.value,
    this.pin,
  });

  final int? value;
  final int? pin;

  @override
  List<Object?> get props => [value, pin];
}

class OnRemoveCodeRegEvent extends RegEvent {
  OnRemoveCodeRegEvent({required this.page});
  final RegPageState page;
  @override
  List<Object?> get props => [page];
}

class OnRegPageChangedEvent extends RegEvent {
  OnRegPageChangedEvent({required this.page, this.backward = false});

  final RegPageState page;
  final bool backward;

  @override
  List<Object?> get props => [page,backward];
}
