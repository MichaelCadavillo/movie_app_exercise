import 'package:movie_app_exercise/data/models/movie.dart';

class AppConfig {
  Uri uri;
  Movie? movie;
  bool isUnknown = false;

  AppConfig.home() : uri = Uri(path: "/home");

  AppConfig.movie()
      : uri = Uri(path: "/movie"),
        movie = null;

  AppConfig.movieDetail(this.movie)
      : uri = Uri(path: "/movie/${movie?.id.toString()}");

  AppConfig.unknown()
      : uri = Uri(path: "/unknown"),
        movie = null,
        isUnknown = true;

  bool get isMoviePage => (uri == AppConfig.movie().uri);

  bool get isHomePage => (uri == AppConfig.home().uri);

  bool get isMovieDetailPage => (movie != null);

  @override
  String toString() {
    return "AppConfig{ current URI Path : ${uri.path}, id : ${movie?.id}}";
  }
}
