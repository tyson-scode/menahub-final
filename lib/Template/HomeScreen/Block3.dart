import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/StaticFunction.dart';
import 'package:menahub/Util/Widget.dart';
import '../../Util/ConstantData.dart';

class Block3 extends StatelessWidget {
  const Block3({this.onstate, this.productDetails});
  final AddToCartCallback onstate;
  final Map productDetails;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onstate(productDetails['sku'].toString(), false);
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
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // productDetails['color'] == null ? :color: HexColor("#00${productDetails["color"]}"),
                        // color: HexColor("#00${productDetails["color"]}"),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          image: DecorationImage(
                            image: NetworkImage(
                                "$imageBaseUrl${productDetails["image"]}"),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: null),
                  ],
                ),
              ),
              sizedBoxheight5,
              Container(
                // height: 30,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  productDetails['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
