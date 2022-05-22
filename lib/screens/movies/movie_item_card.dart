import 'package:flutter/material.dart';
import 'package:movie_app_exercise/data/models/movie.dart';
import 'package:movie_app_exercise/utility/screen_utils.dart';
import 'package:movie_app_exercise/utility/string_util.dart';

class MovieItemCard extends StatelessWidget {
  const MovieItemCard(
      {Key? key,
      required this.movie,
      required this.onFavoriteButtonTap,
      this.isSaving = false,
      this.failedSaving = false})
      : super(key: key);

  final Movie movie;
  final Function onFavoriteButtonTap;
  final bool isSaving;
  final bool failedSaving;

  @override
  Widget build(BuildContext context) {
    final isDeviceTablet = ScreenUtils(MediaQuery.of(context)).isDeviceTablet();
    final Function hp = ScreenUtils(MediaQuery.of(context)).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context)).wp;
    return SizedBox(
      height: isDeviceTablet ? wp(20) : hp(30),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              height: isDeviceTablet ? wp(17.5) : hp(22.5),
              width: wp(100),
              margin: EdgeInsets.only(
                left: isDeviceTablet ? hp(3.5) : wp(5),
              ),
              child: Row(
                children: [
                  // Space for image
                  SizedBox(
                    width: isDeviceTablet ? wp(12.5) : wp(27.5),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: hp(1.5), left: wp(1.5), right: wp(2)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Title
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  movie.title ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  onFavoriteButtonTap();
                                },
                                borderRadius: BorderRadius.circular(15),
                                child: Icon(
                                  movie.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: movie.isFavorite
                                      ? Colors.pink
                                      : Colors.grey,
                                  size: 25,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: hp(1)),
                          // Description
                          Text(
                            movie.description ?? '',
                            maxLines: isDeviceTablet ? 3 : 4,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            elevation: 5,
          ),
          Positioned(
            left: isDeviceTablet ? hp(3.5) : wp(5),
            bottom: isDeviceTablet ? hp(3.5) : wp(5),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(-5, 5))
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: StringUtil.isNotEmpty(movie.imagePath)
                    ? Image.network(
                        movie.imagePath!,
                        width: isDeviceTablet ? null : wp(27.5),
                        height: isDeviceTablet ? wp(20) : null,
                        fit:
                            isDeviceTablet ? BoxFit.fitHeight : BoxFit.fitWidth,
                      )
                    : const Icon(
                        Icons.camera_alt,
                        size: 50,
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
