import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import './login_provider.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with LoginProvider {
  LoginBloc() : super(LoginInitState()) {
    on<OnInitLoginEvent>(_onInit);
    on<OnLoginEvent>(_onLogin);
    on<OnLoginFieldChangedEvent>(_onLoginFieldChanged);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future _onInit(OnInitLoginEvent event, Emitter<LoginState> emit) async {}

  FutureOr<void> _onLogin(OnLoginEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoadingState(loading: true));
      final res = await login(
        email: emailController.text,
        password: passwordController.text,
      );

      emit(LoginSuccessState(token: res.data!.token!));
    } on HttpException catch (e) {
      emit(LoginErrorState(message: e.message));
    } on ClientException catch (_) {
      emit(
          LoginErrorState(message: "Please check your internet connectivity."));
    } catch (e) {
      emit(LoginErrorState());
    } finally {
      emit(LoginLoadingState(loading: false));
    }
  }

  FutureOr<void> _onLoginFieldChanged(
      OnLoginFieldChangedEvent event, Emitter<LoginState> emit) {
    emit(LoginInitState());
    emit(LoginLoadingState());
  }
}
