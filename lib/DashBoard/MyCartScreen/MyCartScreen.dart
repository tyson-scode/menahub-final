import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:menahub/Address/SelectAddressScreen.dart';
import 'package:menahub/CustomWidget/CustomButton.dart';
import 'package:menahub/DashBoard/DashBoard.dart';
import 'package:menahub/ProductsDetails/ParticularProductsDetailsScreen.dart';
import 'package:menahub/Template/CardItem.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/Util/widgets/MySeparator.dart';
import 'package:menahub/config/CustomLoader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:menahub/Models/ConfigCartModel.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class MyCartScreen extends StatefulWidget {
  final String router;
  MyCartScreen({this.router});
  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  List _items = [];
  Map totalCartDetails;
  String cartId;
  String errorMessage = "";
  bool loaderStatus = false;
  TextEditingController couponCodeTextField = TextEditingController();
  bool couponCodeUsed;
  bool userType;

  @override
  void initState() {
    super.initState();
    getLocalInformation();
  }

  getLocalInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String type = prefs.getString("userType");
    if (type == "guest") {
      setState(() {
        userType = true;
        getGuestCartList();
      });
    } else {
      setState(() {
        userType = false;
        getCartList();
      });
    }
    print(userType);
  }

  getGuestCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("guestId");
    print(token);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    ApiResponseModel response = await getApiCall(
      getUrl:
          "http://magento2blog.thestagings.com/rest/default/V1/guest-carts/$token/totals",
      headers: headers,
      context: context,
    );
    Map responseData = response.responseValue;
    if (response.statusCode == 200) {
      List cartList = responseData["items"];
      print(cartList.length);
      setState(() {
        _items = cartList;
        totalCartDetails = responseData;
        loaderStatus = true;
      });
    } else {
      setState(() {
        //errorMessage = responseData["message"];
        errorMessage = "Cart is Empty.Please Add Items....";
        loaderStatus = true;
      });
    }
  }

  deleteGuestCartlist({String productId, BuildContext contexts}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final progress = ProgressHUD.of(contexts);
    progress.show();
    var token = prefs.get("guestId");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({});
    ApiResponseModel responseData = await deleteApiCall(
      postUrl:
          "http://magento2blog.thestagings.com/rest/default/V1/guest-carts/$token/items/$productId",
      headers: headers,
      context: context,
      body: body,
    );
    print(responseData.responseValue);
    if (responseData.statusCode == 200) {
      setState(() {
        getGuestCartList();
        progress.dismiss();
      });
    } else {
      progress.dismiss();
    }
  }

  getCartList() async {
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
        _items = cartList;
        totalCartDetails = responseData;
        loaderStatus = true;
      });
    } else {
      setState(() {
        //errorMessage = responseData["message"];
        errorMessage = "Cart is Empty.Please Add Items....";
        loaderStatus = true;
      });
    }
  }

  addWishlist({String productId, BuildContext contexts}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final progress = ProgressHUD.of(contexts);
    progress.show();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    var body = jsonEncode({"buy_request": 0});
    ApiResponseModel responseData = await putApiCall(
      postUrl: "$addWishlistUrl$productId",
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

  deleteCartlist({String productId, BuildContext contexts}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final progress = ProgressHUD.of(contexts);
    progress.show();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    var body = jsonEncode({});
    ApiResponseModel responseData = await deleteApiCall(
      postUrl: "$removeCartUrl$productId",
      headers: headers,
      context: context,
      body: body,
    );
    print(responseData.responseValue);
    if (responseData.statusCode == 200) {
      setState(() {
        getCartList();
        progress.dismiss();
      });
    } else {
      progress.dismiss();
    }
  }

  cartConfig({ConfigCartModel productDetails, BuildContext contexts}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final progress = ProgressHUD.of(contexts);
    progress.show();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    if (cartId != null) {
      var body = jsonEncode({
        "cartItem": {
          "sku": productDetails.sku,
          "qty": productDetails.qty,
          "quote_id": cartId
        }
      });
      ApiResponseModel responseData = await postApiCall(
        postUrl: cartconfig,
        headers: headers,
        context: context,
        body: body,
      );
      print(responseData.responseValue);
      if (responseData.statusCode == 200) {
        progress.dismiss();
      } else {
        progress.dismiss();
      }
    } else {
      ApiResponseModel quoteResponseData = await postApiCall(
        postUrl: getQuoteIdUrl,
        headers: headers,
        context: context,
      );
      if (quoteResponseData.statusCode == 200) {
        setState(() {
          cartId = quoteResponseData.responseValue.toString();
        });
        var body = jsonEncode({
          "cartItem": {
            "sku": productDetails.sku,
            "qty": productDetails.qty,
            "quote_id": quoteResponseData.responseValue
          }
        });
        ApiResponseModel responseData = await postApiCall(
          postUrl: cartconfig,
          headers: headers,
          context: context,
          body: body,
        );
        print(responseData.responseValue);
        if (responseData.statusCode == 200) {
          progress.dismiss();
        } else {
          progress.dismiss();
        }
      }
    }
  }

  applycoupon({String couponCode, BuildContext contexts}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final progress = ProgressHUD.of(contexts);
    progress.show();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    var body = jsonEncode({});
    ApiResponseModel responseData = await putApiCall(
      postUrl: "$couponApi$couponCode",
      headers: headers,
      context: context,
      body: body,
    );
    print(responseData.responseValue);
    if (responseData.statusCode == 200) {
      setState(() {
        progress.dismiss();
        couponCodeUsed = true;
      });
    } else {
      progress.dismiss();
      setState(() {
        couponCodeUsed = false;
      });
    }
  }

  navigationViewAllProduct(String value) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ParticularProductsDetailsScreen(
          productSkuId: value,
        ),
      ),
    );
  }

  navigationDashBoard() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => DashBoard(
          initialIndex: 0,
        ),
      ),
    );
  }

  navigationToCheckOut() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectAddressScreen(
          cartId: cartId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: widget.router == "nav"
            ? AppBar(
                backgroundColor: primaryColor,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text("My Cart"),
              )
            : null,
        body: ProgressHUD(
          child: Builder(
            builder: (context) => Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: HexColor("#F1F3F6"),
              child: loaderStatus == false
                  ? Center(
                      child: CustomerLoader(
                        dotType: DotType.circle,
                        dotOneColor: secondaryColor,
                        dotTwoColor: primaryColor,
                        dotThreeColor: Colors.red,
                        duration: Duration(milliseconds: 1000),
                      ),
                    )
                  : _items.isEmpty == true
                      ? Center(
                          child: Text(
                          errorMessage,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ))
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                color: HexColor("#F1F3F6"),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: _items.length,
                                  itemBuilder: (context, index) {
                                    return CartItem(
                                      productDetails: _items[index],
                                      context: context,
                                      onstate: (value, checkstate, status) {
                                        if (checkstate == "next") {
                                          navigationViewAllProduct(value);
                                        } else {
                                          if (status) {
                                            cartConfig(
                                                productDetails: value,
                                                contexts: context);
                                          } else {
                                            if (userType) {
                                              deleteGuestCartlist(
                                                  productId: value,
                                                  contexts: context);
                                            } else {
                                              deleteCartlist(
                                                  productId: value,
                                                  contexts: context);
                                            }
                                          }
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                              sizedBoxheight20,
                              Container(
                                height: 70,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          decoration: BoxDecoration(
                                            color: whiteColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(50),
                                              bottomLeft: Radius.circular(50),
                                            ),
                                          ),
                                          child: TextFormField(
                                            controller: couponCodeTextField,
                                            style: TextStyle(
                                              color: couponCodeUsed == true
                                                  ? primaryColor
                                                  : secondaryColor,
                                            ),
                                            decoration: new InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, right: 15),
                                              hintText: "Enter Coupon code",
                                              hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: greyColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        sizedBoxwidth5,
                                        InkWell(
                                          onTap: () {
                                            if (couponCodeTextField.text
                                                    .toString()
                                                    .isNotEmpty ==
                                                true) {
                                              applycoupon(
                                                contexts: context,
                                                couponCode: couponCodeTextField
                                                    .text
                                                    .trim(),
                                              );
                                            } else if (couponCodeTextField.text
                                                    .toString()
                                                    .isNotEmpty ==
                                                false) {
                                              Fluttertoast.showToast(
                                                msg:
                                                    "Please Enter The Coupon Code",
                                                // toastLength: Toast.LENGTH_LONG,
                                                // gravity: ToastGravity.CENTER,
                                                // timeInSecForIosWeb: 10,
                                                // backgroundColor: Colors.red,
                                                // textColor: Colors.white,
                                                // fontSize: 16.0,
                                              );
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              color: secondaryColor,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(50),
                                                bottomRight:
                                                    Radius.circular(50),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Apply",
                                                style: TextStyle(
                                                    color: whiteColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (couponCodeUsed == true)
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(
                                              "Coupon Code Applied!",
                                              style: TextStyle(
                                                color: secondaryColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    else if (couponCodeUsed == false)
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 10),
                                            child: Text(
                                              "Please enter valid Coupon Code!",
                                              style: TextStyle(
                                                color: secondaryColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              sizedBoxheight20,
                              if (totalCartDetails != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 30.0, top: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: whiteColor,
                                        border: Border.all(color: greyColor)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 15, 0, 00),
                                          child: Text("PRICE DETAILS",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                        Divider(
                                          thickness: 2,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Sub Total (4 items)",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                "QAR ${totalCartDetails["subtotal"]}",
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        MySeparator(
                                          color: greyColor,
                                          height: 2,
                                        ),
                                        sizedBoxheight10,
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Grand Total",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "QAR ${totalCartDetails["grand_total"]}",
                                                style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              Container(
                                height: 50,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {},
                                          child: InkWell(
                                            onTap: () {
                                              navigationDashBoard();
                                            },
                                            child: customButton(
                                              title: "CONTINUE SHOPPING",
                                              fontSize: 12,
                                              backgroundColor: primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      sizedBoxwidth20,
                                      Expanded(
                                        child: userType == true
                                            ? Container()
                                            : _items.isNotEmpty == true
                                                ? InkWell(
                                                    onTap: () {
                                                      navigationToCheckOut();
                                                    },
                                                    child: customButton(
                                                      title: "CHECKOUT",
                                                      fontSize: 12,
                                                      backgroundColor:
                                                          secondaryColor,
                                                    ),
                                                  )
                                                : Container(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              sizedBoxheight20,
                            ],
                          ),
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
