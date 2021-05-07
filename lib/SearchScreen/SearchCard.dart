import 'package:flutter/material.dart';
import 'package:menahub/ProductsDetails/ParticularProductsDetailsScreen.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';

Widget searchCard({Map searchDetails, BuildContext context}) {
  double price = double.parse(searchDetails["price"]);
  // var document = parse(searchDetails["html"]);
  // print(document.getElementsByClassName("sku"));
// var inputElement = document.querySelector('[class="sku"]');

  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParticularProductsDetailsScreen(
            productSkuId: searchDetails["product_id"],
            apiType: "id",
          ),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              searchDetails["name"],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            sizedBoxheight5,
            Row(
              children: [
                Text(
                  price.toString(),
                  style: TextStyle(
                      color: secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            // Html(data: searchDetails["html"])
          ],
        ),
      ),
    ),
  );
}
