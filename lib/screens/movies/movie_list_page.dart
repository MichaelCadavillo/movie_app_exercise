import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_exercise/bloc/movie/movie_cubit.dart';
import 'package:movie_app_exercise/bloc/navigation/navigation_cubit.dart';
import 'package:movie_app_exercise/data/models/movie.dart';
import 'package:movie_app_exercise/screens/common/app_scaffold.dart';
import 'package:movie_app_exercise/screens/movies/movie_item_card.dart';
import 'package:movie_app_exercise/screens/navigation/app_config.dart';
import 'package:movie_app_exercise/utility/screen_utils.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  List<Movie> movieList = [];

  @override
  void initState() {
    BlocProvider.of<MovieCubit>(context).fetchMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function hp = ScreenUtils(MediaQuery.of(context)).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context)).wp;
    return Title(
      title: "Movie List",
      color: Colors.black,
      child: AppScaffold(
        titleText: "MOVIES",
        hasDrawer: false,
        hasRefreshButton: true,
        onRefresh: () {
          BlocProvider.of<MovieCubit>(context).reloadMovies();
        },
        body: BlocBuilder<MovieCubit, MovieState>(builder: (context, state) {
          bool isSaving = false;
          bool failedSaving = false;
          if (state is SuccessFetchingMoviesState) {
            movieList.clear();
            movieList.addAll(state.movies);
          } else if (state is FailedFetchingMoviesState) {
            return Center(
              child: Text(
                "${state.errorMessage}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 20),
              ),
            );
          } else if (state is FetchingMoviesState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReloadingMoviesState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FailedSavingMovieDetailsState) {
            failedSaving = true;
            // Update the selected Index
            int selectedMovieIndex =
                movieList.indexWhere((element) => state.movie.id == element.id);
            movieList[selectedMovieIndex] = state.movie;
          } else if (state is SavingMovieDetailsState) {
            isSaving = true;
            // Update the selected Index
            int selectedMovieIndex =
                movieList.indexWhere((element) => state.movie.id == element.id);
            movieList[selectedMovieIndex] = state.movie;
          } else if (state is SuccessSavingMovieDetailsState) {
            // Update the selected Index
            int selectedMovieIndex = movieList
                .indexWhere((element) => state.updatedMovie.id == element.id);
            movieList[selectedMovieIndex] = state.updatedMovie;
          }
          return ListView.builder(
              itemCount: movieList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  width: wp(100),
                  margin:
                      EdgeInsets.symmetric(vertical: hp(1), horizontal: wp(2)),
                  child: InkWell(
                      onTap: () {
                        BlocProvider.of<NavigationCubit>(context).navigateTo(
                            AppConfig.movieDetail(movieList[index]));
                      },
                      child: MovieItemCard(
                          key: ValueKey(movieList[index].id),
                          movie: movieList[index],
                          onFavoriteButtonTap: () {
                            Movie updatedMovie = movieList[index].copyWith(
                                isFavorite: !movieList[index].isFavorite);
                            BlocProvider.of<MovieCubit>(context)
                                .saveMovieDetails(movie: updatedMovie);
                          },
                          isSaving: isSaving,
                          failedSaving: failedSaving)),
                );
              });
        }),
      ),
    );
  }
}
