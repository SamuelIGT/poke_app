import 'package:poke_app/features/pokedex/data/models/pokemon_model.dart';

abstract class PokemonRemoteDataSouce {
  Future<PokemonModel> getPokemonByName(String name);
  Future<PokemonModel> getRandomPokemon();
}
