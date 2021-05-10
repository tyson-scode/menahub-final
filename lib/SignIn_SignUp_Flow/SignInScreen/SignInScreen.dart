import 'dart:convert';
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

class SignIn extends StatefulWidget {
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

  @override
  void dispose() {
    super.dispose();
    emailTextfield.text = "";
    passwordTextfield.text = "";
    FocusManager.instance.primaryFocus.unfocus();
  }

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
  signInApiCall(BuildContext _context) async {
    print("sign api called");
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
        Uri.parse(
            "https://uat2.menahub.com/rest/default/V1/integration/customer/token"),
        // final response = await http.post(
        //     Uri.parse(
        //         "https://magento2blog.thestagings.com/rest/default/V1/integration/customer/token"),
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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => DashBoard(
            initialIndex: 0,
          ),
        ),
      );
    } else {
      progress.dismiss();
      Map response = responseData;
      String errorMessage = response["message"];
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                                  preferences.clear();
                                  preferences.setString("userType", "guest");
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          DashBoard(
                                        initialIndex: 0,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Skip",
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
                                      "Welcome,",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "sign in to continue",
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
                                                    hintText:
                                                        "Email / Mobile Number",
                                                    hintStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: greyColor,
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    bool isemail = false;
                                                    if (value.isEmpty) {
                                                      return "Email / Mobile Number";
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
                                                          return 'Please enter valid Email';
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
                                    customTextBox(
                                      icons: "assets/icon/lockIcon.png",
                                      hintText: "Password",
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
                                            "Forgot Password",
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
                                              "Sign up",
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
                                              title: "SUBMIT",
                                              backgroundColor: primaryColor,
                                            ),
                                          ),
                                          sizedBoxheight20,
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
                                          sizedBoxheight20,
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
