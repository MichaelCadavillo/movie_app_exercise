part of 'movie_cubit.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object?> get props => [];
}

class InitialMovieState extends MovieState {}

// Fetch Movies States
class FetchingMoviesState extends MovieState {}

class SuccessFetchingMoviesState extends MovieState {
  final List<Movie> movies;
  final int? pageKey;
  final bool? isLastPage;

  const SuccessFetchingMoviesState(this.movies,
      {this.pageKey, this.isLastPage});
}

// Reload Movies State
class ReloadingMoviesState extends MovieState {}

class FailedFetchingMoviesState extends MovieState {
  final String? errorMessage;

  const FailedFetchingMoviesState({this.errorMessage});
}

// Fetch Movie Details States
class FetchingMovieDetailsState extends MovieState {}

class MovieDetailsNotFoundState extends MovieState {}

class SuccessFetchingMovieDetailsState extends MovieState {
  final Movie movie;

  const SuccessFetchingMovieDetailsState(this.movie);
}

class FailedFetchingMovieDetailsState extends MovieState {
  final String? errorMessage;

  const FailedFetchingMovieDetailsState({this.errorMessage});
}

// Save Movie Details States
class SavingMovieDetailsState extends MovieState {
  final Movie movie;

  const SavingMovieDetailsState(this.movie);
}

class SuccessSavingMovieDetailsState extends MovieState {
  final Movie updatedMovie;

  const SuccessSavingMovieDetailsState(this.updatedMovie);
}

class FailedSavingMovieDetailsState extends MovieState {
  final String? errorMessage;
  final Movie movie;

  const FailedSavingMovieDetailsState(this.movie, {this.errorMessage});
}
