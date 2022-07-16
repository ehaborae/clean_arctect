class ServerException implements Exception {
  // final String error;
  // final int code;
  final String message;


  ServerException({
    // required this.error,
    // required this.code,
    required this.message,
});
}

class CacheException implements Exception {
  final dynamic message;

  CacheException(this.message);
}