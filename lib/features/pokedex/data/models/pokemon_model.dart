import 'package:poke_app/features/pokedex/data/repositories/pokemon_repository.dart';
import 'package:poke_app/features/pokedex/domain/entities/pokemon.dart';
import 'package:meta/meta.dart';

// @JsonSerializable()
class PokemonModel extends Pokemon {
  PokemonModel(
      {@required String name,
      @required int pokeIndex,
      @required List<String> types,
      @required String genus,
      @required String color,
      @required String imageUrl})
      : super(
          name: name,
          pokeIndex: pokeIndex,
          types: types,
          genus: genus,
          color: color,
          imageUrl: imageUrl,
        );

  factory PokemonModel.fromJson(
    Map<String, dynamic> pokemonJson,
    Map<String, dynamic> pokeSpecieJson,
  ) {
    List<String> types = (pokemonJson['types'] as List)
        ?.map((t) => t == null ? null : t['type']['name'] as String)
        ?.toList();

    String genus = (pokeSpecieJson['genera'] as List)?.singleWhere(
        (s) => s != null && s['language']['name'] as String == 'en')['genus'];

    return PokemonModel(
      name: pokemonJson['name'],
      pokeIndex: pokemonJson['id'],
      types: types,
      genus: genus,
      color: pokeSpecieJson['color']['name'],
      imageUrl: pokemonJson['sprites']['front_default'],
    );
  }
}
