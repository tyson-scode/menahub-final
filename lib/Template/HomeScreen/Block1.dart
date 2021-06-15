import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/StaticFunction.dart';

class Block1 extends StatelessWidget {
  const Block1({this.onstate, this.productImage, this.productSkuId});
  final AddToCartCallback onstate;
  final String productImage;
  final String productSkuId;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(productSkuId);
        onstate(productSkuId, false);
      },
      child: Container(
        height: 120,
        width: (MediaQuery.of(context).size.width / 3) - 10,
        padding: EdgeInsets.only(left: 6, top: 6, bottom: 6, right: 6),
        color: whiteColor,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: lightGreyColor),
              borderRadius: BorderRadius.all(Radius.circular(2))),
          child: Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("$imageBaseUrl$productImage"),
                  fit: BoxFit.fill,
                ),
              ),
              child: null),
        ),
      ),
    );
  }
}
