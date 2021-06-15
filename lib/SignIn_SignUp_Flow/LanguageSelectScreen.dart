import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:menahub/DashBoard/DashBoard.dart';
import 'package:menahub/SplashScreen/SplashScreen.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/config/CustomBackground.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:menahub/translation/locale_keys.g.dart';
import 'package:menahub/translation/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageSelectScreen extends StatefulWidget {
  final String router;
  LanguageSelectScreen({this.router});
  @override
  _LanguageSelectScreenState createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
  createCart(BuildContext _context) async {
    final progress = ProgressHUD.of(_context);
    progress.show();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    ApiResponseModel responseModel = await postApiCall(
        postUrl: createEmptyCart, headers: headers, body: jsonEncode({}));
    if (responseModel.statusCode == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("guestId", responseModel.responseValue.toString());
      progress.dismiss();
      Navigator.of(_context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => DashBoard(
            initialIndex: 0,
          ),
        ),
      );
    } else {
      progress.dismiss();
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
        body: ProgressHUD(
          child: Builder(
            builder: (context) => Container(
              width: double.infinity,
              height: double.infinity,
              child: SafeArea(
                bottom: false,
                child: Stack(
                  children: [
                    CustomBackground(
                      backgroundColor: whiteColor,
                      imageColor: secondaryColor,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/icon/appTopLogo.png',
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.language_first.tr(),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            sizedBoxheight5,
                            Text(
                              LocaleKeys.language_second.tr(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            sizedBoxheight30,
                            sizedBoxheight5,
                            Container(
                              height: 40,
                              margin: EdgeInsets.only(
                                  left: 50, right: 50, bottom: 25),
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                textColor: Colors.black26,
                                color: Colors.orange[50],
                                child: Container(
                                  child: Center(
                                    child: Text(LocaleKeys.arabic.tr(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        )),
                                  ),
                                ),
                                onPressed: () async {
                                  await context.setLocale(Locale('ar'));

                                  setState(() {
                                    lang = "ar";
                                  });

                                  if (widget.router == "account") {
                                    // Navigator.pop(context);
                                    setState(() {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                SplashScreen()),
                                      );
                                    });
                                  } else {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String guestId = "";
                                    if (preferences.getString("guestId") !=
                                        null) {
                                      guestId =
                                          preferences.getString("guestId");
                                    }
                                    preferences.clear();
                                    preferences.setString("userType", "guest");
                                    if (guestId != "") {
                                      preferences.setString("guestId", guestId);
                                      print(preferences.getString("guestId"));
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              DashBoard(
                                            initialIndex: 0,
                                          ),
                                        ),
                                      );
                                    } else {
                                      createCart(context);
                                    }
                                  }
                                },
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0),
                                    side:
                                        BorderSide(color: Colors.orange[200])),
                              ),
                            ),
                            Container(
                              height: 40,
                              margin: EdgeInsets.only(left: 50, right: 50),
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                textColor: Colors.black54,
                                color: Colors.white,
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      LocaleKeys.english.tr(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  await context.setLocale(Locale('en'));
                                  setState(() {
                                    lang = "default";
                                  });

                                  if (widget.router == "account") {
                                    setState(() {
                                      // Navigator.pop(context);
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                SplashScreen()),
                                      );
                                    });
                                  } else {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String guestId = "";
                                    if (preferences.getString("guestId") !=
                                        null) {
                                      guestId =
                                          preferences.getString("guestId");
                                      print('guestID = $guestId');
                                    }
                                    preferences.clear();
                                    preferences.setString("userType", "guest");
                                    if (guestId != "") {
                                      preferences.setString("guestId", guestId);
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              DashBoard(
                                            initialIndex: 0,
                                          ),
                                        ),
                                      );
                                    } else {
                                      createCart(context);
                                    }
                                  }
                                },
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0),
                                    side: BorderSide(color: Colors.blue[900])),
                              ),
                            ),
                          ],
                        ),
                        Container()
                      ],
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
