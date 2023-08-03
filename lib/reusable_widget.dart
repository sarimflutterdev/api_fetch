import 'package:flutter/material.dart';

class main_container extends StatelessWidget {

  String image;
  String name;


  main_container({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      height: 160,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6),BlendMode.darken),
                    image: NetworkImage(image))
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 20, top: 100),
            child: Text(name,style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white
            ),),
          )
        ],
      ),
    );
  }
}