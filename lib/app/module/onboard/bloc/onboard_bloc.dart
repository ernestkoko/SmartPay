import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboard_event.dart';

part 'onboard_state.dart';

enum OnboardPageState {
  one,
  two,
}

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  OnboardBloc() : super(OnboardInitState()) {
    on<OnInitOnboardEvent>(_onInit);
    on<OnNextOnboardEvent>(_onNext);
  }

  OnboardPageState _pageState = OnboardPageState.one;

  OnboardPageState get pageState => _pageState;

  FutureOr<void> _onInit(
      OnInitOnboardEvent event, Emitter<OnboardState> emit) {}

  FutureOr<void> _onNext(OnNextOnboardEvent event, Emitter<OnboardState> emit) {
    _pageState = OnboardPageState.two;

    emit(OnboardMoveState(pageState: pageState));
  }
}
