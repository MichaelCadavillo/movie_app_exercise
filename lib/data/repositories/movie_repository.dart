import 'package:dio/dio.dart';
import 'package:movie_app_exercise/data/builder/movie_builder.dart';
import 'package:movie_app_exercise/data/exceptions/api_call_exception.dart';
import 'package:movie_app_exercise/data/exceptions/invalid_id_exception.dart';
import 'package:movie_app_exercise/data/models/movie.dart';
import 'package:movie_app_exercise/data/network_service.dart';
import 'package:movie_app_exercise/utility/string_util.dart';

class MovieRepository {
  Future<List<Movie>> fetchAllMovies({int page = 0}) async {
    List<Movie> movies = [];

    Map<String, dynamic> response =
        await NetworkService().fetchMovies(page: page);

    // Check if response is null.
    // If not, try to parse it and add to [movies] list.
    // else, throw an error
    if (response['results'] != null) {
      List moviesResponseList = response['results'] as List;
      for (var movie in moviesResponseList) {
        // Append the image url domain to the poster_path
        if (StringUtil.isNotEmpty(movie['poster_path'])) {
          movie['poster_path'] =
              'https://image.tmdb.org/t/p/w1280' + movie['poster_path'];
        }

        if (StringUtil.isNotEmpty(movie['backdrop_path'])) {
          movie['backdrop_path'] =
              'https://image.tmdb.org/t/p/w1280' + movie['backdrop_path'];
        }
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
    try {
      Map<String, dynamic>? response =
          await NetworkService().fetchMovie(id: id);

      // Check if response is null.
      // If not, try to parse it and then return the value.
      // else, throw an error
      if (response != null) {
        return MovieBuilder().mapNetworkToDart(response);
      }
    } catch (e) {
      if (e is DioError && e.response?.data?['status_code'] == 34) {
        throw InvalidIdException(
            displayMessage: "Requested movie is not found!");
      }
    }

    // throw error if not found
    throw ApiCallException(
        displayMessage:
            "An Error occurred while fetching movies.\nPlease try again later!");
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
