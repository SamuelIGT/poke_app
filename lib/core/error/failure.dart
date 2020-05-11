import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure();

  @override
  List<Object> get props => null;
}

class ServerFailure extends Failure {}

class InternetConnectionFailure extends Failure {}
