import 'package:dartz/dartz.dart';
import 'package:poke_app/core/error/failure.dart';
import 'package:poke_app/features/pokedex/domain/entities/pokemon.dart';

abstract class IPokemonRepository {
  Future<Either<Failure, Pokemon>> getPokemonByName(String name);
  Future<Either<Failure, Pokemon>> getPokemonByIndex(int index);
}
