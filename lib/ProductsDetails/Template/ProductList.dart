//
import 'package:flutter/material.dart';
import 'package:menahub/ProductsDetails/ParticularProductsDetailsScreen.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/StaticFunction.dart';
import 'package:menahub/Util/Widget.dart';

class ProductList extends StatefulWidget {
  const ProductList(
      {this.onstate, this.productDetails, this.context, this.userType});
  final AddToCartCallback onstate;
  final Map productDetails;
  final BuildContext context;
  final bool userType;
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool wishlistStatus = false;

  @override
  Widget build(BuildContext context) {
    List customAttributes = widget.productDetails["custom_attributes"];
    print(customAttributes);
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
      child: Container(
        color: whiteColor,
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 100,
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
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    Text(
                      widget.productDetails["name"],
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    sizedBoxheight5,
                    Row(
                      children: [
                        Text(
                          "QAR ${widget.productDetails['price']}",
                          style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        sizedBoxwidth10,
                        if (specialPrice != null)
                          Expanded(
                            child: Text(
                              specialPrice,
                              style: TextStyle(
                                  color: greyColor,
                                  fontSize: 12,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        // sizedBoxwidth10,
                        // Text(
                        //   "7% off",
                        //   style: TextStyle(
                        //       color: greyColor,
                        //       fontSize: 12,
                        //       fontWeight: FontWeight.w600),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: widget.userType == false
                    ? InkWell(
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
                        child: Container(
                          child: wishlistStatus != true
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
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
