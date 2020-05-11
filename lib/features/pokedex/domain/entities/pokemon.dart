import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Pokemon extends Equatable {
  final String name;
  final int pokeIndex;
  final List<String> types;
  final String genus;
  final String color;
  final String imageUrl;

  Pokemon({
    @required this.name,
    @required this.pokeIndex,
    @required this.types,
    @required this.genus,
    @required this.color,
    @required this.imageUrl,
  });

  @override
  List<Object> get props => [name, pokeIndex, types, genus, color, imageUrl];
}
