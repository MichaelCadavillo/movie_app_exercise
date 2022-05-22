class Movie {
  final String id;
  final String? title;
  final String? description;
  final String? imagePath;
  final String? backdropPath;
  final bool isFavorite;

  Movie(
      {required this.id,
      this.title,
      this.description,
      this.isFavorite = false,
      this.imagePath,
      this.backdropPath});

  Movie copyWith(
          {String? id,
          String? title,
          String? description,
          String? imagePath,
          bool? isFavorite,
          String? backdropPath}) =>
      Movie(
          id: id ?? this.id,
          title: title ?? this.title,
          description: description ?? this.description,
          imagePath: imagePath ?? this.imagePath,
          backdropPath: backdropPath ?? this.backdropPath,
          isFavorite: isFavorite ?? this.isFavorite);
}
