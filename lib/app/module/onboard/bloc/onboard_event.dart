part of 'onboard_bloc.dart';

abstract class OnboardEvent extends Equatable {}

class OnInitOnboardEvent extends OnboardEvent {
  @override
  List<Object?> get props => [];
}
class OnNextOnboardEvent extends OnboardEvent {
  OnNextOnboardEvent({required this.pageState});
  final  OnboardPageState pageState;
  @override
  List<Object?> get props => [pageState];
}
