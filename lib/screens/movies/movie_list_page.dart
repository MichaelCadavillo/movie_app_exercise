import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app_exercise/bloc/movie/movie_cubit.dart';
import 'package:movie_app_exercise/bloc/navigation/navigation_cubit.dart';
import 'package:movie_app_exercise/data/models/movie.dart';
import 'package:movie_app_exercise/screens/common/app_scaffold.dart';
import 'package:movie_app_exercise/screens/movies/movie_item_card.dart';
import 'package:movie_app_exercise/screens/navigation/app_config.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  List<Movie> movieList = [];
  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      BlocProvider.of<MovieCubit>(context).fetchMovies(page: pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _handlePaginationItems(
      {required List<Movie> newMovieItems,
      required bool isLastPage,
      required int pageKey}) async {
    try {
      if (isLastPage) {
        _pagingController.appendLastPage(newMovieItems);
      } else {
        pageKey++;
        _pagingController.appendPage(newMovieItems, pageKey);
      }
      movieList.addAll(newMovieItems);
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieCubit, MovieState>(
      listener: (context, state) {
        if (state is SuccessFetchingMoviesState) {
          _handlePaginationItems(
              newMovieItems: state.movies,
              pageKey: state.pageKey ?? 1,
              isLastPage: state.isLastPage ?? true);
        }
      },
      child: Title(
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
            } else if (state is FailedFetchingMoviesState) {
              return Center(
                child: Text(
                  "${state.errorMessage}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 20),
                ),
              );
            } else if (state is ReloadingMoviesState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FailedSavingMovieDetailsState) {
              failedSaving = true;
              // Update the selected Index
              int selectedMovieIndex = movieList
                  .indexWhere((element) => state.movie.id == element.id);
              movieList[selectedMovieIndex] = state.movie;
            } else if (state is SavingMovieDetailsState) {
              isSaving = true;
              // Update the selected Index
              int selectedMovieIndex = movieList
                  .indexWhere((element) => state.movie.id == element.id);
              movieList[selectedMovieIndex] = state.movie;
            } else if (state is SuccessSavingMovieDetailsState) {
              // Update the selected Index
              int selectedMovieIndex = movieList
                  .indexWhere((element) => state.updatedMovie.id == element.id);
              movieList[selectedMovieIndex] = state.updatedMovie;
            }
            return PagedListView<int, Movie>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Movie>(
                  itemBuilder: (context, item, index) => InkWell(
                        onTap: () {
                          BlocProvider.of<NavigationCubit>(context).navigateTo(
                              AppConfig.movieDetail(movieList[index]));
                        },
                        child: MovieItemCard(
                            key: ValueKey(movieList[index].id),
                            movie: movieList[index],
                            onRateButtonTap: () {
                              // TODO: Implement rate movie functionality

                              // Movie updatedMovie = movieList[index].copyWith(
                              //     rating: movieList[index].rating);
                              // BlocProvider.of<MovieCubit>(context)
                              //     .saveMovieDetails(movie: updatedMovie);
                            },
                            isSaving: isSaving,
                            failedSaving: failedSaving),
                      )),
            );
          }),
        ),
      ),
    );
  }
}
