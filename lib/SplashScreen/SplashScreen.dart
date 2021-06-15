import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:menahub/DashBoard/DashBoard.dart';
import 'package:menahub/SignIn_SignUp_Flow/LanguageSelectScreen.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/config/CustomBackground.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 3),
      () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString('token');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        print(preferences.getString("firebasetoken"));
        if (token != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => DashBoard(
                initialIndex: 0,
              ),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => LanguageSelectScreen(),
            ),
          );
        }
      },
    );
    return MaterialApp(
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: Locale(context.locale.languageCode),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(children: [
          CustomBackground(
            backgroundColor: primaryColor,
            imageColor: whiteColor,
          ),
          Container(
            color: Colors.transparent,
            height: double.infinity,
            width: double.infinity,
            // decoration: BoxDecoration(
            //   color: HexColor("#0D3451"),
            // ),
            child: Center(
              child: Image.asset(
                "assets/image/splashLogo.png",
                height: 200,
                width: 200,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
