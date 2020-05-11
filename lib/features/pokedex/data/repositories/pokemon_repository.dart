import 'package:dartz/dartz.dart';
import 'package:poke_app/core/error/exceptions.dart';
import 'package:poke_app/core/error/failure.dart';
import 'package:poke_app/core/platform/network_info.dart';
import 'package:poke_app/features/pokedex/data/datasource/pokemon_remote_data_source.dart';
import 'package:poke_app/features/pokedex/domain/entities/pokemon.dart';
import 'package:poke_app/features/pokedex/domain/repositories/i_pokemon_repository.dart';
import 'package:meta/meta.dart';

typedef Future<Pokemon> _GetPokemonByNameOrRandom();

class PokemonRepository implements IPokemonRepository {
  final PokemonRemoteDataSouce remoteDataSouce;
  final NetworkInfo networkInfo;

  PokemonRepository(
      {@required this.remoteDataSouce, @required this.networkInfo});

  @override
  Future<Either<Failure, Pokemon>> getPokemonByName(String name) async {
    return await _getPokemon(() {
      return remoteDataSouce.getPokemonByName(name);
    });
  }

  @override
  Future<Either<Failure, Pokemon>> getRandomPokemon() async {
    return await _getPokemon(() {
      return remoteDataSouce.getRandomPokemon();
    });
  }

  Future<Either<Failure, Pokemon>> _getPokemon(
      _GetPokemonByNameOrRandom getPokemonByNameOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        var pokeModel = await getPokemonByNameOrRandom();
        return Right(Pokemon(
            name: pokeModel.name,
            pokeIndex: pokeModel.pokeIndex,
            types: pokeModel.types,
            genus: pokeModel.genus,
            color: pokeModel.color,
            imageUrl: pokeModel.imageUrl));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetConnectionFailure());
    }
  }
}
