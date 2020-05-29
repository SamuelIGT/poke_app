import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:poke_app/core/error/exceptions.dart';
import 'package:poke_app/core/utils/AppStrings.dart';
import 'package:poke_app/features/pokedex/data/datasource/pokemon_remote_data_source.dart';
import 'package:poke_app/features/pokedex/data/models/pokemon_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient httpClient;
  PokemonRemoteDataSource pokemonRemoteDataSouce;

  setUp(() {
    httpClient = MockHttpClient();
    pokemonRemoteDataSouce = PokemonRemoteDataSource(httpClient);
  });

  //#region Test default values
  final String pokemonURI =
      "${AppStrings.POKEMON_API_BASE_URL}${AppStrings.GET_POKEMON_ENDPOINT}";
  final String specieURI =
      "${AppStrings.POKEMON_API_BASE_URL}${AppStrings.GET_SPECIE_ENDPOINT}";

  final pokemonModel = PokemonModel(
    name: "ditto",
    pokeIndex: 132,
    types: ["normal"],
    color: "purple",
    genus: "Transform Pokémon",
    imageUrl:
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png",
  );
  //#endregion

  //#region Test helper methods
  void _setHttpClientResponse(String url, String fixtureName, int statusCode) {
    Map<String, String> headers = {
      'content-type': 'application/json; charset=utf-8'
    };

    when(httpClient.get(url, headers: headers)).thenAnswer(
      (_) async =>
          http.Response(fixture(fixtureName), statusCode, headers: headers),
    );
  }

  void _setHttpClientResponseToSuccess(String pokeId) {
    _setHttpClientResponse('$pokemonURI/$pokeId', 'pokemon.json', 200);
    _setHttpClientResponse('$specieURI/$pokeId', 'pokemon-specie.json', 200);
  }

  void _setHttpClientResponseToFail(String pokeId) {
    _setHttpClientResponse('$pokemonURI/$pokeId', 'pokemon.json', 500);
    _setHttpClientResponse('$specieURI/$pokeId', 'pokemon-specie.json', 500);
  }
  //#endregion

  group('get pokemon by name', () {
    final String pokeName = 'ditto';

    test(
      'should request a json data from the remote data source',
      () async {
        //arrange
        _setHttpClientResponseToSuccess(pokeName);

        //act
        await pokemonRemoteDataSouce.getPokemonByName(pokeName);

        //assert
        verify(httpClient.get("$specieURI/$pokeName",
            headers: {'content-type': 'application/json; charset=utf-8'}));
        verify(httpClient.get("$pokemonURI/$pokeName",
            headers: {'content-type': 'application/json; charset=utf-8'}));
      },
    );

    test(
      'should return a pokemon model when the request is a success (HTTP 200 OK)',
      () async {
        //arrange
        _setHttpClientResponseToSuccess(pokeName);

        //act
        var result = await pokemonRemoteDataSouce.getPokemonByName(pokeName);

        //assert
        expect(result, pokemonModel);
      },
    );

    test(
      'should throw an exception when the request fails (HTTP 400-599)',
      () async {
        //arrange
        _setHttpClientResponseToFail(pokeName);

        //act
        var call = pokemonRemoteDataSouce.getPokemonByName;

        //assert
        expect(() => call(pokeName), throwsA(isA<ServerException>()));
      },
    );
  });

  group('get pokemon by index', () {
    final int pokeIndex = 1;
    test(
      'should request a json data from the remote data source',
      () async {
        //arrange
        _setHttpClientResponseToSuccess(pokeIndex.toString());

        //act
        await pokemonRemoteDataSouce.getPokemonByIndex(pokeIndex);

        //assert
        verify(httpClient.get("$specieURI/$pokeIndex",
            headers: {'content-type': 'application/json; charset=utf-8'}));
        verify(httpClient.get("$pokemonURI/$pokeIndex",
            headers: {'content-type': 'application/json; charset=utf-8'}));
      },
    );

    test(
      'should return a pokemon model when the request is a success (HTTP 200 OK)',
      () async {
        //arrange
        _setHttpClientResponseToSuccess(pokeIndex.toString());

        //act
        var result = await pokemonRemoteDataSouce.getPokemonByIndex(pokeIndex);

        //assert
        expect(result, pokemonModel);
      },
    );

    test(
      'should throw an exception when the request fails (HTTP 400-599)',
      () async {
        //arrange
        _setHttpClientResponseToFail(pokeIndex.toString());

        //act
        var call = pokemonRemoteDataSouce.getPokemonByIndex;

        //assert
        expect(() => call(pokeIndex), throwsA(isA<ServerException>()));
      },
    );
  });
}
