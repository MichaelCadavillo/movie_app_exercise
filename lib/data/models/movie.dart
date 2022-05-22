class Movie {
  final String id;
  final String? title;
  final String? description;
  final String? imagePath;
  final String? backdropPath;
  final double? rating;

  Movie(
      {required this.id,
      this.title,
      this.description,
      this.rating,
      this.imagePath,
      this.backdropPath});

  Movie copyWith(
          {String? id,
          String? title,
          String? description,
          String? imagePath,
          double? rating,
          String? backdropPath}) =>
      Movie(
          id: id ?? this.id,
          title: title ?? this.title,
          description: description ?? this.description,
          imagePath: imagePath ?? this.imagePath,
          backdropPath: backdropPath ?? this.backdropPath,
          rating: rating ?? this.rating);
}
