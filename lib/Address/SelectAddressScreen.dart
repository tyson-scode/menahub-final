import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:menahub/CustomWidget/CustomButton.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/config/AppLoader.dart';
import 'package:menahub/config/CustomLoader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AddNewAddressScreen.dart';
import 'PaymentMethodChoose.dart';

class SelectAddressScreen extends StatefulWidget {
  final String cartId;
  final String router;

  SelectAddressScreen({this.cartId, this.router});
  @override
  _SelectAddressScreenState createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  List addressList = [];
  List addressListID = [];

  bool apiLoader = false;
  Map selectAddressDetails;
  int selectIndex;
  int value;
  String method_code;
  String carrier_code;
  @override
  void initState() {
    super.initState();
    getAddressList();
  }

  deleteAddress({String addressId, BuildContext contexts}) async {
    final overlay = LoadingOverlay.of(context);
    overlay.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    var body = jsonEncode({});
    ApiResponseModel responseData = await deleteApiCall(
      postUrl: "$deleteAddressApi$addressId",
      headers: headers,
      context: context,
      body: body,
    );
    //Navigator.of(context).pop();

    print(responseData.responseValue);
    if (responseData.statusCode == 200) {
      setState(() {
        getAddressList();
        overlay.hide();
      });
    } else {
      overlay.hide();
      // Navigator.of(context).pop();

    }
  }

  getAddressList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    ApiResponseModel responseData = await getApiCall(
      getUrl: "$addressDetailsApi",
      headers: headers,
      context: context,
    );
    print(responseData.responseValue);
    if (responseData.statusCode == 200) {
      Map addressDetails = responseData.responseValue;
      List itemList = addressDetails["addresses"];
      setState(() {
        addressList = itemList;
        apiLoader = true;
      });
    } else {
      setState(() {
        apiLoader = true;
      });
    }
  }

  estimateShippingMethod(BuildContext _context) async {
    final overlay = LoadingOverlay.of(context);
    overlay.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    if (selectAddressDetails == null) {
      Map addressDetails = addressList[0];
      Map regionMap = addressDetails["region"];
      selectAddressDetails = {
        "customer_id": addressDetails["customer_id"],
        "street": addressDetails["street"],
        "city": addressDetails["city"],
        "region": regionMap["regionMap"],
        "country_id": addressDetails["country_id"],
        "postcode": addressDetails["postcode"],
        "firstname": addressDetails["firstname"],
        "lastname": addressDetails["lastname"],
        "company": addressDetails["company"],
        "telephone": addressDetails["telephone"],
        "save_in_address_book": "1"
      };
    }

    var body = jsonEncode({"address": selectAddressDetails});
    ApiResponseModel responseData = await postApiCall(
      postUrl: "$estimateShippingMethodsApi",
      headers: headers,
      context: context,
      body: body,
    );
    print(responseData.responseValue);
    if (responseData.statusCode == 200) {
      overlay.hide();
      // Navigator.of(context).pop();
      List responseList = responseData.responseValue;
      Map responseMap = responseList[0];
      print("responseMap: " + responseMap.toString());
      shippingInformation(
          estimateShippingResponse: responseMap,
          shippingAddress: selectAddressDetails);
      // progress.dismiss();
    } else {
      //  progress.dismiss();
      overlay.hide();
      // Navigator.of(context).pop();
    }
  }

  shippingInformation(
      {Map estimateShippingResponse, Map shippingAddress}) async {
    final overlay = LoadingOverlay.of(context);
    overlay.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    var body = jsonEncode({
      "addressInformation": {
        "shipping_address": {
          "customerAddressId": shippingAddress["save_in_address_book"],
          "countryId": shippingAddress["country_id"],
          "regionCode": "DOHA", // shippingAddress["region"],
          "region": "DOHA", // shippingAddress["region"],
          "customerId": shippingAddress["customer_id"],
          "street": shippingAddress["street"],
          "company": shippingAddress["company"],
          "telephone": shippingAddress["telephone"],
          "fax": null,
          "postcode": shippingAddress["postcode"],
          "city": shippingAddress["city"],
          "firstname": shippingAddress["firstname"],
          "lastname": shippingAddress["lastname"],
          "middlename": null,
          "prefix": null,
          "suffix": null,
          "vatId": null,
          "customAttributes": []
        },
        "billing_address": {
          "customerAddressId": shippingAddress["save_in_address_book"],
          "countryId": shippingAddress["country_id"],
          "regionCode": shippingAddress["region"],
          "region": shippingAddress["region"],
          "customerId": shippingAddress["customer_id"],
          "street": shippingAddress["street"],
          "company": shippingAddress["company"],
          "telephone": shippingAddress["telephone"],
          "fax": null,
          "postcode": shippingAddress["postcode"],
          "city": shippingAddress["city"],
          "firstname": shippingAddress["firstname"],
          "lastname": shippingAddress["lastname"],
          "middlename": null,
          "prefix": null,
          "suffix": null,
          "vatId": null,
          "customAttributes": [],
          "saveInAddressBook": null
        },
        "shipping_method_code": estimateShippingResponse["method_code"],
        "shipping_carrier_code": estimateShippingResponse["carrier_code"],
        "extension_attributes": {}
      }
    });
    print(body);
    ApiResponseModel responseData = await postApiCall(
      postUrl: "$shippingInformationApi",
      headers: headers,
      context: context,
      body: body,
    );
    print(responseData.responseValue);
    Navigator.of(context).pop();

    if (responseData.statusCode == 200) {
      overlay.hide();
      Map responseMap = responseData.responseValue;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentMethodChoose(
            screenInfo: responseMap,
            billingAddress: shippingAddress,
            cartId: widget.cartId,
          ),
        ),
      );
    } else {
      overlay.hide();
      Navigator.of(context).pop();
    }
  }

  addressCart({
    Map addressDetails,
    BuildContext context,
    int index,
  }) {
    return InkWell(
      onTap: () async {
        print(addressDetails);
        selectIndex = index;
        Map regionMap = addressDetails["region"];
        selectAddressDetails = {
          "customer_id": addressDetails["customer_id"],
          "street": addressDetails["street"],
          "city": addressDetails["city"],
          "region": regionMap["region_code"],
          "country_id": addressDetails["country_id"],
          "postcode": addressDetails["postcode"],
          "firstname": addressDetails["firstname"],
          "lastname": addressDetails["lastname"],
          "company": addressDetails["company"],
          "telephone": addressDetails["telephone"],
          "save_in_address_book": addressDetails["id"],
        };
        // final progress = ProgressHUD.of(context);
        // progress.show();
        final overlay = LoadingOverlay.of(context);
        overlay.show();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var token = prefs.get("token");
        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        };

        var body = jsonEncode({"address": selectAddressDetails});
        ApiResponseModel responseData = await postApiCall(
          postUrl: "$estimateShippingMethodsApi",
          headers: headers,
          context: context,
          body: body,
        );
        //print(responseData.responseValue);
        // Navigator.of(context).pop();

        if (responseData.statusCode == 200) {
          overlay.hide();
          List responseList = responseData.responseValue;
          Map responseMap = responseList[0];
          print("responseMap: " + responseMap.toString());
          setState(() {
            addressListID = responseList;
            print(addressListID.length);
          });
          // shippingInformation(
          //     estimateShippingResponse: responseMap,
          //     shippingAddress: selectAddressDetails);
          // progress.dismiss();
        } else {
          overlay.hide();
          // Navigator.of(context).pop();

          // progress.dismiss();
        }
        // setState(() async {
        //   print(addressDetails);
        //   selectIndex = index;
        //   Map regionMap = addressDetails["region"];
        //   selectAddressDetails = {
        //     "customer_id": addressDetails["customer_id"],
        //     "street": addressDetails["street"],
        //     "city": addressDetails["city"],
        //     "region": regionMap["region_code"],
        //     "country_id": addressDetails["country_id"],
        //     "postcode": addressDetails["postcode"],
        //     "firstname": addressDetails["firstname"],
        //     "lastname": addressDetails["lastname"],
        //     "company": addressDetails["company"],
        //     "telephone": addressDetails["telephone"],
        //     "save_in_address_book": addressDetails["id"],
        //   };
        //   final progress = ProgressHUD.of(context);
        //   progress.show();
        //   SharedPreferences prefs = await SharedPreferences.getInstance();
        //   var token = prefs.get("token");
        //   Map<String, String> headers = {
        //     'Content-Type': 'application/json',
        //     'Authorization': "Bearer $token"
        //   };
        //
        //   var body = jsonEncode({"address": selectAddressDetails});
        //   ApiResponseModel responseData = await postApiCall(
        //     postUrl: "$estimateShippingMethodsApi",
        //     headers: headers,
        //     context: context,
        //     body: body,
        //   );
        //   print(responseData.responseValue);
        //   if (responseData.statusCode == 200) {
        //     List responseList = responseData.responseValue;
        //     Map responseMap = responseList[0];
        //     print("responseMap: " + responseMap.toString());
        //     // shippingInformation(
        //     //     estimateShippingResponse: responseMap,
        //     //     shippingAddress: selectAddressDetails);
        //     progress.dismiss();
        //   } else {
        //     progress.dismiss();
        //   }
        // });
      },
      child: Container(
        decoration: selectIndex == index
            ? BoxDecoration(border: Border.all(color: orangeColor))
            : BoxDecoration(border: Border.all(color: whiteColor)),
        margin: EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Address Title: Home",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  index == 0
                      ? Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 5,
                              bottom: 5,
                            ),
                            child: Text(
                              "Default",
                              style: TextStyle(
                                fontSize: 12,
                                color: whiteColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.mode_edit,
                            size: 20,
                          ),
                          sizedBoxwidth5,
                          Text(
                            "Edit",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      sizedBoxwidth5,
                      Container(
                        color: greyColor,
                        width: 1,
                        height: 15,
                      ),
                      sizedBoxwidth5,
                      InkWell(
                        onTap: () {
                          deleteAddress(
                              contexts: context,
                              addressId: addressDetails["id"].toString());
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icon/deleteIcon.png",
                              height: 15,
                              width: 15,
                              color: blackColor,
                            ),
                            sizedBoxwidth5,
                            Text(
                              "Delete",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              sizedBoxheight10,
              Text(
                "Shipping Address",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              sizedBoxheight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 4,
                      child: Text(
                        "Address",
                        style: TextStyle(
                          fontSize: 12,
                          color: greyColor,
                        ),
                      )),
                  Expanded(
                    flex: 6,
                    child: Text(
                      "${addressDetails["firstname"]}, ${addressDetails["street"][0]}, ${addressDetails["postcode"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              sizedBoxheight5,
              Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: Text(
                        "Mobile Number",
                        style: TextStyle(
                          fontSize: 12,
                          color: greyColor,
                        ),
                      )),
                  Expanded(
                    flex: 6,
                    child: Text(
                      addressDetails["telephone"],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              sizedBoxheight10,
              Text(
                "Billing Address",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress)
          return false;
        else
          return true;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProgressHUD(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: appBarColor,
              brightness: lightBrightness,
              title: Text(
                "Select Address",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      const Color(0xFF02161F),
                      const Color(0xFF0B3B52),
                      const Color(0xFF103D52),
                      const Color(0xFF304C58),
                    ],
                  ),
                ),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: ProgressHUD(
              child: Builder(
                builder: (context) => Container(
                  height: double.infinity,
                  // MediaQuery.of(context).size.height,
                  width: double.infinity,
                  color: HexColor("#F1F3F6"),
                  child: apiLoader != true
                      ? Center(
                          child: CustomerLoader(
                            dotType: DotType.circle,
                            dotOneColor: secondaryColor,
                            dotTwoColor: primaryColor,
                            dotThreeColor: Colors.red,
                          ),
                        )
                      : Stack(
                          children: [
                            SingleChildScrollView(
                              controller: _scrollController,
                              child: addressList.length == 0
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(30.0),
                                            child: Container(
                                              child: Image.asset(
                                                'assets/image/mapImage.png',
                                                height: 150,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                bottom: 30,
                                                top: 0),
                                            // Center(
                                            child: Text(
                                              'Add an address so we can get cracking on the delivery!',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              var router = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => widget
                                                              .router !=
                                                          "account"
                                                      ? AddNewAddressScreen()
                                                      : AddNewAddressScreen(
                                                          router: "account",
                                                        ),
                                                ),
                                              );
                                              print(router);
                                              if (router ==
                                                  "getAddressRefersh") {
                                                setState(() {
                                                  getAddressList();
                                                });
                                              }
                                            },
                                            child: Container(
                                              width: 200,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(50),
                                                ),
                                              ),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "+",
                                                      style: TextStyle(
                                                          color: whiteColor,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      "Add New Address",
                                                      style: TextStyle(
                                                          color: whiteColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        Container(
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemCount: addressList.length,
                                            itemBuilder: (context, index) {
                                              return addressCart(
                                                context: context,
                                                addressDetails:
                                                    addressList[index],
                                                index: index,
                                              );
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 20,
                                              bottom: 20,
                                              left: screenSize.width / 8,
                                              right: screenSize.width / 8),
                                          child: InkWell(
                                            onTap: () async {
                                              var router = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => widget
                                                              .router !=
                                                          "account"
                                                      ? AddNewAddressScreen()
                                                      : AddNewAddressScreen(
                                                          router: "account",
                                                        ),
                                                ),
                                              );
                                              print(router);
                                              if (router ==
                                                  "getAddressRefersh") {
                                                setState(() {
                                                  getAddressList();
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(50),
                                                ),
                                              ),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "+",
                                                      style: TextStyle(
                                                          color: whiteColor,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      "Add New Address",
                                                      style: TextStyle(
                                                          color: whiteColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: addressListID.length == 0
                                              ? false
                                              : true,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: 20,
                                              bottom: 0,
                                              left: 10,
                                              right: 10,
                                            ),
                                            child: Container(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Shipping  Methods',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14),
                                                )),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                              top: 0,
                                              bottom: 80,
                                              left: 10,
                                              right: 10,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      addressListID.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Column(
                                                      children: [
                                                        RadioListTile(
                                                          value: index,
                                                          groupValue: value,
                                                          onChanged: (ind) =>
                                                              setState(() {
                                                            value = ind;
                                                            method_code =
                                                                '${addressListID[index]["method_code"]}';
                                                            carrier_code =
                                                                '${addressListID[index]["carrier_code"]}';
                                                            print(
                                                                'carrier_code=$carrier_code, method_code = $method_code  ');
                                                            print(
                                                                'value = $value');
                                                          }),
                                                          title: Text(
                                                            'QAR ${addressListID[index]["amount"]}' +
                                                                '     ' +
                                                                '${addressListID[index]["carrier_code"]}' +
                                                                '     ' +
                                                                '${addressListID[index]["method_code"]}',
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                          // Column(
                                                          //   children: [
                                                          //     Text(
                                                          //         'QAR ${addressListID[index]["amount"]}'),
                                                          //     Text(
                                                          //         '${addressListID[index]["carrier_code"]}'),
                                                          //     Text(
                                                          //         '${addressListID[index]["method_code"]}'),
                                                          //   ],
                                                          // ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                            ),
                            if (addressList.isNotEmpty == true)
                              widget.router != "account"
                                  ? Positioned(
                                      bottom: 0,
                                      child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: whiteColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        padding: EdgeInsets.only(
                                            left: screenSize.width / 8,
                                            right: screenSize.width / 8,
                                            top: 10,
                                            bottom: 10),
                                        width: screenSize.width,
                                        child: InkWell(
                                          onTap: () {
                                            Map shippingDetails = {
                                              "carrier_code": carrier_code,
                                              "method_code": method_code,
                                            };
                                            selectIndex != null &&
                                                    carrier_code == null
                                                ? _scrollController.animateTo(
                                                    _scrollController.position
                                                        .maxScrollExtent,
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.ease)
                                                : null;
                                            selectIndex == null
                                                ? Fluttertoast.showToast(
                                                    msg:
                                                        "Please Select Address",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0,
                                                  )
                                                : carrier_code == null
                                                    ? Fluttertoast.showToast(
                                                        msg:
                                                            "Please Select Shipping Methods",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.CENTER,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor:
                                                            Colors.black,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0,
                                                      )
                                                    :
                                                    // estimateShippingMethod(context);

                                                    shippingInformation(
                                                        estimateShippingResponse:
                                                            shippingDetails,
                                                        shippingAddress:
                                                            selectAddressDetails);
                                            ;
                                          },
                                          child: customButton(
                                              title: "CONTINUE",
                                              backgroundColor: secondaryColor),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 0,
                                    )
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
