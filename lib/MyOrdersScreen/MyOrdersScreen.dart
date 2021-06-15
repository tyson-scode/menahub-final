import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:menahub/Template/MyOrderItem.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/config/CustomLoader.dart';
import 'package:menahub/translation/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class MyOrdersScreen extends StatefulWidget {
  final searchIndex;
  MyOrdersScreen({this.searchIndex});
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int searchIndex = 0;

  List orderTypeList = [
    LocaleKeys.All.tr(),
    LocaleKeys.Quote_Request.tr(),
    LocaleKeys.Order.tr(),
    LocaleKeys.Unpaid.tr(),
    LocaleKeys.Returns.tr()
  ];

  List apiList = [
    getOrderListApi,
    orderQuoteListApi,
    orderListApi,
    paidOrderListApi,
    returnOrderListApi,
  ];

  List orderList = [];
  bool appLoader = false;
  @override
  void initState() {
    super.initState();

    if (widget.searchIndex != null) {
      searchIndex = widget.searchIndex;
      getAllOrderList(requestUrl: apiList[widget.searchIndex]);
    } else {
      getAllOrderList(requestUrl: getOrderListApi);
    }
  }

  getAllOrderList({String requestUrl}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    print("token: $token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    ApiResponseModel responseData = await getApiCall(
      getUrl: requestUrl,
      headers: headers,
      context: context,
    );
    print(responseData.responseValue);
    if (responseData.statusCode == 200) {
      Map responseMap = responseData.responseValue;
      setState(() {
        orderList = responseMap["items"];
        appLoader = true;
      });
    } else {
      setState(() {
        appLoader = true;
      });
    }
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
            LocaleKeys.My_Orders.tr(),
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
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: HexColor("#F1F3F6"),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      color: whiteColor,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: orderTypeList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                searchIndex = index;
                                appLoader = false;
                                getAllOrderList(requestUrl: apiList[index]);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: searchIndex == index
                                          ? secondaryColor
                                          : lightGreyColor,
                                      width: 3),
                                ),
                              ),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  orderTypeList[index],
                                  style: TextStyle(
                                    color: searchIndex == index
                                        ? secondaryColor
                                        : blackColor,
                                  ),
                                ),
                              )),
                            ),
                          );
                        },
                      ),
                    ),
                    if (appLoader == false)
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height - 50,
                          child: Center(
                            child: CustomerLoader(
                              dotType: DotType.circle,
                              dotOneColor: secondaryColor,
                              dotTwoColor: primaryColor,
                              dotThreeColor: Colors.red,
                              duration: Duration(milliseconds: 1000),
                            ),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: orderList.length,
                          itemBuilder: (context, index) {
                            return orderItem(
                                searchIndex1: searchIndex,
                                orderDetails: orderList[index],
                                context: context);
                          },
                        ),
                      ),
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
