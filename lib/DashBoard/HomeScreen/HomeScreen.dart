import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:menahub/ProductsDetails/ParticularProductsDetailsScreen.dart';
import 'package:menahub/ProductsDetails/ProductsDetailsScreen.dart';
import 'package:menahub/SearchScreen/SearchScreen.dart';
import 'package:menahub/SignIn_SignUp_Flow/SignInScreen/SignInScreen.dart';
import 'package:menahub/Template/HomeScreen/Block1.dart';
import 'package:menahub/Template/HomeScreen/Block2.dart';
import 'package:menahub/Template/HomeScreen/Block3.dart';
import 'package:menahub/Template/HomeScreen/PersonalCareSuplies.dart';
import 'package:menahub/Template/HomeScreen/WhatsNewCard.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:menahub/config/CustomLoader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:menahub/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import '../DashBoard.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List sampleBlockList1 = [];
  List sampleBlockList2 = [];
  List sampleBlockList3 = [];
  List sampleBlockList4 = [];
  List sampleBlockList5 = [];
  List sampleBlockList6 = [];
  List sampleBlockList7 = [];
  List<String> sliderList1 = [];
  List<String> titleList = [];
  List mobiletype1 = [];
  List mobiletype2 = [];
  List mobileLinkId = [];

  List<String> sliderList2 = [];
  //slider indicator
  int slider1position = 0;
  int slider2position = 0;
  //view more value
  String v1, v2, v3, v4, v5, v6, v7;
  //title name
  String blockName1,
      blockName2,
      blockName3,
      blockName4,
      blockName5,
      blockName6,
      blockName7;
  bool userType;
  ScrollController _scrollController = ScrollController();
  bool pager = true;
  bool apiLoader = true;
  bool apiupdate = false;

//static image
  String mediaUrl;
  String staticBanner;

  @override
  void initState() {
    super.initState();
    getLocalInformation();
    getSlider1();
    getSlider2();
    getProductList();
  }

  paginationApicall() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    ApiResponseModel storeConfigResponse = await getApiCall(
      getUrl: getStoreConfig,
      headers: headers,
      context: context,
    );
    if (storeConfigResponse.statusCode == 200) {
      List responseData = storeConfigResponse.responseValue;
      Map storeMap = responseData[0];
      List storeListData = storeMap["store"];
      String staticBanner = storeListData[0]["static_banner"];
      String mediaUrl = storeListData[0]["media_url"];
      setState(() {
        this.staticBanner = staticBanner;
        this.mediaUrl = mediaUrl;
      });
    } else {
      setState(() {});
    }
    ApiResponseModel slider2 = await getApiCall(
      getUrl: "${sliderblocks}2",
      headers: headers,
      context: context,
    );
    List sliderData2 = slider2.responseValue;
    if (slider2.statusCode == 200) {
      List bannerImageList = sliderData2;
      setState(() {
        List imageList =
            bannerImageList.map((e) => e["image"].toString()).toList();
        sliderList2 = imageList;
      });
    } else {}

    ApiResponseModel block4 = await getApiCall(
      getUrl: "${homeScreenProductUrl}4",
      headers: headers,
      context: context,
    );
    List responseBlock4 = block4.responseValue;
    ApiResponseModel block5 = await getApiCall(
      getUrl: "${homeScreenProductUrl}5",
      headers: headers,
      context: context,
    );
    List responseBlock5 = block5.responseValue;
    ApiResponseModel block6 = await getApiCall(
      getUrl: "${homeScreenProductUrl}6",
      headers: headers,
      context: context,
    );
    List responseBlock6 = block6.responseValue;
    ApiResponseModel block7 = await getApiCall(
      getUrl: "${homeScreenProductUrl}7",
      headers: headers,
      context: context,
    );
    List responseBlock7 = block7.responseValue;

    if (block4.statusCode == 200) {
      Map item = responseBlock4[0];
      setState(() {
        sampleBlockList4 = item["items"];
        v4 = item["viewmore_link"];
        blockName4 = item["name"];
      });
    } else {}
    if (block5.statusCode == 200) {
      Map item = responseBlock5[0];
      setState(() {
        sampleBlockList5 = item["items"];
        v5 = item["viewmore_link"];
        blockName5 = item["name"];
      });
    } else {}
    if (block6.statusCode == 200) {
      Map item = responseBlock6[0];
      setState(() {
        sampleBlockList6 = item["items"];
        v6 = item["viewmore_link"];
        blockName6 = item["name"];
      });
    } else {}
    if (block7.statusCode == 200) {
      Map item = responseBlock7[0];
      setState(() {
        sampleBlockList7 = item["items"];
        v7 = item["viewmore_link"];
        blockName7 = item["name"];
        apiupdate = false;
      });
    } else {}
  }

  getLocalInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String type = prefs.getString("userType");

    if (type == "guest") {
      // Fluttertoast.showToast(
      //   msg: "You have logged in as Guest User...",
      //   // toastLength: Toast.LENGTH_LONG,
      //   // gravity: ToastGravity.CENTER,
      //   // timeInSecForIosWeb: 10,
      //   // backgroundColor: Colors.red,
      //   // textColor: Colors.white,
      //   // fontSize: 16.0,
      // );
      setState(() {
        userType = true;
      });
    } else {
      setState(() {
        userType = false;
      });
    }
    print(userType);
  }

  // pushNotification(BuildContext _context) async {
  //   print("pushNotification called");
  //   SharedPreferences preference = await SharedPreferences.getInstance();
  //   String deviceID = preference.getString("firebasetoken");
  //   print("preference.getString(firebasetoken)");
  //   print(preference.getString("firebasetoken"));
  //   var body = jsonEncode({
  //     "device_type": Platform.isAndroid
  //         ? "Android"
  //         : Platform.isIOS
  //             ? "IOS"
  //             : "Null",
  //     "device_id": deviceID,
  //     "customer_id": customer_ID,
  //   });
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //   };
  //   ApiResponseModel responseData = await postApiCall(
  //       postUrl: pushNotificationUrl,
  //       headers: headers,
  //       context: context,
  //       body: body);
  //
  //   if (responseData.statusCode == 200) {
  //     print(responseData.responseValue);
  //   } else {
  //     Map response = responseData.responseValue;
  //     String errorMessage = response["message"];
  //     print(errorMessage);
  //     // Fluttertoast.showToast(
  //     //   msg: errorMessage,
  //     //   toastLength: Toast.LENGTH_SHORT,
  //     //   gravity: ToastGravity.BOTTOM,
  //     //   timeInSecForIosWeb: 1,
  //     //   backgroundColor: Colors.white,
  //     //   textColor: Colors.black,
  //     //   fontSize: 16.0,
  //     // );
  //
  //     print(errorMessage);
  //   }
  // }

  getSlider1() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    ApiResponseModel slider1 = await getApiCall(
      getUrl: "${sliderblocks}1",
      headers: headers,
      context: context,
    );
    List sliderData1 = slider1.responseValue;

    if (slider1.statusCode == 200) {
      List bannerImageList = sliderData1;
      setState(() {
        List imageList =
            bannerImageList.map((e) => e["image"].toString()).toList();
        sliderList1 = imageList;
        mobileLinkId =
            bannerImageList.map((e) => e["mobile_link_id"].toString()).toList();
        mobiletype1 =
            bannerImageList.map((e) => e["mobile_type"].toString()).toList();
        print("mobiletype");

        print(mobiletype1);

        print(sliderData1);
        // titleList = titlelist;
        print(titleList);
      });
    } else {}
  }
  getSlider2() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    ApiResponseModel slider1 = await getApiCall(
      getUrl: "${sliderblocks}1",
      headers: headers,
      context: context,
    );
    List sliderData1 = slider1.responseValue;

    if (slider1.statusCode == 200) {
      List bannerImageList = sliderData1;
      setState(() {
        List imageList =
            bannerImageList.map((e) => e["image"].toString()).toList();
        sliderList2 = imageList;
        mobileLinkId =
            bannerImageList.map((e) => e["mobile_link_id"].toString()).toList();
        mobiletype2 =
            bannerImageList.map((e) => e["mobile_type"].toString()).toList();
        print("mobiletype");

        print(mobiletype2);

        print(sliderData1);
        // titleList = titlelist;
        print(titleList);
      });
    } else {}
  }

  getProductList() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    ApiResponseModel block1 = await getApiCall(
      getUrl: "${homeScreenProductUrl}1",
      headers: headers,
      context: context,
    );
    List responseBlock1 = block1.responseValue;

    ApiResponseModel block2 = await getApiCall(
      getUrl: "${homeScreenProductUrl}2",
      headers: headers,
      context: context,
    );
    List responseBlock2 = block2.responseValue;
    ApiResponseModel block3 = await getApiCall(
      getUrl: "${homeScreenProductUrl}3",
      headers: headers,
      context: context,
    );
    List responseBlock3 = block3.responseValue;
    if (block1.statusCode == 200) {
      Map item = responseBlock1[0];
      setState(() {
        sampleBlockList1 = item["items"];
        v1 = item["viewmore_link"];
        blockName1 = item["name"];
        apiLoader = false;
      });
    } else {}
    if (block2.statusCode == 200) {
      Map item = responseBlock2[0];
      setState(() {
        sampleBlockList2 = item["items"];
        v2 = item["viewmore_link"];
        blockName2 = item["name"];
        apiLoader = false;
      });
    } else {}
    if (block3.statusCode == 200) {
      Map item = responseBlock3[0];
      setState(() {
        sampleBlockList3 = item["items"];
        v3 = item["viewmore_link"];
        blockName3 = item["name"];
        apiLoader = false;
      });
    } else {}
  }

  addToCart({String sku, String qty}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
        setState(() {});
      } else {}
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

  navigationSearchScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchScreen(),
      ),
    );
  }

  viewMoreNavigation({String productId, String title}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (contexts) => ProductsDetailsScreen(
          productId: productId,
          title: title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: Locale(context.locale.languageCode),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ProgressHUD(
          child: Builder(
            builder: (context) => Container(
              height: double.infinity,
              width: double.infinity,
              child: apiLoader == true
                  ? Center(
                      child: CustomerLoader(
                        dotType: DotType.circle,
                        dotOneColor: secondaryColor,
                        dotTwoColor: primaryColor,
                        dotThreeColor: Colors.red,
                        duration: Duration(milliseconds: 1000),
                      ),
                    )
                  : NotificationListener<ScrollNotification>(
                      // ignore: missing_return
                      onNotification: (scrollNotification) {
                        if (_scrollController.position.pixels ==
                            _scrollController.position.maxScrollExtent) {
                          if (pager) {
                            setState(() {
                              pager = false;
                              apiupdate = true;
                              paginationApicall();
                            });
                          }
                        }
                      },
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //search
                            InkWell(
                              onTap: () {
                                navigationSearchScreen();
                              },
                              child: Container(
                                // color: appBarColor,
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
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20,
                                      top: 10,
                                      bottom: 10),
                                  child: Container(
                                    height: 39,
                                    decoration: BoxDecoration(
                                      color: Colors.white12,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TextField(
                                      enabled: false,
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        hintText: LocaleKeys.search.tr(),
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        prefixIcon: const Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //slid banner
                            if (sliderList1.isNotEmpty == true)
                              Container(
                                child: Column(children: [
                                  CarouselSlider(
                                    items: sliderList1
                                        .map(
                                          (item) => Container(
                                            height: 150,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: GestureDetector(
                                              onTap: () {
                                                var data = mobiletype1[slider1position];
                                                if(data == ""){
                                                }
                                                else if(data == "0") {
                                                  print("product");
                                                }
                                                else if(data == "1") {
                                                  print("category");
                                                }
                                                else if(data == "2") {
                                                  print("productlist");
                                                }

                                                // mobiletype[slider1position] !=
                                                //         null
                                                //     ? viewMoreNavigation(
                                                //         productId: mobiletype[
                                                //             slider1position],
                                                //         title: " ")
                                                //     : null;
                                              },
                                              child: ClipRRect(
                                                child: Image.network(
                                                    "$bannerSliderBaseUrl$item",
                                                    fit: BoxFit.fill,
                                                    width: 1000.0),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    options: CarouselOptions(
                                      // autoPlayAnimationDuration:
                                      // Duration(seconds: 1),
                                      // autoPlayInterval: Duration(seconds: 500),
                                      pageSnapping: true,
                                      autoPlay: true,
                                      // enlargeCenterPage: true,
                                      // aspectRatio: 2.0,
                                      viewportFraction: 1.0,

                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          slider1position = index;
                                        });
                                      },
                                    ),
                                  ),
                                  //indicator
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: sliderList1.map((url) {
                                        int index = sliderList1.indexOf(url);
                                        return Container(
                                          width: 20.0,
                                          height: 5.0,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 2.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: slider1position == index
                                                  ? secondaryColor
                                                  : lightGreyColor),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ]),
                              )
                            else
                              Container(),
                            //sample block 01
                            if (sampleBlockList1.isNotEmpty == true)
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      blockName1,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        viewMoreNavigation(
                                            productId: v1, title: blockName1);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: secondaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8,
                                              top: 4,
                                              bottom: 4),
                                          child: Text(
                                            LocaleKeys.view_all.tr(),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: secondaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            else
                              Container(),
                            if (sampleBlockList1.isNotEmpty == true)
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 0.0, left: 10),
                                child: Wrap(
                                  children: [
                                    for (var i = 0;
                                        i < sampleBlockList1.length;
                                        i++)
                                      Block1(
                                        productImage: sampleBlockList1[i]
                                            ["image"],
                                        productSkuId: sampleBlockList1[i]
                                            ["sku"],
                                        onstate: (value, status) {
                                          if (status) {
                                          } else {
                                            navigationViewAllProduct(value);
                                          }
                                        },
                                      ),
                                  ],
                                ),
                              )
                            else
                              Container(),
                            sizedBoxheight10,
                            //sample block 02
                            if (sampleBlockList2.isNotEmpty == true)
                              Container(
                                decoration: BoxDecoration(
                                    color: HexColor("#EAF0F4"),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            blockName2,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              viewMoreNavigation(
                                                  productId: v2,
                                                  title: blockName2);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: secondaryColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0,
                                                    right: 8,
                                                    top: 4,
                                                    bottom: 4),
                                                child: Text(
                                                  LocaleKeys.view_all.tr(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: secondaryColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 20),
                                      height: 210,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: sampleBlockList2.length,
                                        itemBuilder: (context, index) {
                                          int len = sampleBlockList2.length;
                                          // print('Length =  $len');
                                          // print('block2 = $sampleBlockList2');

                                          return Block2(
                                            productDetails:
                                                sampleBlockList2[index],
                                            context: context,
                                            userType: userType,
                                            onstate: (value, status) {
                                              if (status) {
                                                addWishlist(
                                                    productId: value,
                                                    contexts: context);
                                              } else {
                                                navigationViewAllProduct(value);
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    sizedBoxheight10,
                                  ],
                                ),
                              )
                            else
                              Container(),
                            //sample block 03
                            if (sampleBlockList3.isNotEmpty == true)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          blockName3,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            viewMoreNavigation(
                                                productId: v3,
                                                title: blockName3);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: secondaryColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  right: 8,
                                                  top: 4,
                                                  bottom: 4),
                                              child: Text(
                                                LocaleKeys.view_all.tr(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: secondaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: GridView.count(
                                      padding: EdgeInsets.zero,
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.88,
                                      controller: ScrollController(
                                          keepScrollOffset: false),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      children: List.generate(
                                        sampleBlockList3.length,
                                        (index) {
                                          return Block3(
                                            productDetails:
                                                sampleBlockList3[index],
                                            onstate: (value, status) {
                                              print(
                                                  "value " + value.toString());
                                              if (status) {
                                              } else {
                                                navigationViewAllProduct(value);
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  sizedBoxheight10,
                                ],
                              )
                            else
                              Container(),
                            //slid banner
                            if (sliderList2.isNotEmpty == true)
                              Container(
                                child: Column(children: [
                                  CarouselSlider(
                                    items: sliderList2
                                        .map(
                                          (item) => GestureDetector(
                                            onTap: () {
                                              var data = mobiletype2[slider2position];
                                              if(data == ""){
                                              }
                                              else if(data == "0") {
                                                print("product");
                                              }
                                              else if(data == "1") {
                                                print("category");
                                              }
                                              else if(data == "2") {
                                                print("productlist");
                                              }
                                            },
                                            child: Container(
                                              height: 150,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Image.network(
                                                  "$bannerSliderBaseUrl$item",
                                                  fit: BoxFit.fill,
                                                  height: 150,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    options: CarouselOptions(
                                      pageSnapping: true,
                                      autoPlay: true,
                                      viewportFraction: 1.0,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          slider2position = index;
                                        });
                                      },
                                    ),
                                  ),
                                  //indicator
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: sliderList2.map((url) {
                                        int index = sliderList2.indexOf(url);
                                        return Container(
                                          width: 20.0,
                                          height: 5.0,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 2.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: slider2position == index
                                                  ? secondaryColor
                                                  : lightGreyColor),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  sizedBoxheight10,
                                ]),
                              )
                            else
                              Container(),
                            //sample block 04
                            if (sampleBlockList4.isNotEmpty == true)
                              Container(
                                decoration: BoxDecoration(
                                    color: HexColor("#E28542"),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            blockName4,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: whiteColor,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              viewMoreNavigation(
                                                  productId: v4,
                                                  title: blockName4);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: whiteColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0,
                                                    right: 8,
                                                    top: 4,
                                                    bottom: 4),
                                                child: Text(
                                                  LocaleKeys.view_all.tr(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: whiteColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 20),
                                      height: 220,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: sampleBlockList4.length,
                                        itemBuilder: (context, index) {
                                          return Block2(
                                            productDetails:
                                                sampleBlockList4[index],
                                            context: context,
                                            userType: userType,
                                            onstate: (value, status) {
                                              if (status) {
                                                addWishlist(
                                                    productId: value,
                                                    contexts: context);
                                              } else {
                                                navigationViewAllProduct(value);
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            else
                              Container(),
                            sizedBoxheight20,
                            //Top Brands
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.all(10.0),
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Text(
                            //             "Top Brands",
                            //             style: TextStyle(
                            //               fontSize: 14,
                            //               fontWeight: FontWeight.w500,
                            //             ),
                            //           ),
                            //           Container(
                            //             decoration: BoxDecoration(
                            //               border: Border.all(
                            //                 color: secondaryColor,
                            //               ),
                            //               borderRadius: BorderRadius.circular(50),
                            //             ),
                            //             child: Padding(
                            //               padding: const EdgeInsets.only(
                            //                   left: 8.0, right: 8, top: 4, bottom: 4),
                            //               child: Text(
                            //                 "View All",
                            //                 style: TextStyle(
                            //                   fontSize: 12,
                            //                   color: secondaryColor,
                            //                 ),
                            //               ),
                            //             ),
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(
                            //           top: 10, bottom: 10, left: 10, right: 10),
                            //       child: Container(
                            //         decoration: BoxDecoration(
                            //             border: Border.all(color: lightGreyColor)),
                            //         child: Column(
                            //           crossAxisAlignment: CrossAxisAlignment.start,
                            //           children: [
                            //             Padding(
                            //               padding: const EdgeInsets.all(10),
                            //               child: Text(
                            //                 "SENCOR",
                            //                 style: TextStyle(
                            //                     fontSize: 22, fontWeight: FontWeight.bold),
                            //               ),
                            //             ),
                            //             GridView.count(
                            //               padding: const EdgeInsets.only(
                            //                   top: 0, bottom: 10, left: 0, right: 0),
                            //               crossAxisCount: 3,
                            //               childAspectRatio: 0.88,
                            //               controller:
                            //                   ScrollController(keepScrollOffset: false),
                            //               shrinkWrap: true,
                            //               scrollDirection: Axis.vertical,
                            //               children: List.generate(
                            //                 6,
                            //                 (index) {
                            //                   return topBrands(
                            //                     context: context,
                            //                   );
                            //                 },
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // sizedBoxheight10,
                            //sample block 05
                            if (sampleBlockList6.isNotEmpty == true)
                              Container(
                                width: screenSize.width,
                                color: HexColor("#F2A85D"),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            blockName5,
                                            style: TextStyle(
                                              color: whiteColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              viewMoreNavigation(
                                                  productId: v5,
                                                  title: blockName5);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: whiteColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0,
                                                    right: 8,
                                                    top: 4,
                                                    bottom: 4),
                                                child: Text(
                                                  LocaleKeys.view_all.tr(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: whiteColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: EdgeInsets.all(10.0),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 5, 5, 10),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 6,
                                                child: InkWell(
                                                  onTap: () {
                                                    navigationViewAllProduct(
                                                      sampleBlockList5[0]
                                                          ["sku"],
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: whatsNewCard(
                                                        productDetails:
                                                            sampleBlockList5[0],
                                                        index: 0),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 350,
                                                  width: 3,
                                                  color: lightGreyColor,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        navigationViewAllProduct(
                                                          sampleBlockList5[1]
                                                              ["sku"],
                                                        );
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: whatsNewCard(
                                                          productDetails:
                                                              sampleBlockList5[
                                                                  1],
                                                        ),
                                                      ),
                                                    ),
                                                    Divider(
                                                      thickness: 3,
                                                      color: lightGreyColor,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          navigationViewAllProduct(
                                                            sampleBlockList5[2]
                                                                ["sku"],
                                                          );
                                                        },
                                                        child: whatsNewCard(
                                                          productDetails:
                                                              sampleBlockList5[
                                                                  2],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            else
                              Container(),
                            sizedBoxheight10,
                            // //banner 1
                            // Container(
                            //   height: 150,
                            //   width: MediaQuery.of(context).size.width,
                            //   child: ClipRRect(
                            //     child: Image.asset("assets/image/bannerImage2.png",
                            //         fit: BoxFit.fill, width: 1000.0),
                            //   ),
                            // ),
                            //sample block 06
                            if (sampleBlockList6.isNotEmpty == true)
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      blockName6,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        viewMoreNavigation(
                                            productId: v6, title: blockName6);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: secondaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8,
                                              top: 4,
                                              bottom: 4),
                                          child: Text(
                                            LocaleKeys.view_all.tr(),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: secondaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            else
                              Container(),
                            if (sampleBlockList6.isNotEmpty == true)
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 0.0, left: 10),
                                child: Wrap(
                                  children: [
                                    for (var i = 0;
                                        i < sampleBlockList6.length;
                                        i++)
                                      Block1(
                                        productImage: sampleBlockList6[i]
                                            ["image"],
                                        productSkuId: sampleBlockList6[i]
                                            ["sku"],
                                        onstate: (value, status) {
                                          if (status) {
                                          } else {
                                            navigationViewAllProduct(value);
                                          }
                                        },
                                      ),
                                  ],
                                ),
                              )
                            else
                              Container(),
                            sizedBoxheight20,
                            //Get the best Quote
                            if (mediaUrl != null)
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.only(bottom: 10),
                                    //   child: Text(
                                    //     "Get the best Quote",
                                    //     style: TextStyle(
                                    //         fontSize: 16,
                                    //         fontWeight: FontWeight.w700),
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: DottedBorder(
                                        color: Colors.grey,
                                        strokeWidth: 3,
                                        dashPattern: [15],
                                        padding: EdgeInsets.all(5),
                                        child: Container(
                                          height: 180,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "$mediaUrl$staticBanner"),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          child: null,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            sizedBoxheight10,
                            //banner 2
                            // Container(
                            //   height: 230,
                            //   width: MediaQuery.of(context).size.width,
                            //   child: ClipRRect(
                            //     child: Image.asset("assets/image/bannerImage2.png",
                            //         fit: BoxFit.fill, width: 1000.0),
                            //   ),
                            // ),
                            //Personal Care and Cleaning Supplies
                            if (sampleBlockList7.isNotEmpty == true)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          blockName7,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            viewMoreNavigation(
                                                productId: v7,
                                                title: blockName7);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: secondaryColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  right: 8,
                                                  top: 4,
                                                  bottom: 4),
                                              child: Text(
                                                LocaleKeys.view_all.tr(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: secondaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: GridView.count(
                                      padding: EdgeInsets.zero,
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.88,
                                      controller: ScrollController(
                                          keepScrollOffset: false),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      children: List.generate(
                                        sampleBlockList7.length,
                                        (index) {
                                          return PersonalCareSuplies(
                                            productDetails:
                                                sampleBlockList7[index],
                                            context: context,
                                            userType: userType,
                                            onstate: (value, status) {
                                              if (status) {
                                                addWishlist(
                                                    productId: value,
                                                    contexts: context);
                                              } else {
                                                navigationViewAllProduct(value);
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            else
                              Container(),
                            sizedBoxheight10,
                            if (apiupdate)
                              Center(
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: CustomerLoader(
                                    dotType: DotType.circle,
                                    dotOneColor: secondaryColor,
                                    dotTwoColor: primaryColor,
                                    dotThreeColor: Colors.red,
                                    duration: Duration(milliseconds: 1000),
                                  ),
                                ),
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
