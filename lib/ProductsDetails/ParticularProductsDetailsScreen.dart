import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:menahub/CustomWidget/CustomButton.dart';
import 'package:menahub/DashBoard/MyCartScreen/MyCartScreen.dart';
import 'package:menahub/SearchScreen/SearchScreen.dart';
import 'package:menahub/SignIn_SignUp_Flow/SignInScreen/SignInScreen.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/config/CustomLoader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SellerListScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ParticularProductsDetailsScreen extends StatefulWidget {
  ParticularProductsDetailsScreen({this.productSkuId, this.apiType});

  final String apiType;
  final productSkuId;

  @override
  _ParticularProductsDetailsScreenState createState() =>
      _ParticularProductsDetailsScreenState();
}

class _ParticularProductsDetailsScreenState
    extends State<ParticularProductsDetailsScreen> {
  String details;
  String errorMessage;
  List<String> imgList = [];
  int productCount = 1;
  String productDescription;
  List productDetailsList = ["", "", "", ""];
  Map productDetials;
  List sellerDataList = [];
  bool userType;
  var cartCount = 0;
  int _current = 0;
  var specialPrice;

  @override
  void initState() {
    getLocalInformation();
    getProductDetails();
    super.initState();
  }

  getLocalInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String type = prefs.getString("userType");
    if (type == "guest") {
      setState(() {
        userType = true;
        getGuestCartCount();
      });
    } else {
      setState(() {
        getCartCount();
        userType = false;
      });
    }
    print(userType);
  }

  getProductDetails() async {
    ApiResponseModel response;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (widget.apiType == "id") {
      response = await getApiCall(
        getUrl: "$productViewByIdApi${widget.productSkuId}",
        headers: headers,
        context: context,
      );
    } else {
      response = await getApiCall(
        getUrl: "$productsDetailsUrl${widget.productSkuId}",
        headers: headers,
        context: context,
      );
    }

    Map productDetails = response.responseValue;
    if (response.statusCode == 200) {
      List bannerImageList = productDetails["media_gallery_entries"];
      setState(() {
        this.productDetials = productDetails;
        List imageList =
            bannerImageList.map((e) => e["file"].toString()).toList();
        imgList = imageList;
        List customAttributes = productDetails["custom_attributes"];
        int descriptionIndex = customAttributes
            .indexWhere((f) => f['attribute_code'] == "description");
        int productDetailsIndex = customAttributes
            .indexWhere((f) => f['attribute_code'] == "product_details");
        Map productDescriptionMap = customAttributes[descriptionIndex.abs()];
        productDescription = productDescriptionMap["value"];
        Map productDetailsMap = customAttributes[productDetailsIndex.abs()];
        details = productDetailsMap["value"];
        Map extensionAttributes = productDetails["extension_attributes"];
        for (var item in customAttributes) {
          if (item["attribute_code"] == "special_price") {
            specialPrice = item["value"];
          }
        }
        if (widget.apiType != "id") {
          sellerDataList = extensionAttributes["assigned_seller_data"];
        }
      });
    } else {
      Map errorMessage = response.responseValue;
      setState(() {
        this.errorMessage = errorMessage["message"];
      });
    }
  }

  addToCart({String sku, String qty, BuildContext contexts}) async {
    final progress = ProgressHUD.of(contexts);
    progress.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    ApiResponseModel quoteResponseData = await postApiCall(
      postUrl: getQuoteIdUrl,
      headers: headers,
      context: contexts,
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
        context: contexts,
        body: body,
      );
      print(responseData.responseValue);

      if (responseData.statusCode == 200) {
        setState(() {
          progress.dismiss();
          Fluttertoast.showToast(
            msg: "Product successfully added to cart",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          if (userType == true) {
            getGuestCartCount();
          } else {
            progress.dismiss();

            getCartCount();
          }
        });
      } else {
        progress.dismiss();
      }
    }
  }
  // addToCart({String sku, String qty, BuildContext contexts}) async {
  //   //EasyLoading.show(status: 'loading...');
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var token = prefs.get("token");
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': "Bearer $token"
  //   };
  //
  //   http.Response response = await http.post(
  //     Uri.parse("https://uat2.menahub.com/rest/default/V1/carts/mine/"),
  //     headers: headers,
  //   );
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     var body = jsonEncode({
  //       "cartItem": {
  //         "sku": sku,
  //         "qty": qty,
  //         "quote_id": response.body.toString()
  //       }
  //     });
  //     http.Response responsecart = await http.post(
  //         Uri.parse(
  //             "https://uat2.menahub.com/rest/default/V1/carts/mine/items"),
  //         headers: headers,
  //         body: body);
  //     print(responsecart.statusCode);
  //     if (responsecart.statusCode == 200) {
  //       //EasyLoading.dismiss();
  //       print("Product successfully added to cart");
  //       Fluttertoast.showToast(
  //         msg: "Product successfully added to cart",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.black,
  //         textColor: Colors.white,
  //         fontSize: 16.0,
  //       );
  //     } else {
  //       // EasyLoading.dismiss();
  //       // EasyLoading.showError(responesData["message"].toString());
  //     }
  //   }
  // }

  reduceToCart(
      {String sku, String qty, BuildContext contexts, String cartId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final progress = ProgressHUD.of(contexts);
    progress.show();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    ApiResponseModel quoteResponseData = await putApiCall(
      postUrl: getQuoteIdUrl,
      headers: headers,
      context: contexts,
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
        postUrl: reduceCartApi,
        headers: headers,
        context: contexts,
        body: body,
      );
      print(responseData.responseValue);
      if (responseData.statusCode == 200) {
        setState(() {
          progress.dismiss();
          Fluttertoast.showToast(
            msg: "Product successfully added to cart",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        });
      } else {
        progress.dismiss();
      }
    }
  }

  guestAddToCart({String sku, String qty, BuildContext contexts}) async {
    final progress = ProgressHUD.of(contexts);
    progress.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("guestId");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    var body = jsonEncode({
      "cartItem": {"sku": sku, "qty": qty, "quote_id": token}
    });
    ApiResponseModel responseData = await postApiCall(
      postUrl: "$createEmptyCart/$token/items",
      headers: headers,
      context: contexts,
      body: body,
    );
    print(responseData.responseValue);
    if (responseData.statusCode == 200) {
      setState(() {
        progress.dismiss();
        Fluttertoast.showToast(
          msg: "Product successfully added to cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        if (userType == true) {
          getGuestCartCount();
        } else {
          progress.dismiss();

          getCartCount();
        }
      });
    } else {
      progress.dismiss();
    }
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

  getGuestCartCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("guestId");
    print(token);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    ApiResponseModel response = await getApiCall(
      getUrl:
          "https://uat2.menahub.com/rest/default/V1/guest-carts/$token/totals",
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ),
                    );
                  }),
              sizedBoxwidth5,
              InkWell(
                onTap: () {
                  if (userType == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignIn(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyCartScreen(
                          router: "nav",
                        ),
                      ),
                    );
                  }
                },
                child: Badge(
                    padding: EdgeInsets.all(4.5),
                    badgeColor: redColor,
                    position: BadgePosition(top: 7, end: 0),
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
          body: ProgressHUD(
            child: Builder(
              builder: (context) => Container(
                height: double.infinity,
                width: double.infinity,
                child: Container(
                  child: errorMessage != null
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              errorMessage,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      : productDetials == null
                          ? Center(
                              child: CustomerLoader(
                                dotType: DotType.circle,
                                dotOneColor: secondaryColor,
                                dotTwoColor: primaryColor,
                                dotThreeColor: Colors.red,
                                duration: Duration(milliseconds: 1000),
                              ),
                            )
                          : Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //slider
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: CarouselSlider(
                                              items: imgList
                                                  .map(
                                                    (item) => Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: ClipRRect(
                                                        child: Image.network(
                                                            "$imageBaseUrl$item",
                                                            fit: BoxFit.contain,
                                                            width: 1000.0),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              options: CarouselOptions(
                                                pageSnapping: true,
                                                autoPlay: true,
                                                // enlargeCenterPage: true,
                                                // aspectRatio: 2.0,
                                                viewportFraction: 1.0,
                                                onPageChanged: (index, reason) {
                                                  setState(() {
                                                    _current = index;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1,
                                        ),
                                        //indicator
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          alignment: Alignment.bottomCenter,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: imgList.map((url) {
                                              int index = imgList.indexOf(url);
                                              return Container(
                                                width: 8.0,
                                                height: 8.0,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 2.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: _current == index
                                                      ? secondaryColor
                                                      : lightGreyColor,
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        sizedBoxheight10,
                                        productDetials != null
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0),
                                                child: Text(
                                                  productDetials["name"],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        sizedBoxheight10,
                                        // Padding(
                                        //   padding: const EdgeInsets.only(left: 20.0),
                                        //   child: Text(
                                        //     "Available For Quote",
                                        //     style: TextStyle(
                                        //       color: secondaryColor,
                                        //       fontWeight: FontWeight.w600,
                                        //       decoration: TextDecoration.underline,
                                        //     ),
                                        //   ),
                                        // ),
                                        if (productDetials != null)
                                          if (productDetials["price"] != 0)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "QAR ${productDetials["price"]}",
                                                    style: TextStyle(
                                                      color: secondaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  sizedBoxwidth10,
                                                  if (specialPrice != null)
                                                    Text(
                                                      "QAR ${productDetials["price"]}",
                                                      style: TextStyle(
                                                        color: greyColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                  // sizedBoxwidth10,
                                                  // Text(
                                                  //   "7% off",
                                                  //   style: TextStyle(
                                                  //     color: greyColor,
                                                  //     fontWeight:
                                                  //         FontWeight.w600,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            )
                                          else
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Available For Quote",
                                                    style: TextStyle(
                                                      color: secondaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                        else
                                          Container(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, top: 10),
                                          child: Row(
                                            children: [
                                              Text("QTY"),
                                              sizedBoxwidth10,
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                lightGreyColor,
                                                            width: 2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              if (productCount !=
                                                                  1) {
                                                                productCount -=
                                                                    1;
                                                              }
                                                            });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10,
                                                                    right: 10,
                                                                    top: 5,
                                                                    bottom: 5),
                                                            child: Text("-"),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 5,
                                                                  bottom: 5),
                                                          child: Text(
                                                              productCount
                                                                  .toString()),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              productCount += 1;
                                                            });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10,
                                                                    right: 10,
                                                                    top: 5,
                                                                    bottom: 5),
                                                            child: Text("+"),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  sizedBoxwidth30,
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1,
                                        ),
                                        // Container(
                                        //   child: ListView.builder(
                                        //     shrinkWrap: true,
                                        //     physics: NeverScrollableScrollPhysics(),
                                        //     scrollDirection: Axis.vertical,
                                        //     itemCount: productDetailsList.length,
                                        //     itemBuilder: (context, index) {
                                        //       return Container(
                                        //         child: Padding(
                                        //           padding: const EdgeInsets.only(
                                        //               left: 20.0, bottom: 5, right: 20),
                                        //           child: Row(
                                        //             children: [
                                        //               Text("Brands :"),
                                        //               sizedBoxwidth10,
                                        //               Expanded(
                                        //                 child: Text(
                                        //                     "MediaTek Helio P22T (8C, 8xA53 @2.3GHZ)"),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       );
                                        //     },
                                        //   ),
                                        // ),
                                        // Padding(
                                        //   padding:
                                        //       const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                        //   child: Html(
                                        //     data: details,
                                        //   ),
                                        // ),
                                        // sizedBoxheight5,
                                        // Divider(
                                        //   thickness: 1,
                                        // ),
                                        if (sellerDataList.isNotEmpty == true)
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${sellerDataList.length} More Sellors",
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            SellerListScreen(
                                                          sellerDataList:
                                                              sellerDataList,
                                                          productDetails:
                                                              productDetials,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          15, 5, 15, 5),
                                                      child: Text(
                                                        "View All Sellers",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .blueAccent),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        if (sellerDataList.isNotEmpty == true)
                                          Divider(),
                                        productDescription != null
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    bottom: 0),
                                                child: Html(
                                                  data: productDescription,
                                                ),
                                              )
                                            : Container(),
                                        // InkWell(
                                        //   onTap: () {
                                        //     Navigator.push(
                                        //       context,
                                        //       MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             ReviewScreen(
                                        //           productId:
                                        //               productDetials["id"],
                                        //         ),
                                        //       ),
                                        //     );
                                        //   },
                                        //   child: Container(
                                        //     child: Column(
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.center,
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.center,
                                        //       children: [
                                        //         Divider(color: Colors.blue),
                                        //         Text(
                                        //           "View All Reviews",
                                        //           style: TextStyle(
                                        //               color: Colors.blueAccent),
                                        //         ),
                                        //         Divider(color: Colors.blue)
                                        //       ],
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  height: 50,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                    child: Row(
                                      children: [
                                        if (productDetials["price"] != 0)
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                if (userType != true) {
                                                  addToCart(
                                                      qty: productCount
                                                          .toString(),
                                                      sku:
                                                          productDetials["sku"],
                                                      contexts: context);
                                                  getCartCount();
                                                } else {
                                                  guestAddToCart(
                                                      qty: productCount
                                                          .toString(),
                                                      sku:
                                                          productDetials["sku"],
                                                      contexts: context);
                                                  getGuestCartCount();
                                                }
                                              },
                                              child: customButton(
                                                title: "ADD TO CART",
                                                backgroundColor: primaryColor,
                                              ),
                                            ),
                                          ),
                                        sizedBoxwidth30,
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {},
                                            child: customButton(
                                              title: "Enquire Now",
                                              backgroundColor: secondaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                ),
              ),
            ),
          ),
        ));
  }
}
