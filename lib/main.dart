
import 'package:flutter/material.dart';
import 'package:poke_dex/Theme.dart';
import 'pages/home.dart';
import 'pages/pokemon-page/pokemon_page.dart';
import 'package:poke_dex/services/pokemon_data.dart';



void main() {
  // PokemonData pokemon = new PokemonData(index: 1);
  // pokemon.getData();
  // print(pokemon.name);
  runApp(MaterialApp(
    theme: AppTheme.appTheme,
    initialRoute: '/',
    routes: {
      '/' : (context) => Home(),
      '/pokemon_page' : (context) => PokemonPage(),
    },
  ));
}



