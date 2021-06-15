import 'dart:convert';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:menahub/Util/StaticFunction.dart';
import 'package:flutter/material.dart';
import 'package:menahub/CustomWidget/CustomButton.dart';
import 'package:menahub/SignIn_SignUp_Flow/OtpVerify.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/config/CustomBackground.dart';
import 'package:easy_localization/easy_localization.dart';
import 'SignInScreen/SignInScreen.dart';
import 'package:menahub/translation/codegen_loader.g.dart';
import 'package:menahub/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = new GlobalKey<FormState>();
  String countryCode = "+91";
  TextEditingController emailTextField = TextEditingController();
  bool _autoValidate = false;

  passwordForgot() async {
    // final progress = ProgressHUD.of(context);
    // progress.show();
    var body = jsonEncode({
      "telephone": emailTextField.text,
      "code": countryCode.replaceAll("+", ""),
      "type": "FORGET",
      "resend": 0
    });
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    ApiResponseModel responseData = await postApiCall(
        postUrl: forgetPasswordApi,
        body: body,
        headers: headers,
        context: context);
    print(responseData.responseValue);
    if (responseData.statusCode == 200) {
      // progress.dismiss();
      print(responseData.responseValue);
      Map response = responseData.responseValue[0];
      bool status = response["status"];
      print(response);
      print(status);
      if (status == true) {
        Fluttertoast.showToast(
          msg: LocaleKeys.OTP_Sent.tr(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setState(() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => OtpVerify(
                mobilenumber: emailTextField.text,
                code: countryCode.replaceAll("+", ""),
              ),
            ),
          );
        });
      } else {
        Fluttertoast.showToast(
          msg: LocaleKeys.error.tr(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      // status == true
      //     ? Fluttertoast.showToast(
      //         msg: 'OTP Has Been Sent To Your Mobile',
      //         // toastLength: Toast.LENGTH_LONG,
      //         // gravity: ToastGravity.CENTER,
      //         // timeInSecForIosWeb: 10,
      //         // backgroundColor: Colors.red,
      //         // textColor: Colors.white,
      //         // fontSize: 16.0,
      //       )
      //     : Fluttertoast.showToast(
      //         msg: 'SomeError Occurs',
      //         // toastLength: Toast.LENGTH_LONG,
      //         // gravity: ToastGravity.CENTER,
      //         // timeInSecForIosWeb: 10,
      //         // backgroundColor: Colors.red,
      //         // textColor: Colors.white,
      //         // fontSize: 16.0,
      //       );
      // setState(() {
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (BuildContext context) => OtpVerify(
      //         mobilenumber: emailTextField.text,
      //         code: countryCode.replaceAll("+", ""),
      //       ),
      //     ),
      //   );
      // });
    } else {
      //progress.dismiss();
      print(responseData);
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
        body: Stack(
          children: [
            CustomBackground(
              backgroundColor: whiteColor,
              imageColor: secondaryColor,
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              child: SafeArea(
                child: Form(
                  key: formKey,
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
                                              bottom: 15, top: 0),
                                          child: Text(
                                            LocaleKeys.Forgot.tr(),
                                            style: TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 3),
                                          child: Text(
                                            LocaleKeys.Enter_Mobile_Reset.tr(),
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 0),
                                          child: Text(
                                            LocaleKeys.Your_Password.tr(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[600],
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
                          sizedBoxheight20,
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  top: 20,
                                  left: 40,
                                ),
                                child: Text(
                                  LocaleKeys.Mobile.tr(),
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              )
                            ],
                          ),
                          sizedBoxheight5,
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              elevation: 2,
                              child: Container(
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      DropdownButton<String>(
                                        underline: Container(),
                                        value: countryCode,
                                        items: <String>['+91', '+974']
                                            .map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(
                                              value,
                                              style: TextStyle(),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            countryCode = value;
                                          });
                                        },
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          keyboardType: TextInputType.phone,
                                          controller: emailTextField,
                                          decoration: new InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            hintText: LocaleKeys.Mobile.tr(),
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: greyColor,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please Enter Mobile Number';
                                            }
                                            if (countryCode == '+91' &&
                                                value.length < 10) {
                                              return LocaleKeys.valid_mobile1
                                                  .tr();
                                            }
                                            if (countryCode == '+91' &&
                                                value.length > 10) {
                                              return LocaleKeys.valid_mobile
                                                  .tr();
                                            }
                                            if (countryCode == '+974' &&
                                                value.length < 8) {
                                              return LocaleKeys.valid_mobile
                                                  .tr();
                                            }
                                            if (countryCode == '+974' &&
                                                value.length > 8) {
                                              return LocaleKeys.valid_mobile
                                                  .tr();
                                            }
                                            return null;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          sizedBoxheight20,
                          InkWell(
                            onTap: () {
                              if (formKey.currentState.validate()) {
                                passwordForgot();
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
          ],
        ),
        bottomNavigationBar: Container(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
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
        )),
      ),
    );
  }
}
