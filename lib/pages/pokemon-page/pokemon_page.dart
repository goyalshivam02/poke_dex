import 'package:flutter/material.dart';

class PokemonPage extends StatelessWidget {
  Map pokemonData = {};
  @override
  Widget build(BuildContext context) {
    pokemonData = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Center(child: Text(pokemonData['name'])),
    );
  }


}

