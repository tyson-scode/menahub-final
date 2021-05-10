import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:menahub/Notification/NotificationScreen.dart';
import 'package:menahub/SignIn_SignUp_Flow/SignInScreen/SignInScreen.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CategoriesScreen/CategoriesScreen.dart';
import 'EnquireNowScreen/EnquireNowScreen.dart';
import 'HomeScreen/HomeScreen.dart';
import 'MyAccountScreen/MyAccountScreen.dart';
import 'MyCartScreen/MyCartScreen.dart';

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress)
          return false;
        else
          return true;
      },
      child: MaterialApp(
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
                    position: BadgePosition(top: 7, end: 0),
                    badgeContent: Text(
                      '',
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
                    // if (value == 0) {
                    //   setState(() {});
                    // } else if (value == 1) {
                    //   setState(() {});
                    // } else if (value == 2) {
                    //   setState(() {});
                    // } else if (value == 3) {
                    //   setState(() {});
                    // } else if (value == 4) {
                    //   setState(() {});
                    // }
                  },
                  tabs: [
                    Tab(
                      text: "Home",
                      icon: Image.asset(
                        "assets/icon/homeIcon.png",
                        height: 25,
                        width: 25,
                      ),
                    ),
                    Tab(
                      text: "Categories",
                      icon: Image.asset(
                        "assets/icon/categoriesBlueIcon.png",
                        height: 25,
                        width: 25,
                      ),
                    ),
                    Tab(
                      text: "Enquire",
                      icon: Image.asset(
                        "assets/icon/enquireBlueIcon.png",
                        height: 25,
                        width: 25,
                      ),
                    ),
                    Tab(
                      text: "Account",
                      icon: Image.asset(
                        "assets/icon/myaccountBlueIcon.png",
                        height: 25,
                        width: 25,
                      ),
                    ),
                    Tab(
                      text: "Cart",
                      icon: Image.asset(
                        "assets/icon/cartBlueIcon.png",
                        height: 25,
                        width: 25,
                      ),
                    ),
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
