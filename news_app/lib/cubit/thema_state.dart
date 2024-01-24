part of 'thema_cubit.dart';

@immutable
abstract class ThemeState {
  const ThemeState();
}

class ThemeInitialState extends ThemeState {
  const ThemeInitialState();
}

class ThemeChangeState extends ThemeState {
  ThemeChangeState();
}
