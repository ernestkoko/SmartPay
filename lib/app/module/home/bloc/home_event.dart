part of 'home_bloc.dart';
abstract class HomeEvent extends Equatable{}
class OnInitHomeEvent extends HomeEvent{
  @override

  List<Object?> get props => [];

}
class OnDashboardHomeEvent extends HomeEvent{
  OnDashboardHomeEvent({required this.token});
  final String token;
  @override

  List<Object?> get props => [token];

}