import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_app/core/error/exceptions.dart';
import 'package:poke_app/core/error/failure.dart';
import 'package:poke_app/core/network/network_info.dart';
import 'package:poke_app/features/pokedex/data/datasource/pokemon_remote_data_source.dart';
import 'package:poke_app/features/pokedex/data/models/pokemon_model.dart';
import 'package:poke_app/features/pokedex/data/repositories/pokemon_repository.dart';
import 'package:poke_app/features/pokedex/domain/entities/pokemon.dart';

class MockRemoteDataSource extends Mock implements IPokemonRemoteDataSouce {}

class MockNetworkInfo extends Mock implements INetworkInfo {}

void main() {
  PokemonRepository repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PokemonRepository(
      remoteDataSouce: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsWithInternetConnection(Function body) {
    group('device has internet connection', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsWithNoInternetConnection(Function body) {
    group('device has no internet connection', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getPokemonByName', () {
    String pokeName = 'ditto';
    final Pokemon pokemon = Pokemon(
      name: "ditto",
      color: "purple",
      genus: "Transform Pokémon",
      pokeIndex: 132,
      types: ["normal"],
      imageUrl:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png",
    );
    final pokemonModel = PokemonModel(
      name: "ditto",
      pokeIndex: 132,
      types: ["normal"],
      color: "purple",
      genus: "Transform Pokémon",
      imageUrl:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png",
    );

    runTestsWithInternetConnection(() {
      test(
        'should verify if the device has internet connection',
        () async {
          //arrange
          when(mockRemoteDataSource.getPokemonByName(any))
              .thenAnswer((_) async => pokemonModel);

          //act
          repository.getPokemonByName(pokeName);

          //assert
          verify(mockNetworkInfo.isConnected);
        },
      );

      test(
        'should return a pokemon data when the remote data source call is sucessful',
        () async {
          //arrange
          when(mockRemoteDataSource.getPokemonByName(pokeName))
              .thenAnswer((_) async => pokemonModel);

          //act
          Right<Failure, Pokemon> result =
              await repository.getPokemonByName(pokeName);

          //assert
          verify(mockRemoteDataSource.getPokemonByName(pokeName));
          expect(result, Right(pokemon));
          // expect(npokemon, pokemon);
        },
      );

      test(
        'should return a ServerFailure when the remote data source call fails',
        () async {
          //arrange
          when(mockRemoteDataSource.getPokemonByName(pokeName))
              .thenThrow(ServerException());
          //act
          var result = await repository.getPokemonByName(pokeName);
          //assert
          verify(mockRemoteDataSource.getPokemonByName(pokeName));
          expect(result, Left(ServerFailure()));
        },
      );
    });

    runTestsWithNoInternetConnection(() {
      test(
        'should return an InternetConnectionFailure when calling a remote data source method',
        () async {
          //act
          var result = await repository.getPokemonByName(pokeName);

          //assert
          verifyZeroInteractions(mockRemoteDataSource);
          expect(result, Left(InternetConnectionFailure()));
        },
      );
    });
  });

  group('getPokemonByIndex', () {
    int pokeIndex = 132;
    final Pokemon pokemon = Pokemon(
      name: "ditto",
      color: "purple",
      genus: "Transform Pokémon",
      pokeIndex: 132,
      types: ["normal"],
      imageUrl:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png",
    );
    final pokemonModel = PokemonModel(
      name: "ditto",
      pokeIndex: 132,
      types: ["normal"],
      color: "purple",
      genus: "Transform Pokémon",
      imageUrl:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png",
    );

    runTestsWithInternetConnection(() {
      test(
        'should verify if the device has internet connection',
        () async {
          //arrange
          when(mockRemoteDataSource.getPokemonByIndex(pokeIndex))
              .thenAnswer((_) async => pokemonModel);

          //act
          repository.getPokemonByIndex(pokeIndex);

          //assert
          verify(mockNetworkInfo.isConnected);
        },
      );

      test(
        'should return a pokemon data when the remote data source call is sucessful',
        () async {
          //arrange
          when(mockRemoteDataSource.getPokemonByIndex(pokeIndex))
              .thenAnswer((_) async => pokemonModel);

          //act
          Right<Failure, Pokemon> result = await repository.getPokemonByIndex(pokeIndex);

          //assert
          verify(mockRemoteDataSource.getPokemonByIndex(pokeIndex));
          expect(result, Right(pokemon));
          // expect(npokemon, pokemon);
        },
      );

      test(
        'should return a ServerFailure when the remote data source call fails',
        () async {
          //arrange
          when(mockRemoteDataSource.getPokemonByIndex(pokeIndex))
              .thenThrow(ServerException());
          //act
          var result = await repository.getPokemonByIndex(pokeIndex);
          //assert
          verify(mockRemoteDataSource.getPokemonByIndex(pokeIndex));
          expect(result, Left(ServerFailure()));
        },
      );
    });

    runTestsWithNoInternetConnection(() {
      test(
        'should return an InternetConnectionFailure when calling a remote data source method',
        () async {
          
          //act
          var result = await repository.getPokemonByIndex(pokeIndex);

          //assert
          verifyZeroInteractions(mockRemoteDataSource);
          expect(result, Left(InternetConnectionFailure()));
        },
      );
    });
  });
}
