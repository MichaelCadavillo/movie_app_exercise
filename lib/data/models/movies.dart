class Movie {
  final String id;
  final String? title;
  final String? description;
  final String? imagePath;
  final bool isFavorite;

  Movie(
      {required this.id,
      this.title,
      this.description,
      this.isFavorite = false,
      this.imagePath});

  Movie copyWith(
          {String? id,
          String? title,
          String? description,
          String? imagePath,
          bool? isFavorite}) =>
      Movie(
          id: id ?? this.id,
          title: title ?? this.title,
          description: description ?? this.description,
          imagePath: imagePath ?? this.imagePath,
          isFavorite: isFavorite ?? this.isFavorite);
}
