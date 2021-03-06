import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:menahub/CustomWidget/CustomButton.dart';
import 'package:menahub/CustomWidget/CustomTextBox.dart';
import 'package:menahub/SignIn_SignUp_Flow/SignInScreen/SignInScreen.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/config/CustomBackground.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:menahub/translation/codegen_loader.g.dart';
import 'package:menahub/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ResetPassword extends StatefulWidget {
  final String code;
  final String otp;
  final String mobilenumber;
  final String router;
  ResetPassword({this.code, this.mobilenumber, this.otp, this.router});
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController newPasswordTextField = TextEditingController();
  TextEditingController confirmPasswordTextField = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  bool _autoValidate = false;

  passwordReset({BuildContext contexts}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    final progress = ProgressHUD.of(contexts);
    progress.show();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      // 'Authorization': "Bearer $token"
    };
    var body = jsonEncode({
      "mobilenumber": widget.mobilenumber,
      "code": widget.code,
      "otp": widget.otp,
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
      progress.dismiss();
      setState(() {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => SignIn(),
          ),
        );
      });
    } else {
      progress.dismiss();
      progress.dismiss();
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

  currentUserpasswordChange({BuildContext contexts}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    final progress = ProgressHUD.of(contexts);
    progress.show();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    var body = jsonEncode({
      "new_password": newPasswordTextField.text,
      "confirm_password": confirmPasswordTextField.text
    });
    ApiResponseModel responseData = await putApiCall(
      postUrl: resetPasswordApi,
      headers: headers,
      context: context,
      body: body,
    );
    print(responseData.responseValue);
    if (responseData.statusCode == 200) {
      setState(() {
        progress.dismiss();
        Fluttertoast.showToast(
          msg: LocaleKeys.reset_success.tr(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pop(context);
      });
    } else {
      progress.dismiss();
      Map response = responseData.responseValue;
      String errorMessage = response["message"];
      // errorAlert(context: context, errorMessage: errorMessage);
      print(errorMessage);
      Fluttertoast.showToast(
        msg: errorMessage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget textSection1 = Row(
      children: [
        Container(
          padding: EdgeInsets.only(top: 30, left: 30),
          child: Text(
            LocaleKeys.New_Password.tr(),
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
            LocaleKeys.Confirm_Password.tr(),
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        )
      ],
    );

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: Locale(context.locale.languageCode),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ProgressHUD(
          child: Builder(
            builder: (context) => Stack(
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
                                            Center(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20, top: 70),
                                                child: Text(
                                                  LocaleKeys.Reset_Password
                                                      .tr(),
                                                  style: TextStyle(
                                                    fontSize: 27,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: Text(
                                                  LocaleKeys.Set_New_Password
                                                      .tr(),
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
                                    hintText: LocaleKeys.New_Password.tr(),
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
                                    hintText: LocaleKeys.Confirm_Password.tr(),
                                    controller: confirmPasswordTextField,
                                    passwordField: true,
                                    keyboardType: TextInputType.visiblePassword,
                                  ),
                                ),
                                sizedBoxheight20,
                                InkWell(
                                  onTap: () {
                                    if (formKey.currentState.validate()) {
                                      if (newPasswordTextField.text ==
                                          confirmPasswordTextField.text) {
                                        if (widget.router == "Account") {
                                          currentUserpasswordChange(
                                              contexts: context);
                                        } else {
                                          passwordReset(contexts: context);
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: LocaleKeys.match_password.tr(),
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
                                  },
                                  child: Container(
                                    width: 220,
                                    child: customGradientButton(
                                        title: LocaleKeys.Continue.tr(),
                                        backgroundColor: primaryColor),
                                  ),
                                )
                              ],
                            ),
                            Container()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: widget.router != "Account"
            ? Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Text(
                      LocaleKeys.already_account.tr(),
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
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
                          LocaleKeys.sign_in.tr(),
                          style: new TextStyle(
                              fontSize: 13,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              )
            : Container(
                height: 0,
              ),
      ),
    );
  }
}
