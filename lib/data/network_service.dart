import 'package:dio/dio.dart';
import 'package:movie_app_exercise/data/secrets.dart';
import 'package:movie_app_exercise/utility/string_util.dart';

/// Contains the service for connecting to an endpoint (REST/GraphQL). and managing the applicable queries/mutations.
class NetworkService {
  Dio? _dio;

  NetworkService() {
    _dio = Dio(BaseOptions(
        baseUrl: "https://api.themoviedb.org/3",
        queryParameters: {"api_key": apiKey}));
  }

  Future<Map<String, dynamic>> fetchMovies({int? page}) async {
    _dio?.options.queryParameters.addAll({"page": page ?? 1});

    // Fetch list of movies (Now Playing list)
    Response<Map<String, dynamic>>? response =
        await _dio?.get("/movie/now_playing");

    if (response != null && response.data != null) {
      return response.data!;
    } else {
      return {};
    }
  }

  Future<Map<String, dynamic>?> fetchMovie({required String id}) async {
    Response<Map<String, dynamic>>? response = await _dio?.get("/movie/$id");

    if (response != null && response.data != null) {
      // Append the image url domain to the poster_path and backdrop_path
      if (StringUtil.isNotEmpty(response.data!['poster_path'])) {
        response.data!['poster_path'] =
            'https://image.tmdb.org/t/p/w1280' + response.data!['poster_path'];
      }
      if (StringUtil.isNotEmpty(response.data!['backdrop_path'])) {
        response.data!['backdrop_path'] = 'https://image.tmdb.org/t/p/w1280' +
            response.data!['backdrop_path'];
      }

      return response.data!;
    } else {
      return {};
    }
  }

  Future<Map<String, dynamic>?> saveMovie(
      {Map<String, dynamic>? variables}) async {
    throw UnimplementedError("Not yet implemented!");
  }
}
