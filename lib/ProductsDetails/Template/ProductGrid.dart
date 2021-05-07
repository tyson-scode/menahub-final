import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:menahub/ProductsDetails/ParticularProductsDetailsScreen.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/StaticFunction.dart';
import 'package:menahub/Util/Widget.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid(
      {this.onstate, this.productDetails, this.context, this.userType});
  final AddToCartCallback onstate;
  final Map productDetails;
  final BuildContext context;
  final bool userType;
  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  bool wishlistStatus = false;
  @override
  Widget build(BuildContext context) {
    List customAttributes = widget.productDetails["custom_attributes"];
    int producImageIndex =
        customAttributes.indexWhere((f) => f['attribute_code'] == "image");
    Map productDescriptionMap = customAttributes[producImageIndex.abs()];
    var productImage = productDescriptionMap["value"];

    var specialPrice;
    for (var item in customAttributes) {
      if (item["attribute_code"] == "special_price") {
        specialPrice = item["value"];
      }
    }
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ParticularProductsDetailsScreen(
              productSkuId: widget.productDetails["sku"],
            ),
          ),
        );
      },
      child: Card(
        child: Container(
          color: whiteColor,
          width: (MediaQuery.of(context).size.width / 2) - 20,
          margin: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.userType == false
                  ? Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (!wishlistStatus) {
                              widget.onstate(
                                  widget.productDetails['id'].toString(),
                                  !wishlistStatus);
                              wishlistStatus = !wishlistStatus;
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            wishlistStatus != true
                                ? Image.asset(
                                    "assets/icon/heartIcon.png",
                                    height: 25,
                                    width: 25,
                                  )
                                : Image.asset(
                                    "assets/icon/redHeartIcon.png",
                                    height: 25,
                                    width: 25,
                                  ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              Expanded(
                child: Container(
                  // height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                      image: NetworkImage("$imageBaseUrl$productImage"),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        widget.productDetails["name"],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    sizedBoxheight5,
                    Text(
                      "QAR ${widget.productDetails['price']}",
                      style: TextStyle(
                        fontSize: 12,
                        color: appBarColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    sizedBoxheight5,
                    Row(
                      children: [
                        if (specialPrice != null)
                          Text(
                            specialPrice,
                            style: new TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        // sizedBoxwidth5,
                        // Text(
                        //   "7% off",
                        //   style: new TextStyle(
                        //     fontSize: 12,
                        //   ),
                        // )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
