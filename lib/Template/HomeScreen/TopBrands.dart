import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:menahub/Util/Widget.dart';

import '../../Util/ConstantData.dart';

Widget topBrands({BuildContext context}) {
  return InkWell(
    onTap: () {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ParticularProductsDetailsScreen(),
      //   ),
      // );
    },
    child: Container(
      padding: EdgeInsets.all(5),
      color: whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                    image: AssetImage("assets/image/productImage1.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                child: null),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "QAR 9000.00",
                style: TextStyle(
                  fontSize: 12,
                  color: secondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              sizedBoxheight5,
              Row(
                children: [
                  Text(
                    "QAR 106.00",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  sizedBoxwidth5,
                  Text(
                    "10% off",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
}
