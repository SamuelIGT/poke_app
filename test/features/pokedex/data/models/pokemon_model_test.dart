import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:poke_app/features/pokedex/data/models/pokemon_model.dart';
import 'package:poke_app/features/pokedex/domain/entities/pokemon.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tPokemonModel = PokemonModel(
    name: "ditto",
    pokeIndex: 132,
    types: ["normal"],
    color: "purple",
    genus: "Transform Pokémon",
    imageUrl:
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png",
  );

  test(
    'should be a subclass of Pokemon entity',
    () async {
      //assert
      expect(tPokemonModel, isA<Pokemon>());
    },
  );

  test(
    'should return valid model from json',
    () async {
      //arrange
      final Map<String, dynamic> pokemonJsonMap =
          json.decode(fixture('pokemon.json'));
      final Map<String, dynamic> pokeSpecieJsonMap =
          json.decode(fixture('pokemon-specie.json'));

      //act
      final result = PokemonModel.fromJson(pokemonJsonMap, pokeSpecieJsonMap);

      //assert
      expect(result, tPokemonModel);
    },
  );
}
