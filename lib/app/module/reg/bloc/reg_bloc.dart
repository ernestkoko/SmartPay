import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:smartpay/app/module/reg/bloc/reg_provider.dart';
import 'package:smartpay/app/util/extension.dart';

part 'reg_event.dart';

part 'reg_state.dart';

enum RegPageState { reg, verify, details, pin, registered }

class RegBloc extends Bloc<RegEvent, RegState> with RegProvider {
  RegBloc() : super(RegInitState()) {
    on<OnInitRegEvent>(_onInit);
    on<OnAddCodeRegEvent>(_onInputChanged);
    on<OnRemoveCodeRegEvent>(_onRemoved);
    on<OnRegPageChangedEvent>(_onPageChanged);
  }

  final List<int> _codeList = [];
  final List<int> _pinList = [];

  RegPageState _regPageState = RegPageState.reg;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegPageState get regPageState => _regPageState;

  List<int> get codeList => _codeList;

  List<int> get pinList => _pinList;

  Future _onInit(OnInitRegEvent event, Emitter<RegState> emit) async {
    _regPageState = RegPageState.reg;
  }

  Future _onInputChanged(
      OnAddCodeRegEvent event, Emitter<RegState> emit) async {
    emit(RegCodeAddedState());
    if (event.value != null) {
      if (_codeList.length <= 4) {
        _codeList.insert(_codeList.length, event.value!);
      }
    }
    if (event.pin != null) {
      if (_pinList.length <= 4) {
        _pinList.insert(_pinList.length, event.pin!);
      }
    }

    emit(RegCodeAddedState(success: true));
  }

  FutureOr<void> _onRemoved(
      OnRemoveCodeRegEvent event, Emitter<RegState> emit) async {
    emit(RegCodeAddedState());
    if (event.page == RegPageState.verify && _codeList.isNotEmpty) {
      _codeList.removeLast();
    }
    if (event.page == RegPageState.pin && _pinList.isNotEmpty) {
      _pinList.removeLast();
    }
    emit(RegCodeAddedState(success: true));
  }

  FutureOr<void> _onPageChanged(
      OnRegPageChangedEvent event, Emitter<RegState> emit) async {
    try {
      emit(RegLoadingState(loading: true));
      if (_regPageState == RegPageState.reg && !event.backward) {
        //get token
        final data = await getEmailToken(email: emailController.text);
        _codeList.clear();
        _codeList.insertAll(
          0,
          data.data!.token!.getIntArray(),
        );
      } else if (_regPageState == RegPageState.verify && !event.backward) {
        final data = await verifyEmailToken(
            email: emailController.text, token: _codeList.getStringOfValues());
      } else if (_regPageState == RegPageState.details && !event.backward) {
        _pinList.clear();
        _pinList.insertAll(0, [..._codeList]);
      } else if (_regPageState == RegPageState.pin && !event.backward) {
        await register(
          name: nameController.text,
          email: emailController.text,
          country: countryController.text,
          password: passwordController.text,
        );
      }
      log(_pinList.toString());

      _regPageState = event.page;
      emit(RegPageChangesState(page: event.page, showSnack: !event.backward));
    } on HttpException catch (e) {
      emit(RegErrorState(message: e.message));
    } on ClientException catch (e) {
      emit(RegErrorState(message: 'Please check your internet connectivity'));
    } catch (_) {
      emit(RegErrorState());
    } finally {
      emit(RegLoadingState(loading: false));
    }
  }
}
