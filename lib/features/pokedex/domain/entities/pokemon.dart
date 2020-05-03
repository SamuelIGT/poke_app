import 'package:flutter/cupertino.dart';

class Pokemon {
  final String name;
  final int pokeIndex;
  final List<String> types;
  final String genus;
  final String color;

  Pokemon(
      {@required this.name,
      @required this.pokeIndex,
      @required this.types,
      @required this.genus,
      @required this.color});
}
