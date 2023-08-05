import 'dart:convert';

import 'package:api_fetching/MyServices.dart';
import 'package:api_fetching/description.dart';
import 'package:api_fetching/reusable_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}


class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  int num =1;

  void increment(){
    num = num+1;
  }

  void decrement(){
    num = num-1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            child: Column(
              children: [

                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap:(){
                         setState(() {
                           if(num>1){
                             decrement();
                           }
                           else{
                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Already on First Page")));

                           }
                         });
            },
                          child: Icon(Icons.minimize)),
                      Text("${num}"),
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              increment();
                            });
                          },
                          child: Icon(Icons.add)),
                    ],
                  ),
                ),

                FutureBuilder(
                  future: services.apifetch(num),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {

                  if(snapshot.hasData){

                    Map map = jsonDecode(snapshot.data);
                    List data = map["tv_shows"];

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Desc(id: data[index]["id"]),));
                        },
                        child: main_container(image: '${data[index]["image_thumbnail_path"]}', name: '${data[index]["name"]}'));
                    },);
                  }

                  if(snapshot.hasError){
                    return Center(child: Icon(Icons.error_outline),);
                  }

                  if(snapshot.connectionState == ConnectionState.waiting){
                    return CircularProgressIndicator();
                  }

                  return Container();
                },),
              ],
            ),
          )),
    );
  }
}



