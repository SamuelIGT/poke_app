import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:poke_app/core/error/failure.dart';
import 'package:poke_app/core/mobx/store_state.dart';
import 'package:poke_app/core/usecases/use_cases.dart';
import 'package:poke_app/features/pokedex/domain/entities/pokemon.dart';
import 'package:poke_app/features/pokedex/domain/usecases/get_pokemon_by_name.dart';
import 'package:poke_app/features/pokedex/domain/usecases/get_random_pokemon.dart';

part 'pokedex_store.g.dart';

class PokedexStore = _PokedexStoreBase with _$PokedexStore;

abstract class _PokedexStoreBase with Store {
  final GetPokemonByName _getByNameUC;
  final GetRandomPokemon _getRandomUC;

  _PokedexStoreBase(this._getByNameUC, this._getRandomUC)
      : assert(_getByNameUC != null),
        assert(_getRandomUC != null);

  @observable
  ObservableFuture<Either<Failure, Pokemon>>
      _pokemonFuture;

  @observable
  Either<Failure, Pokemon> pokemon;

  @computed
  StoreState get state => StoreStateMapper.mapFutureStateToStoreState(_pokemonFuture);

  @action
  Future<void> getPokemonByName({@required String name}) async {
    _pokemonFuture = ObservableFuture(_getByNameUC(Params(name: name)));
    pokemon = await _pokemonFuture;
  }

  @action
  Future<void> getRandomPokemon() async {
    _pokemonFuture = ObservableFuture(_getRandomUC(NoParams()));
    pokemon = await _pokemonFuture;
  }
}
