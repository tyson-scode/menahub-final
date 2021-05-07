import 'package:flutter/cupertino.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';

Widget whatsNewCard({Map productDetails, int index}) {
  double productPrice = double.parse(productDetails['price']);
  return Column(
    children: [
      Container(
        height: index == 0 ? 150 : 100,
        width: index == 0 ? 150 : 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("$imageBaseUrl${productDetails["image"]}"),
            fit: BoxFit.contain,
          ),
        ),
        child: null,
      ),
      sizedBoxheight10,
      Container(
        height: 30,
        child: Text(
          productDetails["name"],
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      sizedBoxheight5,
      Text(
        "QAR $productPrice",
        style: TextStyle(color: appBarColor, fontWeight: FontWeight.w600),
      )
    ],
  );
}
