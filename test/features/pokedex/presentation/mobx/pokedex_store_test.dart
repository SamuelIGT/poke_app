import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_app/core/error/failure.dart';
import 'package:poke_app/core/mobx/store_state.dart';
import 'package:poke_app/core/usecases/use_cases.dart';
import 'package:poke_app/features/pokedex/domain/entities/pokemon.dart';
import 'package:poke_app/features/pokedex/domain/usecases/get_pokemon_by_name.dart';
import 'package:poke_app/features/pokedex/domain/usecases/get_random_pokemon.dart';
import 'package:poke_app/features/pokedex/presentation/mobx/pokedex_store.dart';

class MockGetPokemonByName extends Mock implements GetPokemonByName {}

class MockGetRandomPokemon extends Mock implements GetRandomPokemon {}

void main() {
  MockGetPokemonByName getByNameUC;
  MockGetRandomPokemon getRandomUC;
  PokedexStore store;

  setUp(() {
    getByNameUC = MockGetPokemonByName();
    getRandomUC = MockGetRandomPokemon();
    store = PokedexStore(getByNameUC, getRandomUC);
  });

  group('pokedex_store', () {
    test(
      'should start with Initial state',
      () async {
        //arrange

        //act
        var status = store.state;

        //assert
        expect(status, StoreState.Initial);
      },
    );

    group('getPokemonByName', () {
      final String pokeName = 'ditto';
      final Pokemon pokemon = Pokemon(
        name: "ditto",
        color: "purple",
        genus: "Transform Pokémon",
        pokeIndex: 132,
        types: ["normal"],
        imageUrl:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png",
      );

      test(
        'should get the specified pokemon from the use case successfully',
        () async {
          //arrange
          when(getByNameUC(any)).thenAnswer((_) async => Right(pokemon));

          //act
          await store.getPokemonByName(name: pokeName);

          //assert
          verify(getByNameUC(Params(name: pokeName)));
          expect(store.state, StoreState.Loaded);
          expect(store.pokemon, Right(pokemon));
        },
      );

      test(
        'should get a failure when the use case fails',
        () async {
          //arrange
          when(getByNameUC(any)).thenAnswer((_) async => Left(ServerFailure()));

          //act
          await store.getPokemonByName(name: pokeName);

          //assert
          verify(getByNameUC(Params(name: pokeName)));
          expect(store.state, StoreState.Loaded);
          expect(store.pokemon, Left(ServerFailure()));
        },
      );
    });

    group('getRandomPokemon', () {
      final Pokemon pokemon = Pokemon(
        name: "ditto",
        color: "purple",
        genus: "Transform Pokémon",
        pokeIndex: 132,
        types: ["normal"],
        imageUrl:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png",
      );

      test(
        'should get a random pokemon from the use case successfully',
        () async {
          //arrange
          when(getRandomUC(any)).thenAnswer((_) async => Right(pokemon));

          //act
          await store.getRandomPokemon();

          //assert
          verify(getRandomUC(NoParams()));
          expect(store.state, StoreState.Loaded);
          expect(store.pokemon, Right(pokemon));
        },
      );

      test(
        'should get a failure when the use case fails',
        () async {
          //arrange
          when(getRandomUC(any)).thenAnswer((_) async => Left(ServerFailure()));

          //act
          await store.getRandomPokemon();

          //assert
          verify(getRandomUC(NoParams()));
          expect(store.state, StoreState.Loaded);
          expect(store.pokemon, Left(ServerFailure()));
        },
      );
    });
  });
}
