import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:menahub/CustomWidget/CustomButton.dart';
import 'package:menahub/CustomWidget/CustomTextBox.dart';
import 'package:menahub/SignIn_SignUp_Flow/ResetPassword.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/config/CustomBackground.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SignInScreen/SignInScreen.dart';

class OtpVerify extends StatefulWidget {
  OtpVerify({this.mobilenumber, this.code});
  final String code;
  final String mobilenumber;
  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  FocusNode myFocusNode;
  TextEditingController newPasswordTextField = TextEditingController();
  TextEditingController confirmPasswordTextField = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  TextEditingController _pinPutController = TextEditingController();
  FocusNode _pinPutFocusNode = FocusNode();

  // verifyotp({String otp}) async {
  //   // final progress = ProgressHUD.of(context);
  //   // progress.show();
  //   var body = jsonEncode({"telephone": widget.mobilenumber, "otp": otp});
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //   };
  //   ApiResponseModel responseData = await postApiCall(
  //       postUrl: verifyOtpApi, body: body, headers: headers, context: context);
  //   print(responseData.responseValue);
  //   if (responseData.statusCode == 200) {
  //     // print(responseData.responseValue);
  //     // progress.dismiss();
  //     Map response = responseData.responseValue[0];
  //     bool status = response["status"];
  //     print(response);
  //     print(status);
  //     if (status == true) {
  //       setState(() {
  //         Navigator.of(context).push(
  //           MaterialPageRoute(
  //             builder: (BuildContext context) =>
  //                 ResetPassword(
  //                   mobilenumber: widget.mobilenumber,
  //                   code: widget.code,
  //                   otp: otp,
  //                 ),
  //           ),
  //         );
  //       });
  //     } else {
  //       Fluttertoast.showToast(
  //         msg: 'Please Enter a Valid OTP',
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 10,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0,
  //       );
  //     }
  //   } else {
  //     // progress.dismiss();
  //     print(responseData);
  //   }
  // }
  passwordReset({String otp, BuildContext contexts}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    // final progress = ProgressHUD.of(contexts);
    // progress.show();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      // 'Authorization': "Bearer $token"
    };
    var body = jsonEncode({
      "mobilenumber": widget.mobilenumber,
      "code": widget.code,
      "otp": otp,
      "new_password": newPasswordTextField.text,
      "confirm_password": confirmPasswordTextField.text
    });
    ApiResponseModel responseData = await postApiCall(
      postUrl: resetPasswordApi,
      headers: headers,
      context: context,
      body: body,
    );
    print(responseData.responseValue);
    if (responseData.statusCode == 200) {
      // progress.dismiss();
      setState(() {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => SignIn(),
          ),
        );
        Fluttertoast.showToast(
          msg: 'Password Reset Sucessfull',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      });
    } else {
      // progress.dismiss();
      // progress.dismiss();
      Map response = responseData.responseValue;
      String errorMessage = response["message"];
      Fluttertoast.showToast(
        msg: errorMessage,
        // toastLength: Toast.LENGTH_LONG,
        // gravity: ToastGravity.CENTER,
        // timeInSecForIosWeb: 10,
        // backgroundColor: Colors.red,
        // textColor: Colors.white,
        // fontSize: 16.0,
      );
      _pinPutController.clear();
      // errorAlert(context: context, errorMessage: errorMessage);
      print(errorMessage);
      // AlertDialog alert = AlertDialog(
      //   content: Text(errorMessage),
      // );
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return alert;
      //   },
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget textSection1 = Row(
      children: [
        Container(
          padding: EdgeInsets.only(top: 30, left: 30),
          child: Text(
            'New Password ',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        )
      ],
    );

    Widget textSection2 = Row(
      children: [
        Container(
          padding: EdgeInsets.only(top: 15, left: 30),
          child: Text(
            'Confirm Password',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        )
      ],
    );

    // @override
    // Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: Locale(context.locale.languageCode),
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          body: Stack(
            children: [
              CustomBackground(
                backgroundColor: whiteColor,
                imageColor: secondaryColor,
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Form(
                      key: formKey,
                      // ignore: deprecated_member_use
                      autovalidate: _autoValidate,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              top: 15.0,
                            ),
                            child: Image.asset(
                              'assets/icon/appTopLogo.png',
                              scale: 16.0,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Center(
                                          //   child: Container(
                                          //     padding: const EdgeInsets.only(
                                          //         bottom: 20, top: 50),
                                          //     child: Text(
                                          //       'Verification Code',
                                          //       style: TextStyle(
                                          //         fontSize: 27,
                                          //         fontWeight: FontWeight.normal,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Center(
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20, top: 50),
                                              child: Text(
                                                'Reset Password',
                                                style: TextStyle(
                                                  fontSize: 27,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Center(
                                          //   child: Container(
                                          //     padding: const EdgeInsets.only(
                                          //         bottom: 10),
                                          //     child: Text(
                                          //       'Please check your email address for',
                                          //       style: TextStyle(
                                          //         fontSize: 13,
                                          //         color: Colors.grey[500],
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          // Center(
                                          //   child: Container(
                                          //     padding: const EdgeInsets.only(
                                          //         bottom: 10),
                                          //     child: Text(
                                          //       'verification code',
                                          //       style: TextStyle(
                                          //         fontSize: 13,
                                          //         color: Colors.grey[500],
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 50, top: 30),
                                            child: Text('Code'),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Center(
                                              child: Container(
                                                height: height / 10,
                                                width: width / 1,
                                                child: PinPut(
                                                  autovalidateMode:
                                                      AutovalidateMode.disabled,
                                                  separator: SizedBox(
                                                    width: 0,
                                                  ),
                                                  fieldsAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  eachFieldConstraints:
                                                      BoxConstraints(),
                                                  eachFieldHeight: 60,
                                                  eachFieldWidth: 60,
                                                  fieldsCount: 4,
                                                  focusNode: _pinPutFocusNode,
                                                  controller: _pinPutController,
                                                  disabledDecoration:
                                                      BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                    ),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        spreadRadius: 1,
                                                        offset: Offset(0, 5),
                                                        blurRadius: 10.0,
                                                        color: Colors.grey,
                                                      ),
                                                    ],
                                                  ),
                                                  submittedFieldDecoration:
                                                      BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                    ),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        spreadRadius: 1,
                                                        offset: Offset(0, 5),
                                                        blurRadius: 10.0,
                                                        color: Colors.grey,
                                                      ),
                                                    ],
                                                  ),
                                                  selectedFieldDecoration:
                                                      BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                    ),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        spreadRadius: 1,
                                                        offset: Offset(0, 5),
                                                        blurRadius: 10.0,
                                                        color: Colors.grey,
                                                      ),
                                                    ],
                                                  ),
                                                  //                                               validator: (value){ if (value.isEmpty) {
                                                  //   return 'Please Enter Otp';
                                                  // }
                                                  //    return null;
                                                  // },
                                                  followingFieldDecoration:
                                                      BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                    ),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        spreadRadius: 1,
                                                        offset: Offset(0, 5),
                                                        blurRadius: 10.0,
                                                        color: Colors.grey,
                                                      ),
                                                    ],
                                                  ),
                                                  //   validator: (value){ if (value.isEmpty) {
                                                  //   return 'Please Enter Otp';
                                                  // }
                                                  //    return null;
                                                  // },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              bottom: 10, top: 30),
                                          child: Text(
                                            'Please Set Your New Password',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          textSection1,
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 20, right: 20),
                            child: customTextBox(
                              icons: "assets/icon/lockIcon.png",
                              hintText: "New Password",
                              controller: newPasswordTextField,
                              passwordField: true,
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ),
                          // sizedBoxheight10,
                          textSection2,
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 20, right: 20),
                            child: customTextBox(
                              icons: "assets/icon/lockIcon.png",
                              hintText: "Confirm Password",
                              controller: confirmPasswordTextField,
                              passwordField: true,
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ),
                          sizedBoxheight20,
                          InkWell(
                            onTap: () {
                              if (_pinPutController.text.isNotEmpty) {
                                if (formKey.currentState.validate()) {
                                  if (newPasswordTextField.text ==
                                      confirmPasswordTextField.text) {
                                    passwordReset(
                                      otp: _pinPutController.text,
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg:
                                          'Your password and confirmation password do not match.',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 10,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                    // AlertDialog alert = AlertDialog(
                                    //   content: Text(
                                    //       "Your password and confirmation password do not match."),
                                    // );
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (BuildContext context) {
                                    //     return alert;
                                    //   },
                                    // );
                                  }
                                } else {
                                  setState(() {
                                    _autoValidate = true;
                                  });
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg: 'Please Enter Otp',
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 10,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                              // passwordReset(
                              //   otp: _pinPutController.text,
                              // );
                            },
                            child: Container(
                              width: 220,
                              child: customButton(
                                  title: "Continue",
                                  backgroundColor: primaryColor),
                            ),
                          ),
                          sizedBoxheight20,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Text(
                  'Already have an account?',
                  style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignIn(),
                          ));
                    },
                    child: new Text(
                      '  sign in',
                      style: new TextStyle(
                          fontSize: 13,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ))
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
