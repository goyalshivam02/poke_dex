
import 'package:flutter/material.dart';

Widget pokemonCard(pokemonData,context){
  return Container(
    constraints: BoxConstraints(minHeight: 150),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.fromLTRB(20, 6, 20, 6),
      child: Row(
        children: [
          Expanded(
            flex:2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Image.network(pokemonData['image'],
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress == null) return child ;
                  return LinearProgressIndicator(); },
              ),
            ),
          ),
          SizedBox(width: 20.0,),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (pokemonData['name'][0].toUpperCase() + pokemonData['name'].substring(1)) ,
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(height: 4.0,),
                Text(
                  'Type: ' + pokemonData['types'].join(', ') ,
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}