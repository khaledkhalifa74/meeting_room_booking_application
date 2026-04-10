import 'package:dio/dio.dart';

abstract class Failure{
  final String message;

  Failure({required this.message});
}

class ServerFailure extends Failure{
  ServerFailure({required super.message});

  factory ServerFailure.fromDioError(DioException e){
    switch(e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(message: 'Connection time out with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure(message: 'Send time out with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(message: 'Receive time out with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure(message: 'Bad certificate with ApiServer');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(e.response?.statusCode, e.response?.data);
      case DioExceptionType.cancel:
        return ServerFailure(message: 'Request to ApiServer was canceled');
      case DioExceptionType.connectionError:
        return ServerFailure(message: 'No internet connection');
      case DioExceptionType.unknown:
        return ServerFailure(message: 'Opps there was an error, please try again');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response){
    if(statusCode == 404){
      return ServerFailure(message: 'Your request was not found, please try later');
    }else if(statusCode == 500){
      return ServerFailure(message: 'There is a problem with server, please try later');
    }else if(statusCode == 400 || statusCode == 401 || statusCode == 403){
      return ServerFailure(message: response['errors']['message']);
    }else{
      return ServerFailure(message: 'There was an error, please try again');
    }
  }
}

class CacheFailure extends Failure{
  CacheFailure({required super.message});
}
class LocalDBFailure extends Failure{
  LocalDBFailure({required super.message});
}

class NetworkFailure extends Failure{
  NetworkFailure({required super.message});
}