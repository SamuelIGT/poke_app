import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poke_app/core/error/failure.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}
class NoParams extends Equatable{
  @override
  List<Object> get props => null;
}
