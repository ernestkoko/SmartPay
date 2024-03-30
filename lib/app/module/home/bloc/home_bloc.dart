import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitState()) {
    on<OnInitHomeEvent>(_onInit);
  }

  Future _onInit(OnInitHomeEvent event, Emitter<HomeState> emit) async {}
}
