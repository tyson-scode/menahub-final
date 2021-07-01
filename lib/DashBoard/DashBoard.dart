import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:menahub/Notification/NotificationScreen.dart';
import 'package:menahub/SignIn_SignUp_Flow/SignInScreen/SignInScreen.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CategoriesScreen/CategoriesScreen.dart';
import 'EnquireNowScreen/EnquireNowScreen.dart';
import 'HomeScreen/HomeScreen.dart';
import 'MyAccountScreen/MyAccountScreen.dart';
import 'MyCartScreen/MyCartScreen.dart';
import 'package:menahub/translation/codegen_loader.g.dart';
import 'package:menahub/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class DashBoard extends StatefulWidget {
  final initialIndex;
  DashBoard({this.initialIndex});
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool userType;
  int pageIndex = 0;
  var newNotificationCount=0;


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
        getNotificationCount();
      });
    }
    print(userType);
  }

  getNotificationCount() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    ApiResponseModel responseData = await getApiCall(
      getUrl: notificationCount,
      headers: headers,
      context: context,
    );
    if (responseData.statusCode == 200) {
           setState(() {
             newNotificationCount=responseData.responseValue;
print("newNotificationCount : $newNotificationCount");
           });
    }else {
      print(responseData);
    }

    }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:
          // async => false,
          () async {
        if (Navigator.of(context).canPop()) {
          return false;
        } else
          return true;
      },
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: Locale(context.locale.languageCode),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          initialIndex: widget.initialIndex,
          length: 5,
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              elevation: 0,
              centerTitle: false,
              backgroundColor: appBarColor,
              brightness: lightBrightness,
              title: InkWell(
                onTap: () {
                  if (pageIndex != 0) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => DashBoard(
                          initialIndex: 0,
                        ),
                      ),
                    );
                  }
                },
                child: Image.asset(
                  "assets/image/appBarImage.png",
                  height: 70,
                  width: 120,
                ),
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
              actions: [
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
                          builder: (context) => NotificationScreen(),
                        ),
                      );
                    }
                  },
                  child: Badge(
                    padding: EdgeInsets.all(4.5),
                    badgeColor: redColor,
                    position: BadgePosition(top: 8, start: 11),
                    badgeContent: Text(
                      '$newNotificationCount',
                      style: TextStyle(
                        fontSize: 10,
                        color: whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: Image.asset(
                      "assets/icon/bellIcon.png",
                      height: 25,
                      width: 25,
                    ),
                  ),
                ),
                sizedBoxwidth10,
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => MyCartScreen(
                //           router: "nav",
                //         ),
                //       ),
                //     );
                //     // if (userType == true) {
                //     //   Navigator.push(
                //     //     context,
                //     //     MaterialPageRoute(
                //     //       builder: (context) => SignIn(),
                //     //     ),
                //     //   );
                //     // } else {
                //     //   Navigator.push(
                //     //     context,
                //     //     MaterialPageRoute(
                //     //       builder: (context) => MyCartScreen(
                //     //         router: "nav",
                //     //       ),
                //     //     ),
                //     //   );
                //     // }
                //   },
                //   child: Badge(
                //       padding: EdgeInsets.all(4.5),
                //       badgeColor: redColor,
                //       position: BadgePosition(top: 7, end: 0),
                //       badgeContent: Text(
                //         cartCount.toString(),
                //         style: TextStyle(
                //           fontSize: 10,
                //           color: whiteColor,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //       child: Icon(
                //         Icons.shopping_cart,
                //         size: 25,
                //       )),
                // ),
                sizedBoxwidth10
              ],
            ),
            bottomNavigationBar: Container(
                color: whiteColor,
                child: TabBar(
                  labelColor: blackColor,
                  unselectedLabelColor: greyColor,
                  unselectedLabelStyle: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: yellowColor),
                  labelStyle: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                  indicatorColor: Colors.transparent,
                  onTap: (value) {
                    setState(() {
                      pageIndex = value;
                    });
                    if (value == 0) {
                      setState(() {
                        getLocalInformation();
                      });
                    } else if (value == 1) {
                      setState(() {
                        getLocalInformation();
                      });
                    } else if (value == 2) {
                      setState(() {
                        getLocalInformation();
                      });
                    } else if (value == 3) {
                      setState(() {
                        getLocalInformation();
                      });
                    } else if (value == 4) {
                      setState(() {
                        getLocalInformation();
                      });
                    }
                  },
                  tabs: [
                    Tab(
                      text: LocaleKeys.home.tr(),
                      icon: Image.asset(
                        "assets/icon/homeIcon.png",
                        height: 25,
                        width: 25,
                      ),
                    ),
                    Tab(
                      text: LocaleKeys.categories.tr(),
                      icon: Image.asset(
                        "assets/icon/categoriesBlueIcon.png",
                        height: 25,
                        width: 25,
                      ),
                    ),
                    Tab(
                      text: LocaleKeys.enquire.tr(),
                      icon: Image.asset(
                        "assets/icon/enquireBlueIcon.png",
                        height: 25,
                        width: 25,
                      ),
                    ),
                    Tab(
                      text: LocaleKeys.Account.tr(),
                      icon: Image.asset(
                        "assets/icon/myaccountBlueIcon.png",
                        height: 25,
                        width: 25,
                      ),
                    ),
                    Tab(
                        text: LocaleKeys.Cart.tr(),
                        icon: Image.asset(
                          "assets/icon/cartBlueIcon.png",
                          height: 25,
                          width: 25,
                        )),
                  ],
                )),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomeScreen(),
                CategoriesScreen(),
                EnquireNowScreen(),
                MyAccountScreen(),
                MyCartScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
