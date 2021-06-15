import 'package:flutter/material.dart';
import 'package:menahub/SignIn_SignUp_Flow/SignInScreen/SignInScreen.dart';
import 'dart:ui';

import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/translation/codegen_loader.g.dart';
import 'package:menahub/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class EnquireNowScreen extends StatefulWidget {
  @override
  _EnquireNowScreenState createState() => _EnquireNowScreenState();
}

class _EnquireNowScreenState extends State<EnquireNowScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: Locale(context.locale.languageCode),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Center(
                child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width -
                  MediaQuery.of(context).size.width / 4,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 20, 15),
                    child: Center(
                      child: Text(
                        LocaleKeys.enquirescreen.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 1,
                          color: whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) => SignIn(),
                            //   ),
                            // );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: whiteColor,
                            ),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  top: 5,
                                  bottom: 5,
                                ),
                                child: Icon(
                                  Icons.autorenew,
                                  color: Colors.red,
                                  size: 60,
                                )
                                // Text(
                                //   "Sign In",
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.w600,
                                //     fontSize: 18,
                                //   ),
                                // ),
                                ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ))),
      ),
    );
  }
}
