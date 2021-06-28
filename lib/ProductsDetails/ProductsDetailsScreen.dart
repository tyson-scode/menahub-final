import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:menahub/CustomWidget/CustomButton.dart';
import 'package:menahub/DashBoard/CategoriesScreen/CategoriesScreen.dart';
import 'package:menahub/DashBoard/CategoriesScreen/FilterByCategoriesScreen.dart';
import 'package:menahub/DashBoard/CategoriesScreen/FilterScreen.dart';
import 'package:menahub/ProductsDetails/Template/ProductList.dart';
import 'package:menahub/ProductsDetails/Template/ProductGrid.dart';
import 'package:menahub/SearchScreen/SearchScreen.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/config/CustomLoader.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:menahub/translation/codegen_loader.g.dart';
import 'package:menahub/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductsDetailsScreen extends StatefulWidget {
  ProductsDetailsScreen(
      {this.productId,
      this.category,
      this.title,
      this.router,
      this.filter,
      this.relatedProducts,
      this.filtervalue});
  final productId;
  List relatedProducts;
  Map filter;
  final title;
  final category;
  final filtervalue;
  String router;
  @override
  _ProductsDetailsScreenState createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  List categoryList = [];
  Map fileterMap;
  bool layoutStyle = true;
  List productList = [];
  List tempProductList = [];
  List storItems = [
    LocaleKeys.Popularity.tr(),
    LocaleKeys.lowest.tr(),
    LocaleKeys.highest.tr(),
    LocaleKeys.Discount.tr()
  ];

  int tappedIndex;
  bool userType;
  ScrollController _scrollController = ScrollController();
  int page = 1;
  bool apiupdate = false;
  bool initialAppLoader = true;
  int totalPageSize = 0;
  var sortyByPopularity = "&searchCriteria[sortOrders][0][field]=popularity";
  var sortyByDiscount = "&searchCriteria[sortOrders][0][field]=discount";
  var sortByPriceHigh =
      "&searchCriteria[sortOrders][0][field]=price&searchCriteria[sortOrders][1][direction]=desc";
  var sortByPriceLow =
      "&searchCriteria[sortOrders][0][field]=price&searchCriteria[sortOrders][1][direction]=asc";
  var sortAppend = "";
  String urlname;
  // @override
  // void dispose() {
  //   super.dispose();
  // }

  String filter;
  @override
  void initState() {
    super.initState();
    getLocalInformation();
    getFilterOption();
    // widget.router == null ? getProductList1() : getProductList();
    widget.router == "search" ? getProductList1() : getProductList();

    // widget.router == "home" ? getProductList() : null;
    // widget.router != "search" ?  : getProductList();
    print("router");
    print(widget.router);
    print(widget.router != "search");
  }

  Widget sortItem({String title, int index, StateSetter mystate}) {
    return InkWell(
      onTap: () {
        mystate(() {
          tappedIndex = index;
          if (index == 0) {
            sortAppend = sortyByPopularity;
          } else if (index == 1) {
            sortAppend = sortByPriceHigh;
          } else if (index == 2) {
            sortAppend = sortByPriceLow;
          } else if (index == 3) {
            sortAppend = sortyByDiscount;
          }
        });
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              tappedIndex != index
                  ? Image.asset(
                      "assets/icon/unselectRadioIcon.png",
                      height: 25,
                      width: 25,
                    )
                  : Image.asset(
                      "assets/icon/selectRadioIcon.png",
                      height: 25,
                      width: 25,
                    ),
              sizedBoxwidth10,
              Text(title),
            ],
          ),
        ),
      ),
    );
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
    if (widget.router != "homesearch") {
      urlname =
          "$baseUrl$lang/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[pageSize]=20&searchCriteria[filter_groups][0][filters][0][value]=${widget.productId}$sortAppend&searchCriteria[filter_groups][2][filters][0][field]=visibility&searchCriteria[filter_groups][2][filters][0][value]=4&searchCriteria[filter_groups][3][filters][0][field]=status&searchCriteria[filter_groups][3][filters][0][value]=1";
    } else {
      urlname =
          "$baseUrl$lang/V1/products?searchCriteria[filter_groups][1][filters][0][field]=name&searchCriteria[filter_groups][1][filters][0][condition_type]=like&searchCriteria[pageSize]=20&searchCriteria[filter_groups][1][filters][0][value]=%25${widget.productId}%25$sortAppend&searchCriteria[filter_groups][2][filters][0][field]=visibility&searchCriteria[filter_groups][2][filters][0][value]=4&searchCriteria[filter_groups][3][filters][0][field]=status&searchCriteria[filter_groups][3][filters][0][value]=1";
    }
    ApiResponseModel response = await getApiCall(
      // getUrl: "$viewAllApi${widget.productId}$sortAppend",

      getUrl: urlname,

      headers: headers,
      context: context,
    );

    if (response.statusCode == 200) {
      Map responseMap = response.responseValue;

      List listItem = responseMap["items"];

      setState(() {
        if (sortAppend == "") {
          tempProductList = listItem;
        } else {}
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

  getProductList1() async {
    print("getproductlist1");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (widget.filter["filter_code"] == "cat") {
      urlname =
          "$baseUrl$lang/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[pageSize]=20&searchCriteria[filter_groups][0][filters][0][value]=${widget.productId}$sortAppend&searchCriteria[filter_groups][2][filters][0][field]=visibility&searchCriteria[filter_groups][2][filters][0][value]=4&searchCriteria[filter_groups][3][filters][0][field]=status&searchCriteria[filter_groups][3][filters][0][value]=1";
    } else if (widget.filter["filter_code"] == "price") {
      String filtercode = widget.filter["value"];

      if (filtercode.startsWith('-')) {
        String filter = filtercode.substring(1);
        urlname =
            "$baseUrl$lang/V1/products?searchCriteria[filter_groups][0][filters][0][field]=${widget.filter["filter_code"]}&searchCriteria[filter_groups][0][filters][0][condition_type]=from&searchCriteria[pageSize]=20&searchCriteria[filter_groups][0][filters][0][value]=0&searchCriteria[filter_groups][0][filters][0][condition_type]=to&searchCriteria[filter_groups][0][filters][0][value]=$filter&searchCriteria[filter_groups][2][filters][0][field]=visibility&searchCriteria[filter_groups][2][filters][0][value]=4&searchCriteria[filter_groups][3][filters][0][field]=status&searchCriteria[filter_groups][3][filters][0][value]=1";
      } else if (filtercode.endsWith('-')) {
        String filter = filtercode.replaceAll('-', '');
        urlname =
            "$baseUrl$lang/V1/products?searchCriteria[filter_groups][0][filters][0][field]=${widget.filter["filter_code"]}&searchCriteria[filter_groups][0][filters][0][condition_type]=gteq&searchCriteria[pageSize]=20&searchCriteria[filter_groups][0][filters][0][value]=$filter&searchCriteria[filter_groups][2][filters][0][field]=visibility&searchCriteria[filter_groups][2][filters][0][value]=4&searchCriteria[filter_groups][3][filters][0][field]=status&searchCriteria[filter_groups][3][filters][0][value]=1";
      } else {
        List filter = filtercode.split('-');
        print(filter[0]);
        print(filter[1]);
        urlname =
            "$baseUrl$lang/V1/products?searchCriteria[filter_groups][1][filters][0][field]=price&searchCriteria[filter_groups][1][filters][0][value]=${filter[0]}&searchCriteria[filter_groups][1][filters][0][condition_type]=gteq&searchCriteria[filter_groups][2][filters][0][field]=price&searchCriteria[filter_groups][2][filters][0][value]=${filter[1]}&searchCriteria[filter_groups][2][filters][0][condition_type]=lteq&searchCriteria[pageSize]=20&searchCriteria[filter_groups][3][filters][0][field]=visibility&searchCriteria[filter_groups][3][filters][0][value]=4&searchCriteria[filter_groups][4][filters][0][field]=status&searchCriteria[filter_groups][4][filters][0][value]=1";
      }
    } else {
      urlname =
          "$baseUrl$lang/V1/products?searchCriteria[filter_groups][0][filters][0][field]=${widget.filter["filter_code"]}&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[pageSize]=20&searchCriteria[filter_groups][0][filters][0][value]=${widget.filter["value"]}$sortAppend";
    }
    ApiResponseModel response = await getApiCall(
      getUrl: urlname,
      headers: headers,
      context: context,
    );

    if (response.statusCode == 200) {
      Map responseMap = response.responseValue;
      List listItem = responseMap["items"];
      setState(() {
        if (sortAppend == "") {
          tempProductList = listItem;
        } else {}
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

  getFilterOption() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    ApiResponseModel response = await getApiCall(
      getUrl: "$filterOptionApi${widget.productId}",
      headers: headers,
      context: context,
    );
    if (response.statusCode == 200) {
      Map responseMap = response.responseValue;
      Map availableFilterMap = responseMap["availablefilter"];
      List filterKeysList = availableFilterMap.keys.toList();
      setState(() {
        for (var item in filterKeysList) {
          if (item == "Category") {
            categoryList = availableFilterMap[item];
            print("categoryList=$categoryList");
          }
        }
        fileterMap = availableFilterMap;
      });
    } else {}
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
      if (widget.router != "homesearch") {
        urlname =
            "${baseUrl}default/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[pageSize]=20&searchCriteria[filter_groups][0][filters][0][value]=${widget.productId}&searchCriteria[current_page]=$page$sortAppend";
      } else {
        urlname =
            "${baseUrl}default/V1/products?searchCriteria[filter_groups][0][filters][0][field]=name&searchCriteria[filter_groups][0][filters][0][condition_type]=like&searchCriteria[pageSize]=20&searchCriteria[filter_groups][0][filters][0][value]=%25${widget.productId}%25&searchCriteria[current_page]=$page$sortAppend";
      }
      ApiResponseModel response = await getApiCall(
        getUrl: urlname,
        headers: headers,
        context: context,
      );
      if (response.statusCode == 200) {
        Map responseMap = response.responseValue;
        List listItem = responseMap["items"];
        print(listItem.length);
        setState(() {
          if (sortAppend == "") {
            tempProductList.addAll(listItem);
          } else {}
          productList.addAll(listItem);
          apiupdate = false;
        });
      } else {}
    }
  }

  updateProductList1() async {
    if (productList.length == totalPageSize) {
    } else {
      page += 1;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      if (widget.filter["filter_code"] == "cat") {
        urlname =
            "$baseUrl$lang/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[pageSize]=20&searchCriteria[filter_groups][0][filters][0][value]=${widget.productId}$sortAppend";
      } else if (widget.filter["filter_code"] == "price") {
        String filtercode = widget.filter["value"];

        if (filtercode.startsWith('-')) {
          String filter = filtercode.substring(1);
          urlname =
              "$baseUrl$lang/V1/products?searchCriteria[filter_groups][0][filters][0][field]=price&searchCriteria[filter_groups][0][filters][0][condition_type]=from&searchCriteria[pageSize]=20&searchCriteria[filter_groups][0][filters][0][value]=0&searchCriteria[filter_groups][0][filters][0][condition_type]=to&searchCriteria[filter_groups][0][filters][0][value]=$filter";
        } else if (filtercode.endsWith('-')) {
          String filter = filtercode.replaceAll('-', '');
          urlname =
              "$baseUrl$lang/V1/products?searchCriteria[filter_groups][0][filters][0][field]=price&searchCriteria[filter_groups][0][filters][0][condition_type]==gteq&searchCriteria[pageSize]=20&searchCriteria[filter_groups][0][filters][0][value]=$filter";
        } else {
          List filter = filtercode.split('-');
          // print(filter[0]);
          // print(filter[1]);
          urlname =
              "$baseUrl$lang/V1/products?searchCriteria[filter_groups][1][filters][0][field]=price&searchCriteria[filter_groups][1][filters][0][value]=${filter[0]}&searchCriteria[filter_groups][1][filters][0][condition_type]=gteq&searchCriteria[filter_groups][2][filters][0][field]=price&searchCriteria[filter_groups][2][filters][0][value]=${filter[1]}&searchCriteria[filter_groups][2][filters][0][condition_type]=lteq&searchCriteria[pageSize]=20";
        }
      } else {
        urlname =
            "$baseUrl$lang/V1/products?searchCriteria[filter_groups][0][filters][0][field]=${widget.filter["filter_code"]}&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&searchCriteria[pageSize]=20&searchCriteria[filter_groups][1][filters][0][value]=${widget.filter["value"]}$sortAppend";
      }
      ApiResponseModel response = await getApiCall(
        getUrl: urlname,
        headers: headers,
        context: context,
      );

      if (response.statusCode == 200) {
        Map responseMap = response.responseValue;
        List listItem = responseMap["items"];
        print(listItem.length);
        setState(() {
          if (sortAppend == "") {
            tempProductList.addAll(listItem);
          } else {}
          productList.addAll(listItem);
          apiupdate = false;
        });
      } else {}
    }
  }

  navigationToCategoriesScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoriesScreen(
          router: "search",
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
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: whiteColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: appBarColor,
          brightness: Brightness.dark,
          elevation: 0,
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
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      showMaterialModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter mystate) {
                                return SingleChildScrollView(
                                  controller: ModalScrollController.of(context),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, bottom: 5, top: 15),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/icon/sortIcon.png",
                                              color: secondaryColor,
                                              height: 20,
                                              width: 20,
                                            ),
                                            sizedBoxwidth10,
                                            Text(
                                              LocaleKeys.Sort.tr(),
                                              style: TextStyle(
                                                  color: secondaryColor,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      Container(
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: storItems.length,
                                          itemBuilder: (context, index) {
                                            return sortItem(
                                              title: storItems[index],
                                              index: index,
                                              mystate: mystate,
                                            );
                                          },
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 15, bottom: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    sortAppend = "";
                                                    productList =
                                                        tempProductList;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Center(
                                                  child: Text(
                                                    LocaleKeys.clear.tr(),
                                                    style: TextStyle(
                                                        color: appBarColor,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            sizedBoxwidth30,
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    widget.router == "search"
                                                        ? getProductList1()
                                                        : getProductList();

                                                    // widget.router != "search"
                                                    //     ? getProductList()
                                                    //     : getProductList1();
                                                    Navigator.pop(context);
                                                  },
                                                  child: customButton(
                                                    title:
                                                        LocaleKeys.apply.tr(),
                                                    backgroundColor:
                                                        secondaryColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          });
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icon/sortIcon.png",
                          height: 20,
                          width: 20,
                        ),
                        sizedBoxwidth5,
                        Text(
                          LocaleKeys.Sort.tr(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    thickness: 2,
                  ),
                  categoryList.isNotEmpty == true
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FilterByCategoriesScreen(
                                  categoriesList: categoryList,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                "+ ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                LocaleKeys.Category.tr(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  // fileterMap != null
                  //     ?
                  VerticalDivider(
                    thickness: 2,
                  ),
                  //: Container(),
                  // fileterMap != null
                  //     ?
                  InkWell(
                    onTap: () {
                      if (widget.router == "search") {
                        navigationToCategoriesScreen();
                      } else {
                        if (fileterMap != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FilterScreen(
                                filterMap: fileterMap,
                              ),
                            ),
                          );
                        } else {
                          null;
                        }
                      }
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => FilterScreen(
                      //       filterMap: fileterMap,
                      //     ),
                      //   ),
                      // );
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icon/filterIcon.png",
                          height: 20,
                          width: 20,
                        ),
                        sizedBoxwidth5,
                        Text(
                          LocaleKeys.Filter.tr(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                  //  : Container(),
                ],
              ),
            ),
          ),
        ),
        body: ProgressHUD(
          child: Builder(
            builder: (context) => Container(
              height: double.infinity,
              width: double.infinity,
              child: initialAppLoader == true
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
                          if (!apiupdate) {
                            setState(() {
                              if (productList.length == totalPageSize) {
                              } else {
                                apiupdate = true;
                                widget.router == "search"
                                    ? updateProductList1()
                                    : updateProductList();

                                // widget.router != "search"
                                //     ? updateProductList()
                                //     : updateProductList1();
                              }
                            });
                          }
                        }
                      },
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            //search
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchScreen(),
                                  ),
                                );
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
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleKeys.Showing.tr() +
                                        " ${productList.length} " +
                                        LocaleKeys.Out_Of.tr() +
                                        " $totalPageSize " +
                                        LocaleKeys.Products.tr(),
                                    // "Showing ${productList.length} Out Of ${widget.filter["count"]} Products",

                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        layoutStyle = !layoutStyle;
                                      });
                                    },
                                    child: Image.asset(
                                      layoutStyle != true
                                          ? "assets/icon/gridViewIcon.png"
                                          : "assets/icon/categoriesBlueIcon.png",
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            layoutStyle == true
                                ? productList.isNotEmpty == true
                                    ? GridView.count(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.66,
                                        controller: ScrollController(
                                            keepScrollOffset: false),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        children: List.generate(
                                          productList.length,
                                          (index) {
                                            return ProductGrid(
                                              productDetails:
                                                  productList[index],
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
                                          child: Text(
                                              LocaleKeys.Category_Empty.tr()),
                                        ),
                                      )
                                : productList.isNotEmpty == true
                                    ? Container(
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: productList.length,
                                          itemBuilder: (context, index) {
                                            return ProductList(
                                              productDetails:
                                                  productList[index],
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
                                          child: Text(
                                            LocaleKeys.Category_Empty.tr(),
                                          ),
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
          ),
        ),
      ),
    );
  }
}
