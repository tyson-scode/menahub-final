import 'package:flutter/material.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';

Widget ratingProgressIndicator({String ratingPoint, double level}) {
  return Row(
    children: <Widget>[
      Text(
        ratingPoint,
        textAlign: TextAlign.right,
      ),
      sizedBoxwidth5,
      Icon(
        Icons.star,
        size: 13,
        color: Colors.black,
      ),
      sizedBoxwidth5,
      Expanded(
        child: LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          backgroundColor: level == 0.0 ? greyColor : whiteColor,
          value: level,
        ),
      ),
    ],
  );
}
