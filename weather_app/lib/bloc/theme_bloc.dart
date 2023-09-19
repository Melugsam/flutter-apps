import 'package:flutter_bloc/flutter_bloc.dart';

// События
enum ThemeSwitchEvent { toggle }

// Состояния
class ThemeSwitchState {
  final bool value;

  ThemeSwitchState(this.value);
}

// BLoC
class ThemeBloc extends Bloc<ThemeSwitchEvent, ThemeSwitchState> {
  ThemeBloc() : super(ThemeSwitchState(false));

  @override
  Stream<ThemeSwitchState> mapEventToState(ThemeSwitchEvent event) async* {
    if (event == ThemeSwitchEvent.toggle) {
      yield ThemeSwitchState(!state.value ? true : false ? true : false);
    }
  }
}
