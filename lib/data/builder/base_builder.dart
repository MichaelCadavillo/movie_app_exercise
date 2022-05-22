
abstract class Builder<T> {
  const Builder();
  
  /// Maps an object from Dart into something that will be understood
  /// by the network.
  Map<String, dynamic> mapToNetwork(T object);

  /// Maps a network response to [T] object.
  T mapNetworkToDart(Map<String, dynamic> map);
}
