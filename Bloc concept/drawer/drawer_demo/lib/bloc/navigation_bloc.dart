// navigation_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(HomePageState()) {
    on<NavigateToHome>((event, emit) => emit(HomePageState()));
    on<NavigateToSettings>((event, emit) => emit(SettingsPageState()));
    on<NavigateToAbout>((event, emit) => emit(AboutPageState()));
  }
}
