import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:menahub/ProductsDetails/Template/ProductList.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/config/CustomLoader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool apiupdate = false;
  bool initialAppLoader = true;
  bool layoutStyle = true;
  int page = 1;
  List productList = [];
  TextEditingController searchTextField = TextEditingController();
  int tappedIndex;
  int totalPageSize = 0;
  bool userType;
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
  }

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
      });
    } else {
      setState(() {
        userType = false;
      });
    }
    print(userType);
  }

  getProductList() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    ApiResponseModel response = await getApiCall(
      getUrl:
          "https://magento2blog.thestagings.com/rest/default/V1/products?searchCriteria[filter_groups][1][filters][0][field]=name&searchCriteria[filter_groups][1][filters][0][condition_type]=like&searchCriteria[filter_groups][1][filters][0][value]=%25${searchTextField.text}%25&searchCriteria[filter_groups][1][filters][1][field]=sku&searchCriteria[currentPage]=1&searchCriteria[pageSize]=10",
      headers: headers,
      context: context,
    );
    if (response.statusCode == 200) {
      Map responseMap = response.responseValue;
      List listItem = responseMap["items"];
      print(listItem.length);
      setState(() {
        productList = listItem;
        totalPageSize = responseMap["total_count"];
        initialAppLoader = false;
      });
    } else {
      setState(() {
        initialAppLoader = false;
      });
    }
  }

  addWishlist({String productId, BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    final progress = ProgressHUD.of(context);
    progress.show();
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

  updateProductList() async {
    if (productList.length == totalPageSize) {
    } else {
      page += 1;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      ApiResponseModel response = await getApiCall(
        getUrl:
            "https://magento2blog.thestagings.com/rest/default/V1/products?searchCriteria[filter_groups][1][filters][0][field]=name&searchCriteria[filter_groups][1][filters][0][condition_type]=like&searchCriteria[filter_groups][1][filters][0][value]=%25${searchTextField.text}%25&searchCriteria[filter_groups][1][filters][1][field]=sku&searchCriteria[currentPage]=1&searchCriteria[pageSize]=$page",
        headers: headers,
        context: context,
      );
      if (response.statusCode == 200) {
        Map responseMap = response.responseValue;
        List listItem = responseMap["items"];
        print(listItem.length);
        setState(() {
          productList.addAll(listItem);
          apiupdate = false;
        });
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: appBarColor,
          brightness: lightBrightness,
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
          title: Text(
            "Search",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
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
                width: double.infinity,
                child: Column(
                  children: [
                    //search
                    Container(
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
                            left: 20.0, right: 20, top: 10, bottom: 10),
                        child: Container(
                          height: 39,
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextField(
                            controller: searchTextField,
                            style: TextStyle(color: whiteColor),
                            cursorColor: whiteColor,
                            autofocus: true,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search by Products, Brands & More...',
                              hintStyle: TextStyle(color: Colors.white),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ),
                            onChanged: (value) {
                              if (value.length > 3) {
                                getProductList();
                              } else {
                                setState(() {
                                  productList = [];
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        // ignore: missing_return
                        onNotification: (scrollNotification) {
                          if (_scrollController.position.pixels ==
                              _scrollController.position.maxScrollExtent) {
                            if (!apiupdate) {
                              setState(() {
                                if (productList.length == totalPageSize) {
                                } else {
                                  apiupdate = true;
                                  updateProductList();
                                }
                              });
                            }
                          }
                        },
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                              productList.isNotEmpty == true
                                  ? Container(
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount: productList.length,
                                        itemBuilder: (context, index) {
                                          return ProductList(
                                            productDetails: productList[index],
                                            context: context,
                                            userType: userType,
                                            onstate: (value, status) {
                                              if (status) {
                                                addWishlist(
                                                    productId: value,
                                                    context: context);
                                              } else {
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder: (context) =>
                                                //         ParticularProductsDetailsScreen(
                                                //       productSkuId: value,
                                                //     ),
                                                //   ),
                                                // );
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    )
                                  : Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      child: Center(
                                        child: Text("Search items list empty"),
                                      ),
                                    ),
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
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
