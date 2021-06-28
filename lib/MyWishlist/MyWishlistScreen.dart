import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:menahub/DashBoard/MyCartScreen/MyCartScreen.dart';
import 'package:menahub/ProductsDetails/ParticularProductsDetailsScreen.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/config/CustomLoader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:menahub/translation/codegen_loader.g.dart';
import 'package:menahub/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class MyWishlistScreen extends StatefulWidget {
  @override
  _MyWishlistScreenState createState() => _MyWishlistScreenState();
}

class _MyWishlistScreenState extends State<MyWishlistScreen> {
  String errorMessage;
  bool errorStatus = false;

  List _items = [];
  var cartCount = 0;

  @override
  void initState() {
    super.initState();
    getValues();
    getCartCount();
  }

  getCartCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };

    ApiResponseModel response = await getApiCall(
      getUrl: cartsUrl,
      headers: headers,
      context: context,
    );
    Map responseData = response.responseValue;
    if (response.statusCode == 200) {
      List cartList = responseData["items"];
      print(cartList.length);
      setState(() {
        cartCount = cartList.length;
      });
    } else {}
  }

  getValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    ApiResponseModel responseData = await getApiCall(
      getUrl: wishlistUrl,
      headers: headers,
      context: context,
    );
    if (responseData.statusCode == 200) {
      Map data = responseData.responseValue;
      List itemsList = data["items"];
      setState(() {
        _items = itemsList;
      });
    } else {
      Map response = responseData.responseValue;
      String errorMessage = response["message"];
      // Alert(
      //   context: context,
      //   title: "",
      //   desc: errorMessage,
      // ).show();
      // errorAlert(context: context, errorMessage: errorMessage);
      print(errorMessage);
      setState(() {
        errorStatus = true;
        errorMessage = errorMessage;
      });
    }
  }

  removeWishlish({String productId, BuildContext contexts}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final progress = ProgressHUD.of(contexts);
    progress.show();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    var body = jsonEncode({});
    ApiResponseModel responseData = await postApiCall(
      postUrl: "$removeWishlistUrl$productId",
      headers: headers,
      context: context,
      body: body,
    );
    if (responseData.statusCode == 200) {
      setState(() {
        getValues();
        progress.dismiss();
      });
    } else {
      progress.dismiss();
    }
  }

  addToCart({String sku, String qty, BuildContext contexts}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final progress = ProgressHUD.of(contexts);
    progress.show();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    ApiResponseModel quoteResponseData = await postApiCall(
      postUrl: getQuoteIdUrl,
      headers: headers,
      context: context,
    );
    if (quoteResponseData.statusCode == 200) {
      var body = jsonEncode({
        "cartItem": {
          "sku": sku,
          "qty": qty,
          "quote_id": quoteResponseData.responseValue
        }
      });
      ApiResponseModel responseData = await postApiCall(
        postUrl: addCartUrl,
        headers: headers,
        context: context,
        body: body,
      );
      print(responseData.responseValue);
      if (responseData.statusCode == 200) {
        setState(() {
          progress.dismiss();
        });
      } else {
        progress.dismiss();
      }
    }
  }

  wishlistItem(
      {Map values, BuildContext context, String productId, String qty}) {
    List customAttributes = values["custom_attributes"];
    Map productImageMap = customAttributes[1];
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ParticularProductsDetailsScreen(
              productSkuId: values["sku"],
            ),
          ),
        );
      },
      child: Container(
        color: whiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: whiteColor,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              height: 80,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "$imageBaseUrl${productImageMap["value"]}"),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              child: null,
                            ),
                            sizedBoxwidth10,
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                values["name"],
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            // InkWell(
                                            //   onTap: () {
                                            //     removeWishlish(
                                            //         productId: productId,
                                            //         contexts: context);
                                            //   },
                                            //   child: Image.asset(
                                            //     "assets/icon/deleteIcon.png",
                                            //     height: 25,
                                            //     width: 25,
                                            //   ),
                                            // )
                                          ],
                                        ),
                                        // sizedBoxheight5,
                                        // Row(
                                        //   children: [
                                        //     Text(
                                        //       "Brands: ",
                                        //       style: TextStyle(
                                        //           fontSize: 12,
                                        //           fontWeight: FontWeight.w600),
                                        //     ),
                                        //     Text(
                                        //       "Lenovo",
                                        //       style: TextStyle(
                                        //           fontSize: 12,
                                        //           color: secondaryColor,
                                        //           fontWeight: FontWeight.w600),
                                        //     )
                                        //   ],
                                        // ),
                                        sizedBoxheight10,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "QAR ${values['price'].toStringAsFixed(2).toString()}",
                                              style: TextStyle(
                                                color: secondaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),

                                            // InkWell(
                                            //   onTap: () {
                                            //     addToCart(
                                            //       qty: qty,
                                            //       sku: values["sku"],
                                            //       contexts: context,
                                            //     );
                                            //   },
                                            //   child: Container(
                                            //     decoration: BoxDecoration(
                                            //         color: primaryColor,
                                            //         borderRadius:
                                            //             BorderRadius.circular(
                                            //                 50)),
                                            //     child: Padding(
                                            //       padding:
                                            //           const EdgeInsets.only(
                                            //               left: 15,
                                            //               right: 15,
                                            //               top: 10,
                                            //               bottom: 10),
                                            //       child: Text(
                                            //         "MOVE TO CART",
                                            //         style: TextStyle(
                                            //           color: whiteColor,
                                            //           fontWeight:
                                            //               FontWeight.w600,
                                            //           fontSize: 12,
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: Locale(context.locale.languageCode),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: appBarColor,
          brightness: lightBrightness,
          title: Text(
            LocaleKeys.My_Wishlist.tr(),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => MyCartScreen(),
                //   ),
                // );
              },
              child: Icon(
                Icons.search,
                size: 25,
              ),
            ),
            sizedBoxwidth10,
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyCartScreen(
                      router: "nav",
                    ),
                  ),
                );
              },
              child: Badge(
                  padding: EdgeInsets.all(5),
                  badgeColor: redColor,
                  position: BadgePosition(top: 5, end: 0),
                  badgeContent: Text(
                    cartCount.toString(),
                    style: TextStyle(
                      fontSize: 10,
                      color: whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    size: 25,
                  )),
            ),
            sizedBoxwidth10
          ],
        ),
        // bottomNavigationBar: SafeArea(
        //   child: Container(
        //     height: 50,
        //     padding: EdgeInsets.only(
        //       top: 7,
        //       bottom: 7,
        //     ),
        //     color: whiteColor,
        //     width: MediaQuery.of(context).size.width,
        //     child: InkWell(
        //       onTap: () {},
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Container(
        //             width: MediaQuery.of(context).size.width / 2,
        //             child: customButton(
        //               title: "CLEAR ALL",
        //               backgroundColor: secondaryColor,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        body: ProgressHUD(
          child: Builder(
            builder: (context) => Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: HexColor("#F1F3F6"),
              child: _items.isEmpty == true
                  ? Center(
                      child: CustomerLoader(
                        dotType: DotType.circle,
                        dotOneColor: secondaryColor,
                        dotTwoColor: primaryColor,
                        dotThreeColor: Colors.red,
                        duration: Duration(milliseconds: 1000),
                      ),
                    )
                  : Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          return wishlistItem(
                            values: _items[index]["product"],
                            context: context,
                            productId: _items[index]["id"].toString(),
                            qty: _items[index]["qty"].toString(),
                          );
                        },
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
