import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;

  @override
  List<Object> get props => null;
}

class ServerFailure extends Failure {
  static const MESSAGE = 'A server failure has ocurred. Please contact the admistrator.';
  ServerFailure() : super(MESSAGE);
}

class InternetConnectionFailure extends Failure {
  static const MESSAGE = 'No internet connection was detected.';
  InternetConnectionFailure() : super(MESSAGE);
}
