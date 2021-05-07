import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:menahub/Util/ConstantData.dart';

Widget ourActivityCard({BuildContext context, String text}) {
  return Container(
    height: 80,
    width: (MediaQuery.of(context).size.width / 2) - 20,
    child: Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: lightGreyColor, borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/icon/security-payment.png",
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
