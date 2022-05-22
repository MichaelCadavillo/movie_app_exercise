import 'package:movie_app_exercise/data/builder/base_builder.dart';
import 'package:movie_app_exercise/data/models/movies.dart';

class MovieBuilder extends Builder<Movie> {
  @override
  Movie mapNetworkToDart(Map<String, dynamic> map) {
    return Movie(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        imagePath: map['imagePath'],
        isFavorite: map['isFavorite'] == "true" ? true : false);
  }

  @override
  Map<String, dynamic> mapToNetwork(Movie movie) {
    final Map<String, dynamic> request = {};
    request['id'] = movie.id;
    request['title'] = movie.title;
    request['description'] = movie.description;
    request['imagePath'] = movie.imagePath;
    request['isFavorite'] = movie.isFavorite.toString();

    return request;
  }
}
