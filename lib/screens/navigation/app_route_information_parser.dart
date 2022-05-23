import 'package:flutter/material.dart';
import 'package:movie_app_exercise/data/models/movie.dart';
import 'package:movie_app_exercise/screens/navigation/app_config.dart';

class AppRouteInformationParser extends RouteInformationParser<AppConfig> {
  @override
  Future<AppConfig> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '/');
    // Handle '/' and '/home'
    if (uri.pathSegments.isEmpty ||
        (uri.pathSegments.length == 1 &&
            uri.pathSegments[0] == AppConfig.home().uri.pathSegments[0])) {
      return AppConfig.home();
    }

    // Handle '/movie'
    if (uri.pathSegments.length == 1 &&
        uri.pathSegments[0] == AppConfig.movie().uri.pathSegments[0]) {
      return AppConfig.movie();
    }

    // Handle '/movie/:id'
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] == AppConfig.movie().uri.pathSegments[0]) {
        var id = uri.pathSegments[1];
        return AppConfig.movieDetail(Movie(id: id));
      }
    }

    // Handle unknown/invalid routes
    return AppConfig.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(AppConfig configuration) {
    if (configuration.isUnknown) {
      return RouteInformation(location: AppConfig.unknown().uri.path);
    }
    if (configuration.isHomePage) {
      return RouteInformation(location: AppConfig.home().uri.path);
    }
    if (configuration.isMoviePage) {
      return RouteInformation(location: AppConfig.movie().uri.path);
    }
    if (configuration.isMovieDetailPage) {
      return RouteInformation(
          location: AppConfig.movieDetail(configuration.movie).uri.path);
    }
    return null;
  }
}
