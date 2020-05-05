import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_app/core/usecases/use_cases.dart';
import 'package:poke_app/features/pokedex/domain/entities/pokemon.dart';
import 'package:poke_app/features/pokedex/domain/repositories/i_pokemon_repository.dart';
import 'package:poke_app/features/pokedex/domain/usecases/get_random_pokemon.dart';

class MockPokemonRepository extends Mock implements IPokemonRepository {}

void main() {
  MockPokemonRepository mockPokemonRepository;
  GetRandomPokemon useCase;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    useCase = GetRandomPokemon(mockPokemonRepository);
  });

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
    'should get a random pokemon from repository',
    () async {
      //arrange
      when(mockPokemonRepository.getRandomPokemon())
          .thenAnswer((_) async => Right(pokemon));

      //act
      var result = await useCase(NoParams());

      //assert
      expect(result, Right(pokemon));
      verify(mockPokemonRepository.getRandomPokemon());
      verifyNoMoreInteractions(mockPokemonRepository);
    },
  );
}
