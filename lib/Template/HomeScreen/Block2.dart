import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/StaticFunction.dart';
import 'package:menahub/Util/Widget.dart';
import '../../Util/ConstantData.dart';

class Block2 extends StatefulWidget {
  const Block2(
      {this.onstate, this.productDetails, this.context, this.userType});
  final AddToCartCallback onstate;
  final Map productDetails;
  final BuildContext context;
  final bool userType;
  @override
  _Block2State createState() => _Block2State();
}

class _Block2State extends State<Block2> {
  bool wishlistStatus = false;
  @override
  Widget build(BuildContext context) {
    double productPrice = widget.productDetails["price"] == null
        ? 0.0
        : double.parse(widget.productDetails['price']);
    // print('product price = $productPrice');
    return InkWell(
      onTap: () {
        widget.onstate(widget.productDetails['sku'].toString(), false);
      },
      child: Card(
        child: Container(
          color: whiteColor,
          width: (MediaQuery.of(context).size.width / 2.5) - 20,
          margin: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.userType != true
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          if (!wishlistStatus) {
                            widget.onstate(
                                widget.productDetails['entity_id'].toString(),
                                !wishlistStatus);
                            wishlistStatus = !wishlistStatus;
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                        image: NetworkImage(
                            "$imageBaseUrl${widget.productDetails["image"]}"),
                        fit: BoxFit.contain,
                      ),
                    ),
                    child: null),
              ),
              sizedBoxheight5,
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 15,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        widget.productDetails['name'].toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    sizedBoxheight5,
                    Text(
                      "QAR $productPrice",
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
