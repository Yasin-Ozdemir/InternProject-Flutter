import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'thema_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitialState());

  bool _isLight = true;

  bool get isLight => _isLight;

  void changeTheme() {
    _isLight = !_isLight;
    emit(ThemeChangeState());
  }
}
