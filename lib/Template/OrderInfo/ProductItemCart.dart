//
import 'package:flutter/material.dart';
import 'package:menahub/ProductsDetails/ParticularProductsDetailsScreen.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';

productItemCart({Map productDetails, BuildContext context}) {
  Map extensionAttributes = productDetails["extension_attributes"];
  print(extensionAttributes);
  List imageList = extensionAttributes["image"];
  Map imageSet = imageList[0];
  List mediaGalleryEntriesList = imageSet["media_gallery_entries"];
  var productImage = mediaGalleryEntriesList[0]["file"];

  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParticularProductsDetailsScreen(
            productSkuId: productDetails["sku"],
          ),
        ),
      );
    },
    child: Container(
      color: whiteColor,
      margin: EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 10,
          top: 20,
          bottom: 20,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productDetails["name"],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  sizedBoxheight5,
                  // Row(
                  //   children: [
                  //     Text(
                  //       "Brands: ",
                  //       style: TextStyle(
                  //         fontSize: 12,
                  //         color: greyColor,
                  //       ),
                  //     ),
                  //     Text(
                  //       productDetails["product_type"],
                  //       style: TextStyle(
                  //         fontSize: 12,
                  //         color: secondaryColor,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  sizedBoxheight5,
                  Text(
                    "QAR ${productDetails["price"]}",
                    style: TextStyle(
                        color: secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  sizedBoxheight10,
                  //product like, remove, add
                  // Row(
                  //   children: [
                  //     Container(
                  //       decoration: BoxDecoration(
                  //           border: Border.all(color: lightGreyColor, width: 2),
                  //           borderRadius: BorderRadius.circular(5)),
                  //       child: Row(
                  //         children: [
                  //           Padding(
                  //             padding: const EdgeInsets.only(
                  //                 left: 10, right: 10, top: 5, bottom: 5),
                  //             child: Text("-"),
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.only(
                  //                 left: 10, right: 10, top: 5, bottom: 5),
                  //             child: Text("0"),
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.only(
                  //                 left: 10, right: 10, top: 5, bottom: 5),
                  //             child: Text("+"),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                    image: NetworkImage("$imageBaseUrl$productImage"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: null,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
/*

*/
