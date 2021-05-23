

import 'package:flutter/material.dart';
import 'package:poke_dex/services/pokemon_data.dart';
import 'package:poke_dex/Widgets/Homepage/PokemonCard.dart';
import 'package:poke_dex/Widgets/Homepage/SearchBar.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {

  List<Map> pokemonList = [];
  List<Map> pokemonListDisplay = [];


  Future<void> getPokemonData(index) async {
    PokemonData pokemon = new PokemonData(index: index);
    await pokemon.getData();
    pokemonList.add({'name' : pokemon.name,
      'image' : pokemon.image,
      'types' : pokemon.types});

  }
  Future<List<Map>> getAllData() async{
    for(int i=1 ;i<=25;i++){
      await getPokemonData(i);
    }
      pokemonListDisplay = pokemonList;
      return pokemonList;

  }

  Future allData;



  final searchController = new TextEditingController();

  void initState() {
    super.initState();
    allData = getAllData();
    searchController.addListener(searchResult);
  }

  dynamic searchResult(){
    String text = searchController.text.toLowerCase();
    setState(() {
      pokemonListDisplay = pokemonList.where((data) =>
      (data['name'].toLowerCase().startsWith(text)) || data['types'].join().toLowerCase().startsWith(text)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('PokeDex'),
        ),
        body:  SingleChildScrollView(
            child: Column(
              children: [ Padding(
                padding: const EdgeInsets.fromLTRB(20.0,20,20,0),
                child: searchBar(hintText: 'Enter a pokemon or type',controller: searchController,ctx: context),
              ),

                FutureBuilder(
                  future: allData ,
                  builder: (context,snapshot){
                      return snapshot.hasData ? Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Column(

                          children:  pokemonListDisplay.map((data) => GestureDetector(
                              onTap:(){
                                Navigator.pushNamed(context, '/pokemon_page',arguments: data);
                              },
                              child: pokemonCard(data,context))).toList(),

                        ),
                      ) : Padding(
                        padding: const EdgeInsets.fromLTRB(0,300,0,0),
                        child: CircularProgressIndicator(),
                      );

                    }
                ),
              ],
            ),
          ),
        ),

    );
  }
}
