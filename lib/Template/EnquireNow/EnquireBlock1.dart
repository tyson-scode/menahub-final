import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:menahub/Util/Widget.dart';

import '../../Util/ConstantData.dart';

Widget enquireBlock1({String productAmount, BuildContext context}) {
  return InkWell(
    onTap: () {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ParticularProductsDetailsScreen(),
      //   ),
      // );
    },
    child: Card(
      child: Container(
        color: whiteColor,
        width: (MediaQuery.of(context).size.width / 2.5) - 20,
        margin: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: lightGreyColor,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        image: DecorationImage(
                          image: AssetImage("assets/image/productImage1.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: null),
                ],
              ),
            ),
            sizedBoxheight5,
            Padding(
              padding: const EdgeInsets.only(left: 7.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Offce and commerical Supplies",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
