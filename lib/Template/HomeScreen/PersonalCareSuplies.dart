import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/StaticFunction.dart';
import 'package:menahub/Util/Widget.dart';
import '../../Util/ConstantData.dart';

class PersonalCareSuplies extends StatefulWidget {
  const PersonalCareSuplies(
      {this.onstate, this.productDetails, this.context, this.userType});
  final AddToCartCallback onstate;
  final Map productDetails;
  final BuildContext context;
  final bool userType;

  @override
  _PersonalCareSupliesState createState() => _PersonalCareSupliesState();
}

class _PersonalCareSupliesState extends State<PersonalCareSuplies> {
  bool wishlistStatus = false;
  @override
  Widget build(BuildContext context) {
    String productPrice =
        double.parse(widget.productDetails['price']).toStringAsFixed(2);
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
                    margin: EdgeInsets.all(10),
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
                      height: 30,
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
