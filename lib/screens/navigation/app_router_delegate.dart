import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_exercise/bloc/movie/movie_cubit.dart';
import 'package:movie_app_exercise/bloc/navigation/navigation_cubit.dart';
import 'package:movie_app_exercise/screens/error_page.dart';
import 'package:movie_app_exercise/screens/home/home_page.dart';
import 'package:movie_app_exercise/screens/movies/movie_details_page.dart';
import 'package:movie_app_exercise/screens/movies/movie_list_page.dart';
import 'package:movie_app_exercise/screens/navigation/app_config.dart';

class AppRouterDelegate extends RouterDelegate<AppConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppConfig> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppConfig currentState = AppConfig.home();

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  AppConfig get currentConfiguration {
    if (currentState.uri == AppConfig.unknown().uri &&
        currentState.isUnknown == false) {
      // Return to home page when coming from unknown page
      currentState = AppConfig.home();
    }

    return currentState;
  }

  List<Page<dynamic>> buildPages() {
    List<Page<dynamic>> pages = [];
    pages.add(
      MaterialPage(
          key: ValueKey("HomePage-${currentState.isHomePage}"),
          child: const HomePage()),
    );

    if (currentState.uri.pathSegments[0] ==
        AppConfig.movie().uri.pathSegments[0]) {
      if (currentState.movie?.id != null) {
        pages.add(
          MaterialPage(
              key: ValueKey(
                  'MovieListPageId' + currentState.movie!.id.toString()),
              child: BlocProvider<MovieCubit>(
                  create: (BuildContext context) => MovieCubit(),
                  child: MovieDetailsPage(
                    id: currentState.movie?.id ?? '',
                  ))),
        );
      } else {
        pages.add(
          MaterialPage(
              child: BlocProvider<MovieCubit>(
                  create: (BuildContext context) => MovieCubit(),
                  child: const MovieListPage())),
        );
      }
    }
    if (currentState.isUnknown) {
      pages.add(
          const MaterialPage(key: ValueKey('UnknownPage'), child: ErrorPage()));
    }
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationCubit, NavigationState>(
      listener: (context, state) {
        if (state is NavigationSuccessState) {
          // Handle navigation changes to/from different screens
          currentState = state.newState;

          notifyListeners();
        }
      },
      child: Title(
        title: "Home Page",
        color: Colors.black,
        child: Navigator(
          key: navigatorKey,
          //transitionDelegate: AnimationTransitionDelegate(),
          pages: buildPages(),
          onPopPage: (route, result) {
            if (!route.didPop(result)) {
              return false;
            } else if (currentState.uri.pathSegments[0] ==
                AppConfig.home().uri.pathSegments[0]) {
              currentState = AppConfig.home();
            } else if (currentState.uri.pathSegments[0] ==
                    AppConfig.movie().uri.pathSegments[0] &&
                currentState.movie?.id != null) {
              currentState = AppConfig.movie();
            } else {
              currentState = AppConfig.unknown();
            }
            currentState.isUnknown = false;
            notifyListeners();
            return true;
          },
        ),
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(AppConfig configuration) async {
    currentState = configuration;
    return;
  }
}
