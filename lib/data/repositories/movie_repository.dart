import 'package:movie_app_exercise/data/builder/movie_builder.dart';
import 'package:movie_app_exercise/data/exceptions/api_call_exception.dart';
import 'package:movie_app_exercise/data/models/movies.dart';
import 'package:movie_app_exercise/data/network_service.dart';

class MovieRepository {
  Future<List<Movie>> fetchAllMovies({bool? isShuffle = false}) async {
    List<Movie> movies = [];

    Map<String, dynamic> response =
        await NetworkService().fetchMovies(variables: {"isShuffle": isShuffle});

    // Check if response is null.
    // If not, try to parse it and add to [movies] list.
    // else, throw an error
    if (response['data'] != null) {
      List moviesResponseList = response['data'] as List;
      for (var movie in moviesResponseList) {
        movies.add(MovieBuilder().mapNetworkToDart(movie));
      }
    } else {
      throw ApiCallException(
          displayMessage:
              "An Error occurred while fetching movies.\nPlease try again later!");
    }

    return movies;
  }

  Future<Movie> fetchSingleMovie({required String id}) async {
    Map<String, dynamic>? response =
        await NetworkService().fetchMovie(variables: {'id': id});

    // Check if response is null.
    // If not, try to parse it and then return the value.
    // else, throw an error
    if (response != null) {
      return MovieBuilder().mapNetworkToDart(response);
    } else {
      throw ApiCallException(
          displayMessage:
              "An Error occurred while fetching movies.\nPlease try again later!");
    }
  }

  Future<Movie> saveMovie(Movie movie) async {
    Map<String, dynamic>? response = await NetworkService()
        .saveMovie(variables: MovieBuilder().mapToNetwork(movie));

    // Check if response is null.
    // If not, try to parse it and then return the value.
    // else, throw an error
    if (response != null) {
      return MovieBuilder().mapNetworkToDart(response);
    } else {
      throw ApiCallException(
          displayMessage:
              "An Error occurred while saving the movie.\nPlease try again later!");
    }
  }
}
