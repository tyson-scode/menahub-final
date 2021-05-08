//
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:menahub/ProductsDetails/ParticularProductsDetailsScreen.dart';
import 'package:http/http.dart' as http;
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/StaticFunction.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/config/CustomLoader.dart';

class ProductList extends StatefulWidget {
  const ProductList(
      {this.onstate,
      this.searchId,
      this.context,
      this.userType,
      productDetails});

  final BuildContext context;
  final AddToCartCallback onstate;
  final String searchId;
  final bool userType;

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }

  Future<Map> sendCountriesDataRequest(int page) async {
    print('page $page');
    String url =
        'https://uat2.menahub.com/rest/default/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[pageSize]=20&searchCriteria[filter_groups][0][filters][0][value]=${widget.searchId}&searchCriteria[current_page]=$page';
    http.Response response = await http.get(
      Uri.parse(url),
    );
    Map responseMap = jsonDecode(response.body);
    List itemList = responseMap["items"];
    List productList = [];
    setState(() {
      for (Map item in itemList) {
        List customAttributes = item["custom_attributes"];
        int producImageIndex =
            customAttributes.indexWhere((f) => f['attribute_code'] == "image");
        Map productDescriptionMap = customAttributes[producImageIndex.abs()];
        var productImage = productDescriptionMap["value"];

        productList.add({
          "id": item["id"].toString(),
          "name": item["name"].toString(),
          "sku": item["sku"].toString(),
          "price": item["price"].toString(),
          "productImage": productImage.toString(),
        });
      }
    });

    Map valueCallBack = {
      "itemCount": productList.length,
      "totalCount": responseMap["total_count"]
    };
    widget.onstate(valueCallBack, false);
    return {"totalCount": responseMap["total_count"], "items": productList};
  }

  List listItemsGetter(productListModel) {
    return productListModel["items"];
  }

  Widget listItemBuilder(value, int index) {
    bool wishlistStatus = false;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ParticularProductsDetailsScreen(
              productSkuId: value["sku"],
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
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                      image:
                          NetworkImage("$imageBaseUrl${value["productImage"]}"),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: null,
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  children: [
                    Text(
                      value["name"],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    sizedBoxheight5,
                    Row(
                      children: [
                        Text(
                          "QAR ${value["price"]}",
                          style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        sizedBoxwidth10,
                        Text(
                          "QAR 699.00",
                          style: TextStyle(
                              color: greyColor,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w600),
                        ),
                        sizedBoxwidth10,
                        Text(
                          "7% off",
                          style: TextStyle(
                              color: greyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
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
                                  value["id"].toString(), !wishlistStatus);
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

  Widget loadingWidgetMaker() {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: CustomerLoader(
        dotType: DotType.circle,
        dotOneColor: secondaryColor,
        dotTwoColor: primaryColor,
        dotThreeColor: Colors.red,
        duration: Duration(milliseconds: 1000),
      ),
    );
  }

  Widget errorWidgetMaker(productListModel, retryListener) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(productListModel.toString()),
        ),
        // ignore: deprecated_member_use
        FlatButton(
          onPressed: retryListener,
          child: Text('Retry'),
        )
      ],
    );
  }

  Widget emptyListWidgetMaker(productListModel) {
    // product list can empty
    return Center(
      child: Text('list empty'),
    );
  }

  int totalPagesGetter(productListModel) {
    // to add product total count
    return productListModel["totalCount"];
  }

  bool pageErrorChecker(productListModel) {
    /// to add api status
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Paginator.listView(
      key: paginatorGlobalKey,
      pageLoadFuture: sendCountriesDataRequest,
      pageItemsGetter: listItemsGetter,
      listItemBuilder: listItemBuilder,
      loadingWidgetBuilder: loadingWidgetMaker,
      errorWidgetBuilder: errorWidgetMaker,
      emptyListWidgetBuilder: emptyListWidgetMaker,
      totalItemsGetter: totalPagesGetter,
      pageErrorChecker: pageErrorChecker,
      scrollPhysics: BouncingScrollPhysics(),
    );
  }
}
