import 'package:flutter/material.dart';
import 'package:menahub/Util/ConstantData.dart';

Widget oneShopStopCard({screenSize}) {
  return Container(
    margin: EdgeInsets.all(3),
    height: screenSize.height / 4,
    width: (screenSize.width / 2) - 23,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        image: AssetImage("assets/image/djSoundImage.png"),
        fit: BoxFit.fill,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Computers & Accessories",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}
