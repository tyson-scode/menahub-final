import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:menahub/Util/ConstantData.dart';

Widget customButton({
  String title,
  Color backgroundColor,
  double fontSize = 14.0,
}) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
    ),
    child: Center(
      child: Text(
        title,
        style: TextStyle(
          color: whiteColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

Widget customGradientButton({
  String title,
  Color backgroundColor,
  double fontSize = 14.0,
}) {
  return Container(
    height: 45,
    decoration: new BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
      gradient: new LinearGradient(
          colors: [
            HexColor("#003254"),
            HexColor("#035D7C"),
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
    ),
    child: Center(
      child: Text(
        title,
        style: TextStyle(
          color: whiteColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
