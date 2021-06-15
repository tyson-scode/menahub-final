import 'package:flutter/material.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';

import 'package:menahub/Util/Widget.dart';
import 'package:menahub/Models/ConfigCartModel.dart';
import 'package:menahub/translation/codegen_loader.g.dart';
import 'package:menahub/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

typedef CartToProductCallback = void Function(
    dynamic onstate, String checkState, bool status, int qty);

class CartItem extends StatefulWidget {
  const CartItem({this.onstate, this.productDetails, this.context});
  final CartToProductCallback onstate;
  final Map productDetails;
  final BuildContext context;
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  bool wishlistStatus = false;
  int productCount = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    productCount = widget.productDetails["qty"];
  }

  @override
  Widget build(BuildContext context) {
    Map extensionAttributes = widget.productDetails["extension_attributes"];
    List imageList = extensionAttributes["image"];
    Map imageSet = imageList[0];
    String sku = imageSet["sku"];
    List mediaGalleryEntriesList = imageSet["media_gallery_entries"];
    var productImage;
    if (mediaGalleryEntriesList.isNotEmpty) {
      productImage = mediaGalleryEntriesList[0]["file"];
    }
    return InkWell(
      onTap: () {
        print(productCount);
        print("wishlistStatus");

        print(!wishlistStatus);
        widget.onstate(sku, "next", !wishlistStatus, productCount);
      },
      child: Card(
        margin: EdgeInsets.only(top: 5),
        child: Container(
          color: whiteColor,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productDetails["name"],
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      sizedBoxheight10,
                      Text(
                        "QAR ${(widget.productDetails["price"]).toStringAsFixed(2).toString()}",
                        style: TextStyle(
                            color: secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      sizedBoxheight10,
                      //product like, remove, add
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: lightGreyColor, width: 2),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (productCount != 1) {
                                        // productCount -= 1;
                                        // print(sku);
                                        // widget.onstate(sku, "0", false, true,
                                        //     productCount);
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 5, bottom: 5),
                                    // child: Text("-"),
                                    child: Text(
                                      "QUANTITY :",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  child: Text(productCount.toString()),
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     setState(() {
                                //       // productCount += 1;
                                //     });
                                //   },
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(
                                //         left: 10, right: 10, top: 5, bottom: 5),
                                //     child: Text(""),
                                //
                                //     // Text("+"),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                          sizedBoxwidth20,
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (!wishlistStatus) {
                                  widget.onstate(
                                      ConfigCartModel(
                                        sku: sku,
                                        qty: productCount.toString(),
                                      ),
                                      "0",
                                      !wishlistStatus,
                                      0);
                                  wishlistStatus = !wishlistStatus;
                                }
                              });
                            },
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
                          sizedBoxwidth20,
                          InkWell(
                            onTap: () {
                              widget.onstate(
                                  widget.productDetails['item_id'].toString(),
                                  "0",
                                  false,
                                  0);
                            },
                            child: Image.asset(
                              "assets/icon/deleteIcon.png",
                              height: 25,
                              width: 25,
                              color: blackColor,
                            ),
                          ),
                        ],
                      ),
                      sizedBoxheight20,
                      Text(
                          LocaleKeys.Sub_Total.tr() +
                              " : QAR ${widget.productDetails["row_total"].toStringAsFixed(2).toString()}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                      image: NetworkImage("$imageBaseUrl$productImage"),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
