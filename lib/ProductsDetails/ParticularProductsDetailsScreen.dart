import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:menahub/CustomAlertBox/CustomAlertBox.dart';
import 'package:menahub/CustomWidget/CustomButton.dart';
import 'package:menahub/CustomWidget/CustomTextBox.dart';
import 'package:menahub/DashBoard/MyCartScreen/MyCartScreen.dart';
import 'package:menahub/ProductsDetails/ProductsDetailsScreen.dart';
import 'package:menahub/ReviewScreen/ReviewScreen.dart';
import 'package:menahub/SearchScreen/SearchScreen.dart';
import 'package:menahub/SignIn_SignUp_Flow/SignInScreen/SignInScreen.dart';
import 'package:menahub/Template/HomeScreen/Block2.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/config/AppLoader.dart';
import 'package:menahub/config/CustomLoader.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'SellerListScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:menahub/translation/codegen_loader.g.dart';
import 'package:menahub/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ParticularProductsDetailsScreen extends StatefulWidget {
  ParticularProductsDetailsScreen(
      {this.productSkuId, this.apiType, this.router, this.qty});

  final String apiType;
  final productSkuId;
  String qty;
  String router;

  @override
  _ParticularProductsDetailsScreenState createState() =>
      _ParticularProductsDetailsScreenState();
}

class _ParticularProductsDetailsScreenState
    extends State<ParticularProductsDetailsScreen> {
  final formKey = new GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController reviewTitleTextfield = TextEditingController();
  TextEditingController reviewDescriptionTextfield = TextEditingController();
  TextEditingController nameTextfield = TextEditingController();

  // TextEditingController emailTextfield = TextEditingController();
  String details;
  String errorMessage;
  List<String> imgList = [];
  String relatedimgList;
  int finalratingquality;
  int finalratingvalue;
  int finalratingprice;
  int finalrating;
  int productCount = 1;
  String productDescription;
  String deliveryDetails;
  String warrantyDetails;
  String productBrand;
  String configure;
  bool reviewVisible = false;
  List relatedProduct;
  String productDetailsList;
  Map productDetials;
  String productID;
  Map relatedproductDetials;
  String configue;
  List sellerDataList = [];
  List configoptions;
  List configdetails;
  List sellerData = [];
  List otherSellersData = [];
  List productList = [];
  Map sellers;
  Map othersellers;
  bool userType;
  var cartCount = 0;
  var pageSize;
  int _current = 0;
  var price;

  var specialPrice;
  var alternateText;
  var sellerRating;
  var count;
  String shortDescription;
  List product = [];
  int totalPageSize = 0;
  int page = 10;
  bool apiupdate = false;
  ScrollController _scrollController = ScrollController();
  List updateProduct = [];
  List updateProductCount = [];
  bool loader = false;

  @override
  void initState() {
    getLocalInformation();
    getProductDetails();
    super.initState();
    widget.router == "mycart" ? productCount = int.parse(widget.qty) : 1;
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
        // getUrl: "${productViewByIdApi}MHSKURXI5K",
        headers: headers,
        context: context,
      );
    } else {
      response = await getApiCall(
        getUrl: "$productsDetailsUrl${widget.productSkuId}",
        // getUrl: "${productsDetailsUrl}MHSKURXI5K",

        headers: headers,
        context: context,
      );
    }

    Map productDetails = response.responseValue;
    if (response.statusCode == 200) {
      setState(() {
        this.productDetials = productDetails;
        relatedProduct = productDetails["product_links"];
        for (var i = 0; i < relatedProduct.length; i++) {
          var singleProduct = relatedProduct[i]["linked_product_sku"];
          product.add(singleProduct);
        }
        getRelatedProduct();
        productID = productDetials["id"].toString();
        List bannerImageList = productDetails["media_gallery_entries"];
        List imageList =
            bannerImageList.map((e) => e["file"].toString()).toList();
        imgList = imageList;
        List customAttributes = productDetails["custom_attributes"];

        // count = relatedProduct.length;

        int pricedetailsindex =
            customAttributes.indexWhere((f) => f['attribute_code'] == "cost");

        Map pricedetailsindexMap = pricedetailsindex.isNegative
            ? {"attribute_code": "null", "value": "Not Available"}
            : customAttributes[pricedetailsindex.abs()];
        price = pricedetailsindexMap["value"];
        int descriptionIndex = customAttributes
            .indexWhere((f) => f['attribute_code'] == "description");
        int sellerRatingsIndex = customAttributes
            .indexWhere((f) => f['attribute_code'] == "menahub_rating");
        int shortdescriptionIndex = customAttributes
            .indexWhere((f) => f['attribute_code'] == "short_description");
        int productDetailsIndex = customAttributes
            .indexWhere((f) => f['attribute_code'] == "product_details");
        int productBrandIndex = customAttributes
            .indexWhere((f) => f['attribute_code'] == "facebook_brand");
        Map productBrandIndexMap = productBrandIndex.isNegative
            ? {"attribute_code": "null", "value": "Not Available"}
            : customAttributes[productBrandIndex.abs()];
        int deliverydetailsindex = customAttributes
            .indexWhere((f) => f['attribute_code'] == "delivery");
        int warrantydetailsindex = customAttributes
            .indexWhere((f) => f['attribute_code'] == "warranty");
        Map warrantydetailsindexMap = warrantydetailsindex.isNegative
            ? {"attribute_code": "null", "value": "Not Available"}
            : customAttributes[warrantydetailsindex.abs()];
        Map deliverydetailsindexMap = deliverydetailsindex.isNegative
            ? {"attribute_code": "null", "value": "Not Available"}
            : customAttributes[deliverydetailsindex.abs()];
        Map sellerRatingsIndexMap = sellerRatingsIndex.isNegative
            ? {"attribute_code": "null", "value": "0"}
            : customAttributes[sellerRatingsIndex.abs()];
        productBrand = productBrandIndexMap["value"];

        deliveryDetails = deliverydetailsindexMap["value"];
        warrantyDetails = warrantydetailsindexMap["value"];
        sellerRating = sellerRatingsIndexMap["value"];
        Map productDescriptionMap = descriptionIndex.isNegative
            ? customAttributes[descriptionIndex.abs()]
            : customAttributes[descriptionIndex.abs()];
        productDescription = productDescriptionMap["value"];
        Map shortDescriptionMap = shortdescriptionIndex.isNegative
            ? {"attribute_code": "null", "value": "Not Available"}
            : customAttributes[shortdescriptionIndex.abs()];
        shortDescription = shortDescriptionMap["value"];
        Map productDetailsMap = productDetailsIndex.isNegative
            ? {"attribute_code": "null", "value": "Not Available"}
            : customAttributes[productDetailsIndex.abs()];
        details = productDetailsMap["value"];
        Map extensionAttributes = productDetails["extension_attributes"];
        configdetails = extensionAttributes["configurable_product_options"];
        sellerData = extensionAttributes["seller_data"];
        print("seller_data :$sellerData");

        print('configdetails=$configdetails');
        configoptions =
            configdetails == null ? null : configdetails[0]["values"];
        print('configoptions=$configoptions');
        for (var item in customAttributes) {
          if (item["attribute_code"] == "special_price") {
            specialPrice = item["value"];
          }
          if (item["attribute_code"] == "alternate_text") {
            alternateText = item["value"];
          }
          if (item["attribute_code"] == "menahub_rating") {
            sellerRating = item["value"];
          }
        }

        if (widget.apiType != "id") {
          sellerDataList = extensionAttributes["seller_data"];
          otherSellersData = extensionAttributes["assigned_seller_data"];

          for (Map item in sellerDataList) {
            sellers = item;
          }
          for (Map item in otherSellersData) {
            othersellers = item;
            print('othersellers=$othersellers');
          }
        }
        // print("count : $count");
      });
    } else {
      Map errorMessage = response.responseValue;
      setState(() {
        this.errorMessage = errorMessage["message"];
      });
    }
  }

  addToCart(
      {String sku, String qty, String configure, BuildContext contexts}) async {
    final progress = ProgressHUD.of(contexts);
    progress.show();
    // final overlay = LoadingOverlay.of(context);
    // overlay.show();
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
      print('response=${quoteResponseData.responseValue}');

      progress.dismiss();
      // overlay.hide();

      var body = jsonEncode({
        "cartItem": {
          "sku": sku,
          "qty": qty,
          "quote_id": quoteResponseData.responseValue,
          "product_option": {
            "extension_attributes": {
              "configurable_item_options": [
                {"option_id": "177", "option_value": configue}
              ]
            }
          }
        }
      });

      ApiResponseModel responseData = await postApiCall(
        postUrl: addCartUrl,
        headers: headers,
        context: contexts,
        body: body,
      );

      progress.dismiss();
      // overlay.hide();

      if (responseData.statusCode == 200) {
        setState(() {
          progress.dismiss();
          // overlay.hide();
          Fluttertoast.showToast(
            msg: LocaleKeys.Product_added.tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          if (userType == true) {
            progress.dismiss();
            // overlay.hide();

            getGuestCartCount();
          } else {
            getCartCount();
            progress.dismiss();
            // overlay.hide();

          }
        });
      } else {
        progress.dismiss();
        // overlay.hide();

        Map errorMessage = responseData.responseValue;
        print("Error Message =$errorMessage");
        Fluttertoast.showToast(
          msg: LocaleKeys.Choose_Size.tr(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        progress.dismiss();
        // overlay.hide();
      }
    }
  }

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
      progress.dismiss();
      var body = jsonEncode({
        "cartItem": {
          "sku": sku,
          "qty": qty,
          "quote_id": quoteResponseData.responseValue,
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
            msg: LocaleKeys.Product_added.tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
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
      "cartItem": {
        "sku": sku,
        "qty": qty,
        "quote_id": token,
        "product_option": {
          "extension_attributes": {
            "configurable_item_options": [
              {"option_id": "177", "option_value": configue}
            ]
          }
        }
      }
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
          msg: LocaleKeys.Product_added.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        if (userType == true) {
          getGuestCartCount();
          progress.dismiss();
        } else {
          progress.dismiss();

          getCartCount();
        }
      });
    } else {
      progress.dismiss();
      print("error");
      Fluttertoast.showToast(
        msg: LocaleKeys.Choose_Size.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    progress.dismiss();
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
      print("cartList.length");

      print(cartList.length);
      setState(() {
        cartCount = cartList.length;
      });
    } else {}
  }

  getGuestCartCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("guestId");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    ApiResponseModel response = await getApiCall(
      getUrl: "${baseUrl}default/V1/guest-carts/$token/totals",
      headers: headers,
      context: context,
    );
    Map responseData = response.responseValue;
    if (response.statusCode == 200) {
      List cartList = responseData["items"];
      print("cartList.length");

      print(cartList.length);
      setState(() {
        cartCount = cartList.length;
      });
    } else {}
  }

  postReview() async {
    // final progress = ProgressHUD.of(contexts);
    // progress.show();
    // final overlay = LoadingOverlay.of(context);
    // overlay.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    var body = jsonEncode({
      "title": reviewTitleTextfield.text,
      "detail": reviewDescriptionTextfield.text,
      "nickname": nameTextfield.text,
      "rating_data": [
        {"rating_id": 4, "rating_value": finalrating},
        {"rating_id": 3, "rating_value": finalratingprice},
        {"rating_id": 2, "rating_value": finalratingvalue},
        {"rating_id": 1, "rating_value": finalratingquality}
      ],
      "review_entity": "product",
      "review_status": 2,
      "product_id": productID
    });

    ApiResponseModel responseData = await postApiCall(
      postUrl: reviewpost,
      headers: headers,
      context: context,
      body: body,
    );

    // progress.dismiss();
    // overlay.hide();

    if (responseData.statusCode == 200) {
      print(responseData.responseValue);
      setState(() {
        // progress.dismiss();
        // overlay.hide();
        Fluttertoast.showToast(
          msg: LocaleKeys.review_commit.tr(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        if (userType == true) {
          // progress.dismiss();
          // overlay.hide();

        } else {
          // progress.dismiss();
          // overlay.hide();

        }
      });
    } else {
      // progress.dismiss();
      // overlay.hide();

      Map errorMessage = responseData.responseValue;
      print("Error Message =$errorMessage");
      Fluttertoast.showToast(
        msg: LocaleKeys.review_error.tr(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // progress.dismiss();
      // overlay.hide();
    }
  }

  getRelatedProduct() async {
    String listAsStr = product.toString(); // get list as string
    listAsStr = listAsStr.substring(
        1, listAsStr.length - 1); // removing first and last bracket
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    ApiResponseModel response = await getApiCall(
      getUrl:
          "$baseUrl$lang/V1/products?searchCriteria[filter_groups][0][filters][0][field]=sku&searchCriteria[filter_groups][0][filters][0][condition_type]=in&searchCriteria[filter_groups][0][filters][0][value]=${listAsStr.replaceAll(' ', '')}&searchCriteria[filter_groups][2][filters][0][field]=visibility&searchCriteria[filter_groups][2][filters][0][value]=4&searchCriteria[filter_groups][3][filters][0][field]=status&searchCriteria[filter_groups][3][filters][0][value]=1&searchCriteria[pageSize]=10",
      headers: headers,
      context: context,
    );
    if (response.statusCode == 200) {
      Map responseMap = response.responseValue;
      print("responseMap : $responseMap");
      List listItem = responseMap["items"];
      print("listItem : $listItem");
      Map search = responseMap["search_criteria"];
      pageSize = search["page_size"];
      setState(() {
        // productList = listItem;
        updateProductList();
        totalPageSize = responseMap["total_count"];
        print("totalPageSize : $totalPageSize");
      });
    } else {}
  }

  updateProductList() async {
    var tempCount = relatedProduct.length;
    if (tempCount <= 10) {
      String listAsStr = product.toString(); // get list as string
      listAsStr = listAsStr.substring(
          1, listAsStr.length - 1); // removing first and last bracket

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      ApiResponseModel response = await getApiCall(
        getUrl:
            "$baseUrl$lang/V1/products?searchCriteria[filter_groups][0][filters][0][field]=sku&searchCriteria[filter_groups][0][filters][0][condition_type]=in&searchCriteria[filter_groups][0][filters][0][value]=${listAsStr.replaceAll(' ', '')}&searchCriteria[filter_groups][2][filters][0][field]=visibility&searchCriteria[filter_groups][2][filters][0][value]=4&searchCriteria[filter_groups][3][filters][0][field]=status&searchCriteria[filter_groups][3][filters][0][value]=1&searchCriteria[pageSize]=10",
        headers: headers,
        context: context,
      );
      if (response.statusCode == 200) {
        Map responseMap = response.responseValue;
        print("responseMap : $responseMap");
        List listItem = responseMap["items"];
        Map search = responseMap["search_criteria"];
        pageSize = search["page_size"];
        setState(() {
          productList = listItem;
          apiupdate = false;
          loader = true;
          // updateProductList();
          totalPageSize = responseMap["total_count"];
        });
      } else {}
    } else {
      if (updateProduct.isNotEmpty) {
        updateProduct.removeRange(0, 10);
      }
      var j = 10;
      var count = updateProductCount.length;
      for (var i = count; i < count + j; i++) {
        var singleProduct = product[i];
        var singleProductCount = product[i];
        updateProduct.add(singleProduct);
        updateProductCount.add(singleProductCount);
      }
      String listAsStr = updateProduct.toString(); // get list as string
      listAsStr = listAsStr.substring(
          1, listAsStr.length - 1); // removing first and last bracket
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      ApiResponseModel response = await getApiCall(
        getUrl:
            "$baseUrl$lang/V1/products?searchCriteria[filter_groups][0][filters][0][field]=sku&searchCriteria[filter_groups][0][filters][0][condition_type]=in&searchCriteria[filter_groups][0][filters][0][value]=${listAsStr.replaceAll(' ', '')}&searchCriteria[filter_groups][2][filters][0][field]=visibility&searchCriteria[filter_groups][2][filters][0][value]=4&searchCriteria[filter_groups][3][filters][0][field]=status&searchCriteria[filter_groups][3][filters][0][value]=1&searchCriteria[pageSize]=10",
        headers: headers,
        context: context,
      );
      if (response.statusCode == 200) {
        Map responseMap = response.responseValue;
        print("responseMap : $responseMap");
        List listItem = responseMap["items"];
        setState(() {
          productList.addAll(listItem);
          apiupdate = false;
        });
      } else {}
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

  @override
  Widget build(BuildContext context) {
    // double sellerPercentage = double.parse(sellerRating) * 20;
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: Locale(context.locale.languageCode),
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
                          : Form(
                              key: formKey,
                              // ignore: deprecated_member_use
                              autovalidate: _autoValidate,
                              child: Column(
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
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: CarouselSlider(
                                                items: imgList
                                                    .map(
                                                      (item) => Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: ClipRRect(
                                                          child: Image.network(
                                                              "$imageBaseUrl$item",
                                                              fit: BoxFit
                                                                  .contain,
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
                                                  onPageChanged:
                                                      (index, reason) {
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            alignment: Alignment.bottomCenter,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: imgList.map((url) {
                                                int index =
                                                    imgList.indexOf(url);
                                                return Container(
                                                  width: 8.0,
                                                  height: 8.0,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 2.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0,
                                                          right: 0.0),
                                                  child: Container(
                                                    height: 40,
                                                    child: Center(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              'SKU: ${productDetials["sku"]}'
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    5, 0, 5, 0),
                                                            child:
                                                                VerticalDivider(
                                                              thickness: 1,
                                                              width: 2,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 4,
                                                            child: Text(
                                                              productDetials[
                                                                  "name"],
                                                              softWrap: true,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
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

                                          Visibility(
                                            visible: alternateText != null,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0, top: 10),
                                                child: Text("$alternateText")),
                                          ),
                                          sizedBoxheight10,

                                          if (productDetials != null)
                                            // if (productDetials["price"] != 0)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Row(
                                                children: [
                                                  productDetials["extension_attributes"]
                                                              [
                                                              "custom_final_price"] ==
                                                          null
                                                      ? Text(
                                                          "QAR ${productDetials["price"].toStringAsFixed(2).toString()}",
                                                          style: TextStyle(
                                                            color:
                                                                secondaryColor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        )
                                                      : Text(
                                                          "QAR ${double.parse((productDetials["extension_attributes"]["custom_final_price"])).toStringAsFixed(2).toString()}",
                                                          style: TextStyle(
                                                            color:
                                                                secondaryColor,
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
                                                    LocaleKeys.Available_Quote
                                                        .tr(),
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
                                            ),
                                          // else
                                          //   Container(),
                                          sizedBoxheight10,
                                          if (productBrand != null)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    LocaleKeys.Brand.tr() +
                                                        " : ",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  productBrand ==
                                                          'Not Available'
                                                      ? Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            productDetials[
                                                                    "name"]
                                                                .split("|")[0],
                                                            softWrap: true,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: TextStyle(
                                                                color:
                                                                    orangeColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      : Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            "$productBrand",
                                                            softWrap: true,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: TextStyle(
                                                              color:
                                                                  orangeColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          Visibility(
                                            visible: shortDescription !=
                                                "Not Available",
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 20,
                                                  bottom: 0),
                                              child: Html(
                                                data: shortDescription,
                                              ),
                                            ),
                                          ),

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
                                                                      bottom:
                                                                          5),
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
                                                                productCount +=
                                                                    1;
                                                              });
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      right: 10,
                                                                      top: 5,
                                                                      bottom:
                                                                          5),
                                                              child: Text("+"),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    sizedBoxwidth30,
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (deliveryDetails != null)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 0, 0),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Image(
                                                        image: AssetImage(
                                                            "assets/Socialmedia/delivery.png"),
                                                        height: 50,
                                                        width: 50,
                                                      ),
                                                      Text(
                                                        "$deliveryDetails",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  sizedBoxwidth10,
                                                  if (warrantyDetails != null)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: [
                                                          Image(
                                                            image: AssetImage(
                                                                "assets/Socialmedia/warranty.png"),
                                                            height: 50,
                                                            width: 50,
                                                          ),
                                                          Text(
                                                            "$warrantyDetails",
                                                            softWrap: true,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  sizedBoxwidth10,
                                                  // configoptions != null
                                                  //     ? Expanded(
                                                  //         flex: 1,
                                                  //         child: DropdownButtonHideUnderline(
                                                  //             child: ButtonTheme(
                                                  //                 alignedDropdown: true,
                                                  //                 child: Padding(
                                                  //                   padding:
                                                  //                       const EdgeInsets
                                                  //                               .fromLTRB(
                                                  //                           5,
                                                  //                           5,
                                                  //                           5,
                                                  //                           0),
                                                  //                   child: DropdownButtonFormField(
                                                  //                       hint: Text('Size'),
                                                  //                       decoration: InputDecoration(
                                                  //                         focmusedBorder:
                                                  //                             UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF0D3451))),
                                                  //                       ),
                                                  //                       // focusNode: myFocusNode,
                                                  //                       icon: Icon(Icons.keyboard_arrow_down_outlined),
                                                  //                       value: configue,
                                                  //                       //   onTap: () => node.requestFocus(),
                                                  //
                                                  //                       onChanged: (newValue) {
                                                  //                         setState(
                                                  //                             () async {
                                                  //                           configue =
                                                  //                               newValue;
                                                  //                           print(
                                                  //                               configue);
                                                  //                         });
                                                  //                       }, //
                                                  //                       validator: (value) => value == null ? 'field required' : null,
                                                  //                       items: configoptions == null
                                                  //                           ? []
                                                  //                           : configoptions.map((item) {
                                                  //                               return DropdownMenuItem(
                                                  //                                   // value: item['code'].toString(),
                                                  //                                   value: item['value_index'].toString(),
                                                  //                                   child: Row(
                                                  //                                     mainAxisAlignment: MainAxisAlignment.start,
                                                  //                                     children: <Widget>[
                                                  //                                       Container(
                                                  //                                         margin: EdgeInsets.only(left: 0),
                                                  //                                         child: Text(item['value_index'].toString()),
                                                  //
                                                  //                                         // child: Text(item['label'].toString()),
                                                  //                                       ),
                                                  //                                     ],
                                                  //                                   ));
                                                  //                             }).toList()),
                                                  //                 ))),
                                                  //       )
                                                  //     : Container()
                                                ],
                                              ),
                                            ),

                                          Divider(
                                            thickness: 1,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20, 0),
                                            child: Row(
                                              children: [
                                                Text("Ships from: "),
                                                Text(
                                                  "Mena Hub",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (sellers != null)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20, 10),
                                              child: Row(
                                                children: [
                                                  Text(LocaleKeys.Sold_By.tr() +
                                                      ' : '),
                                                  Text(
                                                    sellers["shop_title"] ==
                                                            null
                                                        ? LocaleKeys
                                                            .Not_Available.tr()
                                                        : '${sellers["shop_title"]}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: orangeColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20, 0),
                                              child: Text("Seller Rating")),

                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      14, 0, 20, 10),
                                              child: Column(
                                                children: [
                                                  //Text("Seller Rating"),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 2),
                                                    child: Row(
                                                      children: [
                                                        SmoothStarRating(
                                                          allowHalfRating: true,
                                                          isReadOnly: true,
                                                          starCount: 5,
                                                          rating: double.parse(
                                                              sellerRating),
                                                          size: 18.0,
                                                          color: orangeColor,
                                                          borderColor:
                                                              orangeColor,
                                                          spacing: 0.0,
                                                        ),
                                                        Text(
                                                            "${double.parse(sellerRating).round() * 20.round()}% of 100"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 20, 0),
                                              child: Text("Response Rate")),
                                          if(sellerData[0]["response_rate"]==100)

                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                14, 0, 20, 0),
                                            child: LinearPercentIndicator(
                                              width: 100,
                                              lineHeight: 6,
                                              percent: sellerData[0]["response_rate"]*0.01,
                                              backgroundColor: Colors.grey,
                                              progressColor: orangeColor,
                                            ),
                                          )
                                          else
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  14, 0, 20, 0),
                                              child: LinearPercentIndicator(
                                                width: 100,
                                                lineHeight: 6,
                                                percent: double.parse(sellerData[0]["response_rate"]).toInt()*0.01,
                                                backgroundColor: Colors.grey,
                                                progressColor: orangeColor,
                                              ),
                                            ),

                                          if(sellerData[0]["response_rate"]==100)
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 20, 10),
                                              child: Text("${sellerData[0]["response_rate"]}%"))
                                          else
    Padding(
    padding:
    const EdgeInsets.fromLTRB(
    20, 0, 20, 10),
    child: Text("${double.parse(sellerData[0]["response_rate"]).toInt()}%")),
                                          Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  20, 0, 20, 0),
                                              child: Text("Always In Stock")),
                                          if(sellerData[0]["always_in_stock"]==100)
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                14, 0, 20, 0),
                                            child: LinearPercentIndicator(
                                              width: 100,
                                              lineHeight: 6,
                                              percent: 1,
                                              // sellerData[0]["always_in_stock"]*0.01,
                                              backgroundColor: Colors.grey,
                                              progressColor: orangeColor,
                                            ),
                                          )
                                          else
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  14, 0, 20, 0),
                                              child: LinearPercentIndicator(
                                                width: 100,
                                                lineHeight: 6,
                                                percent:double.parse(sellerData[0]["always_in_stock"]).toInt()*0.01,
                                                backgroundColor: Colors.grey,
                                                progressColor: orangeColor,
                                              ),
                                            ),
                                          if(sellerData[0]["always_in_stock"]==100)

                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  20, 0, 20, 0),
                                              child: Text(
                                                  "${sellerData[0]["always_in_stock"]}%"
                                              ))
                                          else
                                            Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(
                                                    20, 0, 20, 0),
                                                child: Text(
    "${double.parse(sellerData[0]["always_in_stock"]).toInt()}%"
                                                )),


                                          if (otherSellersData.isNotEmpty ==
                                              true)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20, 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    LocaleKeys.Sold_by.tr() +
                                                        ' '
                                                            "${otherSellersData.length} " +
                                                        LocaleKeys.More_Sellers
                                                            .tr(),
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                                otherSellersData,
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
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                15, 5, 15, 5),
                                                        child: Text(
                                                          LocaleKeys
                                                                  .View_Sellers
                                                              .tr(),
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
                                          Divider(
                                            thickness: 1,
                                          ),

                                          // Container(
                                          //   child: ListView.builder(
                                          //     shrinkWrap: true,
                                          //     physics:
                                          //         NeverScrollableScrollPhysics(),
                                          //     scrollDirection: Axis.vertical,
                                          //     itemCount:
                                          //         productDetailsList.length,
                                          //     itemBuilder: (context, index) {
                                          //       return Container(
                                          //         child: Padding(
                                          //           padding:
                                          //               const EdgeInsets.only(
                                          //                   left: 20.0,
                                          //                   bottom: 5,
                                          //                   right: 20),
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
                                          productDescription != null
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        LocaleKeys.Description
                                                                .tr() +
                                                            " :",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Html(
                                                        data:
                                                            productDescription,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(),

                                          sizedBoxheight5,
                                          Divider(
                                            thickness: 1,
                                          ),

                                          if (sellerDataList.isNotEmpty == true)
                                            Divider(),
                                          Visibility(
                                            visible: details == "Not Available"
                                                ? false
                                                : true,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    LocaleKeys.Specification
                                                            .tr() +
                                                        " : ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Html(
                                                    data: details,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          relatedProduct.isNotEmpty == true
                                              ? Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 20,
                                                              bottom: 10),
                                                      child: Text(
                                                        LocaleKeys
                                                                .RELATED_PRODUCTS
                                                                .tr() +
                                                            " :",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                          relatedProduct.isNotEmpty
                                              ? Container(
                                                  color: Colors.white,
                                                  padding: EdgeInsets.only(
                                                      bottom: 0),
                                                  height: 200,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: NotificationListener<
                                                            ScrollEndNotification>(
                                                          child:
                                                              ListView.builder(
                                                            shrinkWrap: true,
                                                            controller:
                                                                _scrollController,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                productList
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              Map customAttributesMap =
                                                                  productList[
                                                                      index];
                                                              List custom =
                                                                  customAttributesMap[
                                                                      "custom_attributes"];
                                                              int producImageIndex =
                                                                  custom.indexWhere((f) =>
                                                                      f['attribute_code'] ==
                                                                      "image");
                                                              Map productDescriptionMap =
                                                                  custom[
                                                                      producImageIndex
                                                                          .abs()];
                                                              var productImage =
                                                                  productDescriptionMap[
                                                                      "value"];
                                                              Map extension =
                                                                  productList[
                                                                          index]
                                                                      [
                                                                      "extension_attributes"];
                                                              return InkWell(
                                                                onTap: () {
                                                                  navigationViewAllProduct(
                                                                      productList[
                                                                              index]
                                                                          [
                                                                          "sku"]);
                                                                },
                                                                child: Card(
                                                                  child:
                                                                      Container(
                                                                    color: Colors
                                                                        .white,
                                                                    width: (MediaQuery.of(context).size.width /
                                                                            2.5) -
                                                                        20,
                                                                    margin: EdgeInsets
                                                                        .all(5),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Expanded(
                                                                          child: Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                                image: DecorationImage(
                                                                                  image: NetworkImage("$imageBaseUrl$productImage"),
                                                                                  fit: BoxFit.contain,
                                                                                ),
                                                                              ),
                                                                              child: null),
                                                                        ),
                                                                        sizedBoxheight5,
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(left: 7.0),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                height: 15,
                                                                                width: MediaQuery.of(context).size.width,
                                                                                child: Text(
                                                                                  "${productList[index]["name"]}",
                                                                                  softWrap: true,
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              sizedBoxheight5,
                                                                              Text(
                                                                                "QAR ${double.parse((productList[index]["extension_attributes"]["custom_final_price"])).toStringAsFixed(2).toString()}",
                                                                                style: TextStyle(
                                                                                  fontSize: 14,
                                                                                  color: secondaryColor,
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
                                                              );
                                                            },
                                                          ),
                                                          onNotification:
                                                              (notification) {
                                                            if (_scrollController
                                                                    .position
                                                                    .pixels ==
                                                                _scrollController
                                                                    .position
                                                                    .maxScrollExtent) {
                                                              setState(() {
                                                                if (updateProductCount
                                                                        .length ==
                                                                    totalPageSize) {
                                                                } else {
                                                                  if (loader ==
                                                                      true) {
                                                                  } else {
                                                                    apiupdate =
                                                                        true;
                                                                    updateProductList();
                                                                  }
                                                                }
                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(),

                                          userType != true
                                              ? Divider(
                                                  thickness: 2,
                                                )
                                              : Container(),
                                          userType != true
                                              ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      reviewVisible =
                                                          reviewVisible == false
                                                              ? true
                                                              : false;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  20, 0, 20, 0),
                                                          child: Icon(Icons
                                                              .rate_review),
                                                        ),
                                                        Text(
                                                          LocaleKeys
                                                              .WRITE_A_REVIEW
                                                              .tr(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          Visibility(
                                            visible: reviewVisible == true
                                                ? true
                                                : false,
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        20, 10, 20, 0),
                                                    child: Text(LocaleKeys
                                                        .required_field
                                                        .tr()),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                20, 20, 20, 0),
                                                        child: Text(
                                                          LocaleKeys.Quality
                                                              .tr(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                20, 10, 20, 0),
                                                        child:
                                                            RatingBar.builder(
                                                          initialRating: 0,
                                                          minRating: 1,
                                                          itemSize: 25,
                                                          direction:
                                                              Axis.horizontal,
                                                          // allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemPadding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      4.0),
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  Icon(
                                                            Icons.star,
                                                            color: Colors.red,
                                                          ),
                                                          onRatingUpdate:
                                                              (rating) {
                                                            finalratingquality =
                                                                rating.toInt();
                                                            print(rating);
                                                            print(
                                                                finalratingquality);
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                20, 20, 20, 0),
                                                        child: Text(
                                                          LocaleKeys.Value.tr(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                20, 10, 20, 0),
                                                        child:
                                                            RatingBar.builder(
                                                          initialRating: 0,
                                                          minRating: 1,
                                                          itemSize: 25,
                                                          direction:
                                                              Axis.horizontal,
                                                          // allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemPadding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      4.0),
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  Icon(
                                                            Icons.star,
                                                            color: Colors.red,
                                                          ),
                                                          onRatingUpdate:
                                                              (rating) {
                                                            finalratingvalue =
                                                                rating.toInt();
                                                            print(rating);
                                                            print(
                                                                finalratingvalue);
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                20, 20, 20, 0),
                                                        child: Text(
                                                          LocaleKeys.Price.tr(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                20, 10, 20, 0),
                                                        child:
                                                            RatingBar.builder(
                                                          initialRating: 0,
                                                          minRating: 1,
                                                          itemSize: 25,
                                                          direction:
                                                              Axis.horizontal,
                                                          // allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemPadding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      4.0),
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  Icon(
                                                            Icons.star,
                                                            color: Colors.red,
                                                          ),
                                                          onRatingUpdate:
                                                              (rating) {
                                                            finalratingprice =
                                                                rating.toInt();
                                                            print(rating);
                                                            print(
                                                                finalratingprice);
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                20, 20, 20, 0),
                                                        child: Text(
                                                          LocaleKeys.Rating
                                                              .tr(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                20, 10, 20, 0),
                                                        child:
                                                            RatingBar.builder(
                                                          initialRating: 0,
                                                          minRating: 1,
                                                          itemSize: 25,
                                                          direction:
                                                              Axis.horizontal,
                                                          // allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemPadding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      4.0),
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  Icon(
                                                            Icons.star,
                                                            color: Colors.red,
                                                          ),
                                                          onRatingUpdate:
                                                              (rating) {
                                                            finalrating =
                                                                rating.toInt();
                                                            print(rating);
                                                            print(finalrating);
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        20, 20, 20, 0),
                                                    child: Text(
                                                      LocaleKeys.Title.tr(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        validator: (text) {
                                                          if (text == null ||
                                                              text.isEmpty) {
                                                            return LocaleKeys
                                                                .req
                                                                .tr();
                                                          }
                                                          return null;
                                                        },
                                                        controller:
                                                            reviewTitleTextfield,
                                                        decoration:
                                                            new InputDecoration(
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black12,
                                                                    width: 2.0),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black12,
                                                                    width: 2.0),
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black12,
                                                                    width: 2.0),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .red,
                                                                    width: 2.0),
                                                          ),
                                                          disabledBorder:
                                                              InputBorder.none,
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 15,
                                                                  right: 15),
                                                          hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: greyColor,
                                                          ),
                                                          errorMaxLines: 4,
                                                        ),
                                                      )),

                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        20, 20, 20, 0),
                                                    child: Text(
                                                      LocaleKeys.Review.tr(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        validator: (text) {
                                                          if (text == null ||
                                                              text.isEmpty) {
                                                            return LocaleKeys
                                                                .req
                                                                .tr();
                                                          }
                                                          return null;
                                                        },
                                                        controller:
                                                            reviewDescriptionTextfield,
                                                        decoration:
                                                            new InputDecoration(
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black12,
                                                                    width: 2.0),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black12,
                                                                    width: 2.0),
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black12,
                                                                    width: 2.0),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .red,
                                                                    width: 2.0),
                                                          ),
                                                          disabledBorder:
                                                              InputBorder.none,
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 15,
                                                                  right: 15),
                                                          hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: greyColor,
                                                          ),
                                                          errorMaxLines: 4,
                                                        ),
                                                      )),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        20, 20, 20, 0),
                                                    child: Text(
                                                      LocaleKeys.name.tr(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        validator: (text) {
                                                          if (text == null ||
                                                              text.isEmpty) {
                                                            return LocaleKeys
                                                                .req
                                                                .tr();
                                                          }
                                                          return null;
                                                        },
                                                        controller:
                                                            nameTextfield,
                                                        decoration:
                                                            new InputDecoration(
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black12,
                                                                    width: 2.0),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black12,
                                                                    width: 2.0),
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black12,
                                                                    width: 2.0),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .red,
                                                                    width: 2.0),
                                                          ),
                                                          disabledBorder:
                                                              InputBorder.none,
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 15,
                                                                  right: 15),
                                                          hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: greyColor,
                                                          ),
                                                          errorMaxLines: 4,
                                                        ),
                                                      )),
                                                  // Padding(
                                                  //   padding:
                                                  //   const EdgeInsets.fromLTRB(
                                                  //       20, 20, 20, 0),
                                                  //   child: Text(
                                                  //     '* Email',
                                                  //     style: TextStyle(
                                                  //         fontWeight:
                                                  //         FontWeight.w600,
                                                  //         fontSize: 14),
                                                  //   ),
                                                  // ),
                                                  // Padding(
                                                  //   padding:
                                                  //   const EdgeInsets.all(8.0),
                                                  //   child: Container(
                                                  //       decoration: BoxDecoration(
                                                  //         border: Border.all(
                                                  //           color: Colors.black,
                                                  //         ),
                                                  //       ),
                                                  //       height: 60,
                                                  //       child: Padding(
                                                  //           padding:
                                                  //           const EdgeInsets
                                                  //               .only(
                                                  //               left: 20.0),
                                                  //           child: Row(children: [
                                                  //             Expanded(
                                                  //                 child:
                                                  //                 TextFormField(
                                                  //                   controller:
                                                  //                   emailTextfield,
                                                  //                   decoration:
                                                  //                   new InputDecoration(
                                                  //                     border:
                                                  //                     InputBorder
                                                  //                         .none,
                                                  //                     focusedBorder:
                                                  //                     InputBorder
                                                  //                         .none,
                                                  //                     enabledBorder:
                                                  //                     InputBorder
                                                  //                         .none,
                                                  //                     errorBorder:
                                                  //                     InputBorder
                                                  //                         .none,
                                                  //                     disabledBorder:
                                                  //                     InputBorder
                                                  //                         .none,
                                                  //                     contentPadding:
                                                  //                     EdgeInsets.only(
                                                  //                         left:
                                                  //                         15,
                                                  //                         right:
                                                  //                         15),
                                                  //                     hintStyle:
                                                  //                     TextStyle(
                                                  //                       fontWeight:
                                                  //                       FontWeight
                                                  //                           .w500,
                                                  //                       color:
                                                  //                       greyColor,
                                                  //                     ),
                                                  //                     errorMaxLines:
                                                  //                     4,
                                                  //                   ),
                                                  //                 ))
                                                  //           ]))),
                                                  // ),

                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                      horizontal:
                                                                          50,
                                                                    ),
                                                                    primary:
                                                                        primaryColor,
                                                                    textStyle:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                    )),
                                                            onPressed: () {
                                                              if (formKey
                                                                      .currentState
                                                                      .validate() &&
                                                                  finalrating !=
                                                                      null &&
                                                                  finalratingprice !=
                                                                      null &&
                                                                  finalratingquality !=
                                                                      null &&
                                                                  finalratingvalue !=
                                                                      null) {
                                                                postReview();
                                                              } else {
                                                                setState(() {
                                                                  print(
                                                                      finalrating);
                                                                  print(
                                                                      finalratingquality);
                                                                  print(
                                                                      finalratingprice);
                                                                  print(
                                                                      finalratingvalue);

                                                                  _autoValidate =
                                                                      true;
                                                                });
                                                              }
                                                            },
                                                            child: Text(
                                                                LocaleKeys.POST
                                                                    .tr())),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          userType != true
                                              ? InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ReviewScreen(
                                                          productId:
                                                              productDetials[
                                                                  "id"],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Divider(
                                                            color: Colors.blue),
                                                        Text(
                                                          LocaleKeys.View_all
                                                              .tr(),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueAccent),
                                                        ),
                                                        Divider(
                                                            color: Colors.blue)
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container()
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
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    height: 50,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 5, 20, 5),
                                      child: Row(
                                        children: [
                                          // if (productDetials["price"] != 0)
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
                                                title:
                                                    LocaleKeys.ADD_TO_CART.tr(),
                                                backgroundColor: primaryColor,
                                              ),
                                            ),
                                          ),
                                          sizedBoxwidth30,
                                          // Expanded(
                                          //   child: InkWell(
                                          //     onTap: () {},
                                          //     child: customButton(
                                          //       title: "Enquire Now",
                                          //       backgroundColor: secondaryColor,
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //view product
                                ],
                              ),
                            ),
                ),
              ),
            ),
          ),
        ));
  }
}
