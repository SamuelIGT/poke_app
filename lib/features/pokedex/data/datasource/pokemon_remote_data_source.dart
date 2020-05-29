import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:poke_app/core/error/exceptions.dart';
import 'package:poke_app/core/utils/AppStrings.dart';
import 'package:poke_app/features/pokedex/data/models/pokemon_model.dart';

abstract class IPokemonRemoteDataSouce {
  Future<PokemonModel> getPokemonByName(String name);
  Future<PokemonModel> getPokemonByIndex(int index);
}

class PokemonRemoteDataSource implements IPokemonRemoteDataSouce {
  final http.Client httpClient;

  PokemonRemoteDataSource(this.httpClient);

  @override
  Future<PokemonModel> getPokemonByName(String name) async {
    return _getPokemonById(name);
  }

  @override
  Future<PokemonModel> getPokemonByIndex(int index) {
    return _getPokemonById(index.toString());
  }

  Future<PokemonModel> _getPokemonById(String id) async {
    Map<String, String> headers = {
      'content-type': 'application/json; charset=utf-8'
    };

    final pokemon = await httpClient.get(
        "${AppStrings.POKEMON_API_BASE_URL}${AppStrings.GET_POKEMON_ENDPOINT}/$id",
        headers: headers);

    final specie = await httpClient.get(
        "${AppStrings.POKEMON_API_BASE_URL}${AppStrings.GET_SPECIE_ENDPOINT}/$id",
        headers: headers);

    if (pokemon.statusCode == HttpStatus.ok &&
        specie.statusCode == HttpStatus.ok) {
      return PokemonModel.fromJson(
          json.decode(pokemon.body), json.decode(specie.body));
    } else {
      throw ServerException();
    }
  }
}
