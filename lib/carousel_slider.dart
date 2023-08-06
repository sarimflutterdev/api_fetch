import 'dart:convert';

import 'package:api_fetching/MyServices.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousal_slider extends StatefulWidget {
  int pictures;

  Carousal_slider({required this.pictures});

  @override
  State<Carousal_slider> createState() => _Carousal_sliderState(pictures: pictures );
}

class _Carousal_sliderState extends State<Carousal_slider> {
  int pictures;


  _Carousal_sliderState({ required this.pictures});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future:services.api_picture(pictures),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
             if(snapshot.hasData){
              Map map= jsonDecode(snapshot.data);
              List img= map["tvShow"]["pictures"];
              return CarouselSlider.builder(
                  itemCount: img.length,
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(21) ,
                        image: DecorationImage(
                          image: NetworkImage("${img[index]}"),
                          fit: BoxFit.cover,
                        )
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 320,
                    autoPlay: true,
                    autoPlayCurve: Curves.easeInOut,
                    enlargeCenterPage: true
                  ),);
             }
             if(snapshot.hasError){
               return Icon(Icons.error);
             }
             if(snapshot.connectionState==ConnectionState.waiting){
               return CircularProgressIndicator();
             }

              return Container();

            },

          ),
        ),
      ),
    );
  }
}

