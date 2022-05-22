import 'package:movie_app_exercise/data/builder/base_builder.dart';
import 'package:movie_app_exercise/data/models/movie.dart';

class MovieBuilder extends Builder<Movie> {
  @override
  Movie mapNetworkToDart(Map<String, dynamic> map) {
    return Movie(
        id: "${map['id']}",
        title: map['original_title'],
        description: map['overview'],
        imagePath: map['poster_path'],
        backdropPath: map['backdrop_path']);
  }

  @override
  Map<String, dynamic> mapToNetwork(Movie movie) {
    final Map<String, dynamic> request = {};
    request['id'] = movie.id;
    request['original_title'] = movie.title;
    request['overview'] = movie.description;
    request['poster_path'] = movie.imagePath;
    request['backdrop_path'] = movie.backdropPath;

    return request;
  }
}
