part of 'navigation_cubit.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object?> get props => [];
}

class InitialNavigationState extends NavigationState {}

class NavigationSuccessState extends NavigationState {
  final AppConfig newState;

  const NavigationSuccessState(this.newState);
}

class NavigationFailedState extends NavigationState {}

class NavigatingState extends NavigationState {}
