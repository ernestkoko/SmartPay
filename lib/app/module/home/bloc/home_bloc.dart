import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartpay/app/module/home/bloc/home_provider.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> with HomeProvider {
  HomeBloc() : super(HomeInitState()) {
    on<OnInitHomeEvent>(_onInit);
    on<OnDashboardHomeEvent>(_onDashboard);
  }

  String _secret = '';
  int _click = 0;

  int get click => _click;

  String get secret => _secret;

  Future _onInit(OnInitHomeEvent event, Emitter<HomeState> emit) async {
    _click++;
    if (_click == 3) {
      emit(HomeInitState());
    }
  }

  FutureOr<void> _onDashboard(
      OnDashboardHomeEvent event, Emitter<HomeState> emit) async {
    _click = 0;
    try {
      emit(HomeLoadingState(loading: true));
      final secret = await dashboard(token: event.token);
      _secret = secret;
    } on HttpException catch (e) {
      emit(HomeErrorState(message: e.message));
    } catch (e) {
      emit(HomeErrorState());
    } finally {
      emit(HomeLoadingState(loading: false));
    }
  }
}
