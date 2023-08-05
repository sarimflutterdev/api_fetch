import 'dart:convert';

import 'package:api_fetching/MyServices.dart';
import 'package:flutter/material.dart';

class Desc extends StatefulWidget {

  int id;


  Desc({required this.id});

  @override
  State<Desc> createState() => _DescState(id: id);
}

class _DescState extends State<Desc> {

  int id;


  _DescState({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: services.api_desc(id),
          builder:(BuildContext context, AsyncSnapshot snapshot) {

          if(snapshot.hasData){
            Map map = jsonDecode(snapshot.data);
            List genres = map["tvShow"]["genres"];
            return Column(
              children: <Widget>[
                Text("${map["tvShow"]["name"]}"),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: genres.length,
                  itemBuilder: (context, index) {
                  return Row(children: [
                    Text("${genres[index]}")
                  ],);
                },)
              ],
            );
          }

          if(snapshot.hasError){
            return Container();
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return Container();
          }

          return Container();
        },),
      ),
    );
  }
}
