abstract class Repository<T> {
  const Repository();

  /// Fetches a list of [T] objects.
  Future<List<T>> fetchAll({int? page});

  /// Fetches only one [T] object.
  Future<T> fetchSingle({required String id});

  /// Saves [T] object to repository.
  Future<T> save(T object);
}
