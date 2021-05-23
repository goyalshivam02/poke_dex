

import 'package:http/http.dart';
import 'dart:convert';
import 'dart:core';


class PokemonData{

  String name;
  String image;
  List<String> types = [] ;
  int index;
  List<Map> abilities = [];
  List<Map> moves = [];
  double weight;
  double height;
  List<int> stats = [];

  PokemonData({this.index});

  Future<void> getData () async {
    Response pokemonResponse =  await get('https://pokeapi.co/api/v2/pokemon/$index');
    Map pokemonData = jsonDecode(pokemonResponse.body);

    name = pokemonData['name'];
    image = pokemonData['sprites']['other']['official-artwork']['front_default'];
    weight = pokemonData['weight'].toDouble()/10;
    height = pokemonData['height'].toDouble()*10;

    // Types
    for(int i=0;i<pokemonData['types'].length;i++){
      types.add(pokemonData['types'][i]['type']['name']);
    }
    //Stats
    for(int i=0;i<pokemonData['stats'].length;i++){
      stats.add(pokemonData['stats'][i]['base_stat']);
    }

    //Abilities

    for(int i=0;i<pokemonData['abilities'].length;i++){
      abilities.add(
          {'abilityName' : pokemonData['abilities'][i]['ability']['name'],
            'url' : pokemonData['abilities'][i]['ability']['url'],
          }
      );
    }



    //Moves
    for(int i=0;i<pokemonData['moves'].length;i++){
      moves.add(
          {'moveName' : pokemonData['moves'][i]['move']['name'],
            'url' : pokemonData['moves'][i]['move']['url'],
            'minLvl' : pokemonData['moves'][i]['version_group_details'][0]['level_learned_at']

          }
      );
    }

  }
}

// ----------------- Ability Info --------------------------

class AbilitiesInfo {
  List<Map> abilities = [];
  String name;
  String effect;
  String flavorText;
  List<Map> abilitiesAll = [];

  AbilitiesInfo ({this.abilities});

  Future<void> getAbilitiesInfo() async{
    for(int i=0;i<abilities.length;i++){

      Response res =  await get(abilities[i]['url']);
      Map ability = jsonDecode(res.body);

      name = abilities[i]['abilityName'];
      effect = ((ability['effect_entries'].where((data) => data['language']['name'] == 'en').toList())[0]['effect']).replaceAll('\n','');
      flavorText = ((ability['flavor_text_entries'].where((data) => data['language']['name'] == 'en').toList())[0]['flavor_text']).replaceAll('\n','');

      abilitiesAll.add(
        {
          'name': name,
          'effect': effect,
          'flavorText' : flavorText
        }
      );

    }
  }

}


// -------------------Moves Info ---------------------------

class MovesInfo {
  List<Map> moves = [];
  String name;
  String minLvl;
  String acc ;
  String power;
  String desc;
  List<Map> movesAll = [];

  MovesInfo ({this.moves});

  Future<void> getMovesInfo() async{
    for(int i=0;i<10;i++){

      Response res =  await get(moves[i]['url']);
      Map move = jsonDecode(res.body);

      name = moves[i]['moveName'];
      minLvl = moves[i]['minLvl'].toString();
      acc = move['accuracy'].toString();
      power = move['power'].toString();
      desc = ((move['effect_entries'].where((data) => data['language']['name'] == 'en').toList())[0]['effect']).replaceAll('\n','');

      movesAll.add({
        'name' : name,
        'minLvl' : minLvl,
        'acc' : acc,
        'power' : power,
        'desc' : desc
      });


    }
  }

}

// -------------------   Strength ----------



class Strength {
  List types = [];
  List<String> strongAgainst = [];
  List<String> weakAgainst = [];

  Strength ({this.types});

  Future<void> getStrength() async{


    Response pokemonTypesResponse =  await get('https://pokeapi.co/api/v2/type/'+types[0]);
    Map pokemonTypes = jsonDecode(pokemonTypesResponse.body);

    try{
      for(int i=0;i<pokemonTypes['damage_relations']['double_damage_from'].length;i++){
        weakAgainst.add(pokemonTypes['damage_relations']['double_damage_from'][i]['name']);
      }
    }catch(e){
      weakAgainst.add('NA');
    }

    try{
      for(int i=0;i<pokemonTypes['damage_relations']['double_damage_to'].length;i++){
        strongAgainst.add(pokemonTypes['damage_relations']['double_damage_to'][i]['name']);
      }
    }catch(e){
      strongAgainst.add('NA');
    }


  }

}



// ------------------- Evolution ----------

class Evolution {

  int index;
  var evolution = <Map>[];



  Evolution ({this.index});

  Future<void> getEvolution() async{

    Response pokemonSpeciesResponse =  await get('https://pokeapi.co/api/v2/pokemon-species/$index');
    Map pokemonSpecies = jsonDecode(pokemonSpeciesResponse.body);

    String evolutionURL = pokemonSpecies['evolution_chain']['url'];

    Response evolutionChainResponse =  await get(evolutionURL);
    Map evolutionChain = jsonDecode(evolutionChainResponse.body);



    List evolves_to = evolutionChain['chain']['evolves_to'];



    while(evolves_to.isNotEmpty){
      if(evolution.isEmpty){
        evolution.add({
          'PokemonName' : evolutionChain['chain']['species']['name'] ,
          'minLvl' : 0
        });}
      Map evolveMap = evolves_to[0];
      evolution.add({
        'PokemonName' : evolveMap['species']['name'] ,
        'minLvl' : evolveMap['evolution_details'][0]['min_level']
      });
      evolves_to = evolveMap['evolves_to'];
    }


  }


}

