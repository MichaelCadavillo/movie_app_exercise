import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_exercise/data/exceptions/api_call_exception.dart';
import 'package:movie_app_exercise/data/exceptions/invalid_id_exception.dart';
import 'package:movie_app_exercise/data/models/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app_exercise/data/repositories/movie_repository.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(InitialMovieState());

  Future<void> fetchMovies({int page = 1}) async {
    emit(FetchingMoviesState());

    await _fetchMovies(page: page);
  }

  Future<void> reloadMovies() async {
    emit(ReloadingMoviesState());

    await _fetchMovies();
  }

  Future<void> _fetchMovies({int page = 1}) async {
    try {
      List<Movie> movies = await MovieRepository().fetchAllMovies(page: page);

      // Hardcoded to show only up to 2 pages.
      // Adjust as necessary
      bool isLastPage = (page == 2) ? true : false;

      emit(SuccessFetchingMoviesState(movies,
          pageKey: page, isLastPage: isLastPage));
    } on ApiCallException catch (e, stk) {
      debugPrint("ERROR: $e, $stk");
      // Return error message from API
      emit(FailedFetchingMoviesState(errorMessage: e.displayMessage));
    } catch (e, stk) {
      debugPrint("ERROR: $e, $stk");
      // Return generic error message
      emit(const FailedFetchingMoviesState(errorMessage: "An Error Occurred!"));
    }
  }

  Future<void> fetchMovieDetails({required String id}) async {
    emit(FetchingMovieDetailsState());

    try {
      Movie movie = await MovieRepository().fetchSingleMovie(id: id);

      emit(SuccessFetchingMovieDetailsState(movie));
    } on ApiCallException catch (e) {
      // Return error message from API
      emit(FailedFetchingMovieDetailsState(errorMessage: e.displayMessage));
    } on InvalidIdException catch (e) {
      // Requested ID Not Found
      emit(MovieDetailsNotFoundState());
    } catch (e, stk) {
      debugPrint("ERROR: $e, $stk");
      // Return generic error message
      emit(FailedFetchingMovieDetailsState(errorMessage: "An Error Occurred!"));
    }
  }

  Future<void> saveMovieDetails({required Movie movie}) async {
    emit(SavingMovieDetailsState(movie));

    try {
      Movie updatedMovie = await MovieRepository().saveMovie(movie);

      emit(SuccessSavingMovieDetailsState(updatedMovie));
    } on ApiCallException catch (e) {
      // Return error message from API
      emit(
          FailedSavingMovieDetailsState(movie, errorMessage: e.displayMessage));
    } catch (e) {
      // Return generic error message
      emit(FailedSavingMovieDetailsState(movie,
          errorMessage: "An Error Occurred!"));
    }
  }
}
