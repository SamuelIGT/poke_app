// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokedex_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PokedexStore on _PokedexStoreBase, Store {
  Computed<StoreState> _$stateComputed;

  @override
  StoreState get state =>
      (_$stateComputed ??= Computed<StoreState>(() => super.state,
              name: '_PokedexStoreBase.state'))
          .value;

  final _$_pokemonFutureAtom = Atom(name: '_PokedexStoreBase._pokemonFuture');

  @override
  ObservableFuture<Either<Failure, Pokemon>> get _pokemonFuture {
    _$_pokemonFutureAtom.reportRead();
    return super._pokemonFuture;
  }

  @override
  set _pokemonFuture(ObservableFuture<Either<Failure, Pokemon>> value) {
    _$_pokemonFutureAtom.reportWrite(value, super._pokemonFuture, () {
      super._pokemonFuture = value;
    });
  }

  final _$pokemonAtom = Atom(name: '_PokedexStoreBase.pokemon');

  @override
  Either<Failure, Pokemon> get pokemon {
    _$pokemonAtom.reportRead();
    return super.pokemon;
  }

  @override
  set pokemon(Either<Failure, Pokemon> value) {
    _$pokemonAtom.reportWrite(value, super.pokemon, () {
      super.pokemon = value;
    });
  }

  final _$getPokemonByNameAsyncAction =
      AsyncAction('_PokedexStoreBase.getPokemonByName');

  @override
  Future<void> getPokemonByName({@required String name}) {
    return _$getPokemonByNameAsyncAction
        .run(() => super.getPokemonByName(name: name));
  }

  final _$getRandomPokemonAsyncAction =
      AsyncAction('_PokedexStoreBase.getRandomPokemon');

  @override
  Future<void> getRandomPokemon() {
    return _$getRandomPokemonAsyncAction.run(() => super.getRandomPokemon());
  }

  @override
  String toString() {
    return '''
pokemon: ${pokemon},
state: ${state}
    ''';
  }
}
