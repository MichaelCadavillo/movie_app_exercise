import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_exercise/data/exceptions/api_call_exception.dart';
import 'package:movie_app_exercise/data/exceptions/invalid_id_exception.dart';
import 'package:movie_app_exercise/data/models/movies.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app_exercise/data/repositories/movie_repository.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(InitialMovieState());

  Future<void> fetchMovies() async {
    emit(FetchingMoviesState());

    await _fetchMovies();
  }

  Future<void> reloadMovies() async {
    emit(ReloadingMoviesState());

    await _fetchMovies(isShuffle: true);
  }

  Future<void> _fetchMovies({bool? isShuffle = false}) async {
    try {
      List<Movie> movies =
          await MovieRepository().fetchAllMovies(isShuffle: isShuffle);

      emit(SuccessFetchingMoviesState(movies));
    } on ApiCallException catch (e) {
      // Return error message from API
      emit(FailedFetchingMoviesState(errorMessage: e.displayMessage));
    } catch (e) {
      // Return generic error message
      emit(FailedFetchingMoviesState(errorMessage: "An Error Occurred!\n$e"));
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
    } catch (e) {
      // Return generic error message
      emit(FailedFetchingMovieDetailsState(
          errorMessage: "An Error Occurred!\n$e"));
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
