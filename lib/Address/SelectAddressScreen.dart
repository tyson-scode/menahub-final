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
import 'editaddress.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:menahub/translation/codegen_loader.g.dart';
import 'package:menahub/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

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
  Map billAddressDetails;

  int selectIndex;
  int value;
  String method_code;
  String carrier_code;
  @override
  void initState() {
    super.initState();
    getAddressList();
    print("cartID=${widget.cartId}");
    // getbillAddressList();
  }

  onGoBack(dynamic value) {
    setAddressList(value);
    setState(() {});
  }

  setAddressList(value) async {
    final overlay = LoadingOverlay.of(context);
    overlay.show();
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

    // print(responseData.responseValue);
    if (responseData.statusCode == 200) {
      overlay.hide();
      Map addressDetails = responseData.responseValue;
      List itemList = addressDetails["addresses"];

      setState(() {
        // address = addressDetails;
        addressList = itemList;
        apiLoader = true;
      });
    } else {
      setState(() {
        apiLoader = true;
        overlay.hide();
      });
    }
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

  // getbillAddressList() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var token = prefs.get("token");
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': "Bearer $token"
  //   };
  //   ApiResponseModel responseData = await getApiCall(
  //     getUrl: "$billaddressDetailsApi",
  //     headers: headers,
  //     context: context,
  //   );
  //   print(responseData.responseValue);
  //   if (responseData.statusCode == 200) {
  //     // print(responseData.responseValue);
  //
  //     setState(() {
  //       billAddressDetails = responseData.responseValue;
  //       // addressList = itemList;
  //       // apiLoader = true;
  //     });
  //   } else {
  //     setState(() {
  //       apiLoader = true;
  //     });
  //   }
  // }

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
    if (responseData.statusCode == 200) {
      overlay.hide();
      // Navigator.of(context).pop();
      List responseList = responseData.responseValue;
      Map responseMap = responseList[0];
      shippingInformation(
          estimateShippingResponse: responseMap,
          shippingAddress: selectAddressDetails,
          billingAddress: selectAddressDetails);
      // progress.dismiss();
    } else {
      //  progress.dismiss();
      overlay.hide();
      // Navigator.of(context).pop();
    }
  }

  shippingInformation(
      {Map estimateShippingResponse,
      Map shippingAddress,
      Map billingAddress}) async {
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
          "customAttributes": []
        },
        "billing_address": {
          "customerAddressId": billingAddress["save_in_address_book"],
          "countryId": billingAddress["country_id"],
          "regionCode": billingAddress["region"],
          "region": billingAddress["region"],
          "customerId": billingAddress["customer_id"],
          "street": billingAddress["street"],
          "company": billingAddress["company"],
          "telephone": billingAddress["telephone"],
          "fax": null,
          "postcode": billingAddress["postcode"],
          "city": billingAddress["city"],
          "firstname": billingAddress["firstname"],
          "lastname": billingAddress["lastname"],
          "middlename": null,
          "prefix": null,
          "suffix": null,
          "vatId": null,
          "customAttributes": [],
          "saveInAddressBook": null
        },
        "shipping_method_code": estimateShippingResponse["method_code"],
        "shipping_carrier_code": estimateShippingResponse["carrier_code"],
        "extension_attributes": {
          "channel":"app"
        }
      }
    });
    ApiResponseModel responseData = await postApiCall(
      postUrl: "$shippingInformationApi",
      headers: headers,
      context: context,
      body: body,
    );
    Navigator.of(context).pop();

    if (responseData.statusCode == 200) {
      overlay.hide();
      Map responseMap = responseData.responseValue;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentMethodChoose(
            paymentMethods: estimateShippingResponse,
            screenInfo: responseMap,
            shippingAddress: shippingAddress,
            billingAddress: billingAddress,
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
    return widget.router != "account"
        ? InkWell(
            onTap: () async {
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

              // Navigator.of(context).pop();

              if (responseData.statusCode == 200) {
                overlay.hide();
                List responseList = responseData.responseValue;
                print(responseList);
                // Map responseMap = responseList[0];
                setState(() {
                  addressListID = responseList;
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
                          LocaleKeys.Address_Title.tr() +
                              ":${addressDetails["company"] == null ? LocaleKeys.home.tr() : LocaleKeys.Work.tr()}",
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
                                    LocaleKeys.default_.tr(),
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
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return EditAddressScreen(
                                      addressID: index,
                                      addressdetails: addressList);
                                })).then(onGoBack);
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.mode_edit,
                                    size: 20,
                                  ),
                                  sizedBoxwidth5,
                                  Text(
                                    LocaleKeys.Edit.tr(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
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
                                    LocaleKeys.Delete.tr(),
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
                      LocaleKeys.Shipping_Address.tr(),
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
                              LocaleKeys.Address.tr(),
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
                              LocaleKeys.Mobile.tr(),
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
                    // widget.router != "account"
                    //     ? Text(
                    //         "Billing Address",
                    //         style: TextStyle(
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       )
                    //     : Container(),
                    // sizedBoxheight10,
                    // widget.router != "account"
                    //     ? Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Expanded(
                    //               flex: 4,
                    //               child: Text(
                    //                 "Address",
                    //                 style: TextStyle(
                    //                   fontSize: 12,
                    //                   color: greyColor,
                    //                 ),
                    //               )),
                    //           Expanded(
                    //             flex: 6,
                    //             child: Text(
                    //               "${billAddressDetails["firstname"]}, ${billAddressDetails["street"][0]}, ${billAddressDetails["postcode"]}",
                    //               style: TextStyle(
                    //                 fontSize: 12,
                    //                 fontWeight: FontWeight.w600,
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       )
                    //     : Container(),
                    // sizedBoxheight5,
                    // widget.router != "account"
                    //     ? Row(
                    //         children: [
                    //           Expanded(
                    //               flex: 4,
                    //               child: Text(
                    //                 "Mobile Number",
                    //                 style: TextStyle(
                    //                   fontSize: 12,
                    //                   color: greyColor,
                    //                 ),
                    //               )),
                    //           Expanded(
                    //             flex: 6,
                    //             child: Text(
                    //               billAddressDetails["telephone"],
                    //               style: TextStyle(
                    //                 fontSize: 12,
                    //                 fontWeight: FontWeight.w600,
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       )
                    //     : Container(),
                    sizedBoxheight10,
                  ],
                ),
              ),
            ),
          )
        : Container(
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
                        LocaleKeys.Address_Title.tr() +
                            ":${addressDetails["company"] == null ? LocaleKeys.home.tr() : LocaleKeys.Work.tr()}",
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
                                  LocaleKeys.default_set.tr(),
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
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return EditAddressScreen(
                                    addressID: index,
                                    addressdetails: addressList);
                              })).then(onGoBack);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.mode_edit,
                                  size: 20,
                                ),
                                sizedBoxwidth5,
                                Text(
                                  LocaleKeys.Edit.tr(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
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
                                  LocaleKeys.Delete.tr(),
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
                    LocaleKeys.Shipping_Address.tr(),
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
                            LocaleKeys.Mobile.tr(),
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
                  // Text(
                  //   "Billing Address",
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                ],
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
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: Locale(context.locale.languageCode),
        debugShowCheckedModeBanner: false,
        home: ProgressHUD(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: appBarColor,
              brightness: lightBrightness,
              title: Text(
                LocaleKeys.Select_Address.tr(),
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
                                              LocaleKeys.add_address.tr(),
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
                                              // print(router);
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
                                                      LocaleKeys.Add_New_Address
                                                          .tr(),
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
                                                      LocaleKeys.Add_New_Address
                                                          .tr(),
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
                                                  LocaleKeys.Shipping_Methods
                                                      .tr(),
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
                                                    msg: LocaleKeys
                                                        .SelectAddress.tr(),
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
                                                        msg: LocaleKeys
                                                                .SelectShipping
                                                            .tr(),
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
                                                        billingAddress:
                                                            selectAddressDetails,
                                                        shippingAddress:
                                                            selectAddressDetails);
                                            ;
                                          },
                                          child: customButton(
                                              title: LocaleKeys.Continue.tr(),
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
