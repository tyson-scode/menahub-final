import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:menahub/CustomAlertBox/CustomAlertBox.dart';
import 'package:menahub/CustomWidget/CustomButton.dart';
import 'package:menahub/CustomWidget/CustomTextBox.dart';
import 'package:menahub/DashBoard/DashBoard.dart';
import 'package:menahub/SignIn_SignUp_Flow/SignUpScreen/SignUpScreen.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/SignIn_SignUp_Flow/ForgotPasswordScreen.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/StaticFunction.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/config/CustomBackground.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:menahub/translation/codegen_loader.g.dart';
import 'package:menahub/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SignIn extends StatefulWidget {
  SignIn({this.deviceID1,this.router});
  String deviceID1;
  final router;
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = new GlobalKey<FormState>();
  TextEditingController emailTextfield = TextEditingController();
  TextEditingController passwordTextfield = TextEditingController();
  bool _autoValidate = false;
  bool emptyEmailValidation = false;
  bool emailValidation = false;
  String customer_ID;
  var deviceID;
  @override
  void initState() {
    super.initState();
    print(widget.deviceID1);
  }

  void dispose() {
    super.dispose();
    emailTextfield.text = "";
    passwordTextfield.text = "";
    FocusManager.instance.primaryFocus.unfocus();
  }

  createCart(BuildContext _context) async {
    print("createCart api called");
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

  // signInApiCall(BuildContext _context) async {
  //   FocusManager.instance.primaryFocus.unfocus();
  //   final progress = ProgressHUD.of(_context);
  //   progress.show();
  //   var body = jsonEncode({
  //     "username": emailTextfield.text.trim(),
  //     "password": passwordTextfield.text.trim(),
  //   });
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //   };
  //   ApiResponseModel responseData = await postApiCall(
  //       postUrl: signInUrl, body: body, headers: headers, context: context);
  //   if (responseData.statusCode == 200) {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.clear();
  //     await prefs.setString('token', responseData.responseValue);
  //     print(responseData.responseValue);
  //     progress.dismiss();
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (BuildContext context) => DashBoard(
  //           initialIndex: 0,
  //         ),
  //       ),
  //     );
  //   } else {
  //     progress.dismiss();
  //     Map response = responseData.responseValue;
  //     String errorMessage = response["message"];
  //     errorAlert(context: context, errorMessage: errorMessage);
  //     print(errorMessage);
  //   }
  // }
  token()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    deviceID = preferences.getString("firebasetoken");
  }
  // routerToken()async{
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   widget.deviceID1 = preferences.getString("firebasetoken");
  // }

  signInApiCall(BuildContext _context) async {
    widget.router=="token"?
    null:
    token();
    print('deviceID : $deviceID');
    print("sign api called");
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // deviceID = preferences.getString("firebasetoken");
    //print(deviceID);
    // SharedPreferences preference = await SharedPreferences.getInstance();
    // deviceID = preference.getString("firebasetoken");

    FocusManager.instance.primaryFocus.unfocus();
    final progress = ProgressHUD.of(_context);
    progress.show();
    var body = jsonEncode({
      "username": emailTextfield.text.trim(),
      "password": passwordTextfield.text.trim(),
    });
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(
        Uri.parse("${baseUrl}default/V1/integration/customer/token"),
        headers: headers,
        body: body);
    print(body);
    var responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      await prefs.setString('token', responseData.toString());
      print(prefs.getString('token'));

      progress.dismiss();
      getValues();
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => DashBoard(
      //       initialIndex: 0,
      //     ),
      //   ),
      // );
    } else {
      progress.dismiss();
      Map response = responseData;
      String errorMessage = response["message"];
      print(errorMessage);
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      // AlertDialog alert = AlertDialog(
      //   content: Text('$errorMessage'),
      // );
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return alert;
      //   },
      // );
      print(errorMessage);
    }
  }

  getValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    ApiResponseModel responseData = await getApiCall(
      getUrl: myAccountUrl,
      headers: headers,
      context: context,
    );
    if (responseData.statusCode == 200) {
      Map data = responseData.responseValue;print("DATA $data");
      pushNotification( customer_ID = data["id"].toString()
      );
      // setState(() {
      //   customer_ID = data["id"].toString();
      //   print(customer_ID);
      // });
    } else {
      print(responseData);
    }
  }

  pushNotification(customer_ID) async {
    print("pushNotification called");
    // print('deviceID : $deviceID');
    var body = jsonEncode({
      "device_type": Platform.isAndroid
          ? "Android"
          : Platform.isIOS
              ? "IOS"
              : "Null",
      "device_id": widget.router=="token"? widget.deviceID1 : deviceID,
      "customer_id": customer_ID
    });
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    ApiResponseModel responseData = await postApiCall(
        postUrl: pushNotificationUrl,
        headers: headers,
        context: context,
        body: body);print('body : $body');

    if (responseData.statusCode == 200) {
      print(responseData.responseValue);
      widget.router=="token"?token1():
      getToken();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => DashBoard(
            initialIndex: 0,
          ),
        ),
      );
    }
    else {
      Map response = responseData.responseValue;
      String errorMessage = response["message"];
      print(errorMessage);
      // Fluttertoast.showToast(
      //   msg: errorMessage,
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.white,
      //   textColor: Colors.black,
      //   fontSize: 16.0,
      // );

      print(errorMessage);
    }
  }
getToken() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString('notificationToken', deviceID);
}
token1() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString('notificationToken', widget.deviceID1);
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: Locale(context.locale.languageCode),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: ProgressHUD(
              child: Builder(
                builder: (context) => Stack(
                  children: [
                    CustomBackground(
                      backgroundColor: backGroudColor,
                      imageColor: secondaryColor,
                    ),
                    Container(
                      color: Colors.transparent,
                      height: double.infinity,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          // ignore: deprecated_member_use
                          autovalidate: _autoValidate,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  String guestId = "";
                                  if (preferences.getString("guestId") !=
                                      null) {
                                    guestId = preferences.getString("guestId");
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

                                  // preferences.clear();
                                  // preferences.setString("userType", "guest");
                                  // String guesttoken =
                                  //     preferences.getString("guestId");
                                  // print("token = $guesttoken");
                                  // Navigator.of(context).pushReplacement(
                                  //   MaterialPageRoute(
                                  //     builder: (BuildContext context) =>
                                  //         DashBoard(
                                  //       initialIndex: 0,
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        LocaleKeys.skip.tr(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icon/appTopLogo.png",
                                    height: 50,
                                    // width: 30,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 50),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      LocaleKeys.language_first.tr(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      LocaleKeys.signIntoContinue.tr(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: lightGreyColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    sizedBoxheight30,
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      elevation: 2,
                                      child: Container(
                                        height: 60,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                "assets/icon/emailIcon.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                  controller: emailTextfield,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  decoration:
                                                      new InputDecoration(
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 15,
                                                            right: 15),
                                                    hintText: LocaleKeys
                                                        .Email_Mobile.tr(),
                                                    hintStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: greyColor,
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    bool isemail = false;
                                                    if (value.isEmpty) {
                                                      return LocaleKeys
                                                          .Email_Mobile.tr();
                                                    } else if (value
                                                        .isNotEmpty) {
                                                      try {
                                                        print(int.parse(
                                                            value[0]));
                                                        isemail = false;
                                                      } on Exception catch (_) {
                                                        isemail = true;
                                                        print('never reached');
                                                      }
                                                      if (isemail) {
                                                        final validyEmail =
                                                            emailvalidation(
                                                                email: value);
                                                        if (validyEmail !=
                                                            true) {
                                                          return LocaleKeys
                                                              .valid_email
                                                              .tr();
                                                        } else
                                                          return null;
                                                      } else
                                                        return null;
                                                    } else
                                                      return null;
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    sizedBoxheight20,
                                    customTextBox1(
                                      icons: "assets/icon/lockIcon.png",
                                      hintText: LocaleKeys.Password.tr(),
                                      controller: passwordTextfield,
                                      passwordField: true,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                    ),
                                    sizedBoxheight20,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgotPasswordScreen(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            LocaleKeys.Forgot_Password.tr(),
                                            style: TextStyle(
                                              color: HexColor("#6D6D6D"),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignUpScreen()),
                                            );
                                            // Navigator.pushReplacement(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            //         SignUpScreen(),
                                            //   ),
                                            // );
                                          },
                                          child: Container(
                                            height: 25,
                                            width: 100,
                                            child: Text(
                                              LocaleKeys.SignUp.tr(),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: HexColor("#6D6D6D"),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    sizedBoxheight30,
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (formKey.currentState
                                                  .validate()) {
                                                signInApiCall(context);
                                              } else {
                                                setState(() {
                                                  _autoValidate = true;
                                                });
                                              }
                                            },
                                            child: customGradientButton(
                                              title: LocaleKeys.SUBMIT.tr(),
                                              backgroundColor: primaryColor,
                                            ),
                                          ),
                                          sizedBoxheight20,
/*
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Divider(
                                                  color: HexColor("#6D6D6D"),
                                                ),
                                              ),
                                              sizedBoxwidth5,
                                              Text(
                                                "OR",
                                                style: TextStyle(
                                                  color: HexColor("#6D6D6D"),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              sizedBoxwidth5,
                                              Expanded(
                                                child: Divider(
                                                  color: HexColor("#6D6D6D"),
                                                ),
                                              ),
                                            ],
                                          ),
*/
                                          sizedBoxheight20,
/*
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Image.asset(
                                                  "assets/icon/facebook.png",
                                                  height: 50,
                                                ),
                                                Image.asset(
                                                  "assets/icon/google-plus.png",
                                                  height: 50,
                                                ),
                                                Image.asset(
                                                  "assets/icon/twitter.png",
                                                  height: 50,
                                                )
                                              ],
                                            ),
                                          )
*/
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
