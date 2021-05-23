import 'package:flutter/material.dart';


Widget searchBar({hintText,controller,ctx}){
  return Container(
    decoration: BoxDecoration(
      border: Border.all(width:1, color: Colors.grey[350] ),
      borderRadius: BorderRadius.all( Radius.circular(100.0)),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20,0,20,0),
      child: Theme(
        data: Theme.of(ctx).copyWith(primaryColor: Colors.grey),
        child: TextField(
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            icon: Icon(Icons.search),
          ),
          controller: controller,
        ),
      ),
    ),
  );
}