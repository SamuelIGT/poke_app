import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:poke_app/core/error/failure.dart';
import 'package:poke_app/core/usecases/use_cases.dart';
import 'package:poke_app/core/utils/AppConsts.dart';
import 'package:poke_app/features/pokedex/domain/entities/pokemon.dart';
import 'package:poke_app/features/pokedex/domain/repositories/i_pokemon_repository.dart';

class GetRandomPokemon implements UseCase<Pokemon, NoParams> {
  final IPokemonRepository repository;

  GetRandomPokemon(this.repository);

  @override
  Future<Either<Failure, Pokemon>> call(NoParams params) async {
    int index = AppConsts.POKEMON_MIN_INDEX + Random().nextInt(AppConsts.POKEMON_MAX_INDEX - AppConsts.POKEMON_MIN_INDEX);
    return await repository.getPokemonByIndex(index);
  }
}
