import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget offersCard({String backgroundColor}) {
  return Column(
    children: [
      Container(
        height: 100,
        width: 100,
        child: Card(
          color: HexColor(backgroundColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset("assets/image/lawnImage.png"),
          ),
        ),
      ),
      Text(
        "Lawn & Garden",
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      )
    ],
  );
}
