import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_exercise/bloc/movie/movie_cubit.dart';
import 'package:movie_app_exercise/bloc/navigation/navigation_cubit.dart';
import 'package:movie_app_exercise/data/models/movie.dart';
import 'package:movie_app_exercise/screens/common/app_scaffold.dart';
import 'package:movie_app_exercise/screens/navigation/app_config.dart';
import 'package:movie_app_exercise/utility/screen_utils.dart';
import 'package:movie_app_exercise/utility/string_util.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  String pageTitle = 'Movie Details Page';
  @override
  void initState() {
    BlocProvider.of<MovieCubit>(context).fetchMovieDetails(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDeviceTablet = ScreenUtils(MediaQuery.of(context)).isDeviceTablet();
    final Function hp = ScreenUtils(MediaQuery.of(context)).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context)).wp;
    return BlocListener<MovieCubit, MovieState>(
        listener: (context, state) {
          if (state is SuccessFetchingMovieDetailsState) {
            // Update browser title based from movie title
            pageTitle = state.movie.title ?? '';
            setState(() {});
          }
        },
        child: Title(
          title: pageTitle,
          color: Colors.black,
          child: AppScaffold(
              titleText: "MOVIE INFO",
              hasDrawer: false,
              body: BlocBuilder<MovieCubit, MovieState>(
                  builder: (context, state) {
                Movie? movie;
                bool isSaving = false;
                bool failedSaving = false;
                if (state is FetchingMovieDetailsState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FailedFetchingMovieDetailsState) {
                  return Center(
                    child: Text(
                      "${state.errorMessage}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  );
                } else if (state is MovieDetailsNotFoundState) {
                  // Navigate to 404 not found page
                  BlocProvider.of<NavigationCubit>(context)
                      .navigateTo(AppConfig.unknown());
                  return const Center(
                      child: Text(
                    "This Movie is not found on our server",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ));
                } else if (state is SuccessFetchingMovieDetailsState) {
                  movie = state.movie;
                } else if (state is FailedSavingMovieDetailsState) {
                  movie = state.movie;
                  failedSaving = true;
                } else if (state is SavingMovieDetailsState) {
                  isSaving = true;
                  movie = state.movie;
                } else if (state is SuccessSavingMovieDetailsState) {
                  movie = state.updatedMovie;
                }
                return Stack(
                  children: [
                    Column(
                      children: [
                        _blurredImageWidget(movie?.backdropPath),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: isDeviceTablet ? wp(7) : wp(8),
                          ),
                          child: Row(
                            children: [
                              // Left Spacing for image
                              SizedBox(
                                  width: isDeviceTablet ? wp(15) : wp(32.5)),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: hp(1.5),
                                      left: wp(1.5),
                                      right: wp(2)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie!.title!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top:
                                                isDeviceTablet ? hp(4) : hp(2)),
                                        // Add to favorites section
                                        child: Row(
                                          children: [
                                            failedSaving
                                                ? const Text(
                                                    "error occurred",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  )
                                                : isSaving
                                                    ? const SizedBox(
                                                        height: 25,
                                                        width: 25,
                                                        child:
                                                            CircularProgressIndicator())
                                                    : TextButton(
                                                        onPressed: () {
                                                          // TODO: Implement rate movie functionality

                                                          // Movie updatedMovie =
                                                          //     movie!.copyWith(
                                                          //         rating: movie
                                                          //             .rating);
                                                          // BlocProvider.of<
                                                          //             MovieCubit>(
                                                          //         context)
                                                          //     .saveMovieDetails(
                                                          //         movie:
                                                          //             updatedMovie);
                                                        },
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.red
                                                                  .withOpacity(
                                                                      0.15),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              movie.rating !=
                                                                      null
                                                                  ? Icons.star
                                                                  : Icons
                                                                      .star_border,
                                                              color:
                                                                  movie.rating !=
                                                                          null
                                                                      ? Colors
                                                                          .yellow
                                                                      : Colors
                                                                          .grey,
                                                              size: 25,
                                                            ),
                                                            SizedBox(
                                                                width:
                                                                    isDeviceTablet
                                                                        ? wp(
                                                                            0.4)
                                                                        : wp(
                                                                            1)),
                                                            if (movie.rating !=
                                                                null)
                                                              Text(
                                                                "${movie.rating}/10",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              )
                                                          ],
                                                        )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: isDeviceTablet ? hp(20) : wp(35),
                      child: Container(
                        width: wp(100),
                        margin: EdgeInsets.symmetric(
                          horizontal: isDeviceTablet ? wp(7) : wp(8),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: StringUtil.isNotEmpty(movie.imagePath)
                                  ? Image.network(
                                      movie.imagePath!,
                                      width: isDeviceTablet ? wp(15) : wp(32.5),
                                      fit: BoxFit.fitWidth,
                                    )
                                  : const Icon(
                                      Icons.camera_alt,
                                      size: 50,
                                    ),
                            ),
                            SizedBox(height: isDeviceTablet ? hp(1) : hp(1.5)),
                            SizedBox(
                              height: hp(70),
                              width: wp(80),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Description",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                      height: isDeviceTablet ? hp(1) : hp(1)),
                                  Expanded(
                                    child: Text(
                                      movie.description ?? '',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              })),
        ));
  }

  Widget _blurredImageWidget(String? imagePath) {
    final isDeviceTablet = ScreenUtils(MediaQuery.of(context)).isDeviceTablet();
    final Function hp = ScreenUtils(MediaQuery.of(context)).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context)).wp;
    return SizedBox(
      height: isDeviceTablet ? hp(30) : hp(30),
      child: Stack(
        fit: StackFit.expand,
        children: [
          StringUtil.isNotEmpty(imagePath)
              ? Image.network(
                  imagePath!,
                  width: wp(100),
                  fit: BoxFit.fitWidth,
                )
              : const Icon(
                  Icons.camera_alt,
                  size: 50,
                ),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                alignment: Alignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
