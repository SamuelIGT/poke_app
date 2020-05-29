import 'package:dartz/dartz.dart';
import 'package:poke_app/core/error/exceptions.dart';
import 'package:poke_app/core/error/failure.dart';
import 'package:poke_app/core/network/network_info.dart';
import 'package:poke_app/features/pokedex/data/datasource/pokemon_remote_data_source.dart';
import 'package:poke_app/features/pokedex/domain/entities/pokemon.dart';
import 'package:poke_app/features/pokedex/domain/repositories/i_pokemon_repository.dart';
import 'package:meta/meta.dart';

typedef Future<Pokemon> _GetPokemonByNameOrIndex();

class PokemonRepository implements IPokemonRepository {
  final IPokemonRemoteDataSouce remoteDataSouce;
  final INetworkInfo networkInfo;

  PokemonRepository(
      {@required this.remoteDataSouce, @required this.networkInfo});

  @override
  Future<Either<Failure, Pokemon>> getPokemonByName(String name) async {
    return await _getPokemon(() {
      return remoteDataSouce.getPokemonByName(name);
    });
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemonByIndex(int index) async {
    return await _getPokemon(() {
      return remoteDataSouce.getPokemonByIndex(index);
    });
  }

  Future<Either<Failure, Pokemon>> _getPokemon(
      _GetPokemonByNameOrIndex getPokemonByNameOrRandom) async {
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
