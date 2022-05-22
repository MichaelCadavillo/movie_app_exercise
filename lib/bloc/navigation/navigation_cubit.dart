import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app_exercise/screens/navigation/app_config.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(InitialNavigationState());

  Future<void> navigateTo(AppConfig page) async {
    emit(NavigatingState());
    emit(NavigationSuccessState(page));
  }
}
