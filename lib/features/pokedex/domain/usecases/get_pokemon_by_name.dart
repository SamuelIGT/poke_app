import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:poke_app/core/error/failure.dart';
import 'package:poke_app/core/usecases/use_cases.dart';
import 'package:poke_app/features/pokedex/domain/entities/pokemon.dart';
import 'package:poke_app/features/pokedex/domain/repositories/i_pokemon_repository.dart';

class GetPokemonByName implements UseCase<Pokemon, Params> {
  final IPokemonRepository repository;

  GetPokemonByName(this.repository);

  @override
  Future<Either<Failure, Pokemon>> call(Params params) async {
    return await repository.getPokemonByName(params.name);
  }
}

class Params extends Equatable{
  final String name;

  Params({@required this.name});

  @override
  List<Object> get props => [name];
}
