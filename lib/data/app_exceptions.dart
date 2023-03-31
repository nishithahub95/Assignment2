class AppException implements Exception{
  final _message;
  final _preffix;
  AppException([this._message,this._preffix]);
  String toString(){
    return '$_preffix$_message';
  }
}

class FetchDataExceptions extends AppException{

  FetchDataExceptions([String? message]):super(message,'Error During Communications');
}
class BadRequestExceptions extends AppException{

  BadRequestExceptions([String? message]):super(message,'Invalid request');
}
class UnauthorisedExceptions extends AppException{

  UnauthorisedExceptions([String? message]):super(message,'unauthorised request');//invalid tocken
}
class InvalidInputExceptions extends AppException{

  InvalidInputExceptions([String? message]):super(message,'Invalid input');
}