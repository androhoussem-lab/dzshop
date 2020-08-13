class RedirectionException implements Exception{
  @override
  String toString() {
    return '301 Redirection found';
  }
}
class NotFoundException implements Exception{

  @override
  String toString() {
    return '404 Not found';
  }
}
class BadRequestException implements Exception{

  @override
  String toString() {
    return '400 Bad request';
  }
}
class ServerErrorException implements Exception{

  @override
  String toString() {
    return '500 Internal Server Error';
  }
}
class NotImplementedException implements Exception{

  @override
  String toString() {
    return '501 Not implemented';
  }
}
class BadGatewayException implements Exception{

  @override
  String toString() {
    return '502 Bad gateway';
  }
}
class GatewayTimeout implements Exception{

  @override
  String toString() {
    return '504 Gateway timeout';
  }
}