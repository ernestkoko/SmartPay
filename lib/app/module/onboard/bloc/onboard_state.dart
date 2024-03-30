part of 'onboard_bloc.dart';
abstract class OnboardState extends Equatable{}
class  OnboardInitState extends OnboardState{
  @override

  List<Object?> get props =>[];
}
class  OnboardMoveState extends OnboardState{
  OnboardMoveState({required this.pageState});
  final OnboardPageState pageState;
  @override

  List<Object?> get props =>[pageState];
}