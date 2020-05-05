import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_app/features/pokedex/domain/entities/pokemon.dart';
import 'package:poke_app/features/pokedex/domain/repositories/i_pokemon_repository.dart';
import 'package:poke_app/features/pokedex/domain/usecases/get_pokemon_by_name.dart';

class MockPokemonRepository extends Mock implements IPokemonRepository {}

void main() {
  MockPokemonRepository mockPokemonRepository;
  GetPokemonByName useCase;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    useCase = GetPokemonByName(mockPokemonRepository);
  });

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
    'should get a pokemon from repository',
    () async {
      //arrange
      when(mockPokemonRepository.getPokemonByName(pokeName))
          .thenAnswer((_) async => Right(pokemon));

      //act
      var result = await useCase(Params(name: pokeName));

      //assert
      expect(result, Right(pokemon));
      verify(mockPokemonRepository.getPokemonByName(pokeName));
      verifyNoMoreInteractions(mockPokemonRepository);
    },
  );
}
