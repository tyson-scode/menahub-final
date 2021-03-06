import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:menahub/CustomWidget/CustomButton.dart';
import 'package:menahub/CustomWidget/CustomTextBox.dart';
import 'package:menahub/DashBoard/DashBoard.dart';
import 'package:menahub/SignIn_SignUp_Flow/SignInScreen/SignInScreen.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/config/CustomBackground.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:menahub/Util/otpVeri.dart';
import 'package:menahub/translation/codegen_loader.g.dart';
import 'package:menahub/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = new GlobalKey<FormState>();
  GlobalKey<PinEntryTextFieldState> _myKey = GlobalKey();

  TextEditingController firstNameTextfield = TextEditingController();
  TextEditingController lastNameTextfield = TextEditingController();
  TextEditingController emailTextfield = TextEditingController();
  TextEditingController passwordTextfield = TextEditingController();
  TextEditingController confirmPasswordTextfield = TextEditingController();
  TextEditingController mobileTextfield = TextEditingController();
  TextEditingController otpTextfield = TextEditingController();

  bool _autoValidate = false;
  String countryCode = "+91";
  String otp = "";
  BuildContext context;
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
//generate Otp Api

  signUpOtp(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress.show();
    var body = jsonEncode({
      "telephone": mobileTextfield.text,
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
    if (responseData.statusCode == 200) {
      //_myKey.currentState.clearTextFields();
      print(responseData.responseValue);
      Map response = responseData.responseValue[0];
      bool status = response["status"];
      print(response);
      print(status);
      status == true
          ? Fluttertoast.showToast(
              msg: LocaleKeys.OTP_Sent.tr(),
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 10,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            )
          : Fluttertoast.showToast(
              msg: LocaleKeys.error.tr(),
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 10,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
      progress.dismiss();
      _myKey.currentState.clearTextFields();
    } else {
      //_myKey.currentState.clearTextFields();
      print(responseData);
      progress.dismiss();
    }
  }

//otp Validate And New User Register Api
  verifyotp(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress.show();
    setState(() => this.context = context);
    print("verify otp called");
    print("OTP:" + otp);
    var body = jsonEncode({"telephone": mobileTextfield.text, "otp": otp});
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    ApiResponseModel responseData = await postApiCall(
        postUrl: verifyOtpApi, body: body, headers: headers, context: context);
    print("verify OTP: " + responseData.toString());
    print("verify OTP: " + body.toString());

    if (responseData.statusCode == 200) {
      Map response = responseData.responseValue[0];

      bool status = response["status"];
      print(" status=$status");
      if (status == true) {
        var body = jsonEncode({
          "customer": {
            "email": emailTextfield.text,
            "firstname": firstNameTextfield.text,
            "lastname": lastNameTextfield.text,
            "customAttributes": [
              {
                "attributeCode": "mobilenumber",
                "value": mobileTextfield.text,
              },
              {
                "attributeCode": "mobilenumber_code",
                "value": countryCode,
              }
            ]
          },
          "password": passwordTextfield.text
        });
        ApiResponseModel responseData = await postApiCall(
            postUrl: newUserUrl,
            body: body,
            headers: headers,
            context: context);
        print("status" + responseData.statusCode.toString());
        print("signinapi" + responseData.responseValue.toString());
        if (responseData.statusCode == 200) {
          print("Navigator pop");
          print(responseData);
          progress.dismiss();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignIn(),
            ),
          );
          Fluttertoast.showToast(
            msg: LocaleKeys.account_created.tr(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 10,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          progress.dismiss();

          Map response = responseData.responseValue;
          String errorMessage = response["message"];
          print('error=$errorMessage');
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
          //   content: Text(errorMessage),
          // );
          // showDialog(
          //   context: context,
          //   builder: (BuildContext context) {
          //     return alert;
          //   },
          // );
        }
      } else {
        print("verify OTP: failed" + response.toString());

        progress.dismiss();
        setState(() {
          Fluttertoast.showToast(
            msg: LocaleKeys.OTP_Valid.tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          _myKey.currentState.clearTextFields();
        });
      }
    } else {
      print("failed");
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
        bottomNavigationBar: SafeArea(
          child: Container(
            color: whiteColor,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  // ignore: deprecated_member_use
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.already_account.tr(),
                      style: TextStyle(fontSize: 16, color: lightGreyColor),
                    ),
                    sizedBoxwidth5,
                    Text(
                      LocaleKeys.sign_in.tr(),
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: ProgressHUD(
          child: Builder(
            builder: (context) => Container(
              color: backGroudColor,
              height: double.infinity,
              width: double.infinity,
              child: SafeArea(
                child: Stack(
                  children: [
                    CustomBackground(
                      backgroundColor: whiteColor,
                      imageColor: secondaryColor,
                    ),
                    SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        autovalidate: _autoValidate,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();
                                      //preferences.clear();
                                      preferences.setString(
                                          "userType", "guest");
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              DashBoard(
                                            initialIndex: 0,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      LocaleKeys.skip.tr(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
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
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    LocaleKeys.create.tr(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    LocaleKeys.New_Account.tr(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: lightGreyColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  sizedBoxheight20,
                                  customTextBox(
                                    icons: "assets/icon/profileIcon.png",
                                    hintText: LocaleKeys.Full_Name.tr(),
                                    controller: firstNameTextfield,
                                  ),
                                  sizedBoxheight10,
                                  customTextBox(
                                    icons: "assets/icon/profileIcon.png",
                                    hintText: LocaleKeys.Last_Name.tr(),
                                    controller: lastNameTextfield,
                                  ),
                                  sizedBoxheight10,
                                  customTextBox(
                                    icons: "assets/icon/emailIcon.png",
                                    hintText: LocaleKeys.Email.tr(),
                                    controller: emailTextfield,
                                    keyboardType: TextInputType.emailAddress,
                                    emailField: true,
                                  ),

                                  sizedBoxheight10,
                                  customTextBox(
                                    icons: "assets/icon/lockIcon.png",
                                    hintText: LocaleKeys.Password.tr(),
                                    controller: passwordTextfield,
                                    passwordField: true,
                                    keyboardType: TextInputType.visiblePassword,
                                  ),
                                  sizedBoxheight10,
                                  customTextBox(
                                    icons: "assets/icon/lockIcon.png",
                                    hintText: LocaleKeys.RePassword.tr(),
                                    controller: confirmPasswordTextfield,
                                    passwordField: true,
                                    keyboardType: TextInputType.visiblePassword,
                                  ),
                                  sizedBoxheight10,
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
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
                                              "assets/icon/phoneIcon.png",
                                              height: 30,
                                              width: 30,
                                            ),
                                            sizedBoxwidth10,
                                            DropdownButton<String>(
                                              underline: Container(),
                                              value: countryCode,
                                              items: <String>['+91', '+974']
                                                  .map((String value) {
                                                return new DropdownMenuItem<
                                                    String>(
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
                                                controller: mobileTextfield,
                                                keyboardType:
                                                    TextInputType.phone,
                                                decoration: new InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 15, right: 15),
                                                  hintText:
                                                      LocaleKeys.Mobile.tr(),
                                                  hintStyle: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: greyColor,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return LocaleKeys
                                                        .valid_mobile1
                                                        .tr();
                                                  }
                                                  if (countryCode == '+91' &&
                                                      value.length < 10) {
                                                    return LocaleKeys
                                                        .valid_mobile
                                                        .tr();
                                                  }
                                                  if (countryCode == '+91' &&
                                                      value.length > 10) {
                                                    return LocaleKeys
                                                        .valid_mobile
                                                        .tr();
                                                  }
                                                  if (countryCode == '+974' &&
                                                      value.length < 8) {
                                                    return LocaleKeys
                                                        .valid_mobile
                                                        .tr();
                                                  }
                                                  if (countryCode == '+974' &&
                                                      value.length > 8) {
                                                    return LocaleKeys
                                                        .valid_mobile
                                                        .tr();
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  sizedBoxheight20,
                                  InkWell(
                                    onTap: () {
                                      if (formKey.currentState.validate()) {
                                        if (passwordTextfield.text ==
                                            confirmPasswordTextfield.text) {
                                          signUpOtp(context);
                                          // Fluttertoast.showToast(
                                          //   msg:
                                          //       "Your OTP has been sent to your mobile number",
                                          //   // toastLength: Toast.LENGTH_LONG,
                                          //   // gravity: ToastGravity.CENTER,
                                          //   // timeInSecForIosWeb: 10,
                                          //   // backgroundColor: Colors.red,
                                          //   // textColor: Colors.white,
                                          //   // fontSize: 16.0,
                                          // );
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: LocaleKeys.match_password.tr(),
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 10,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                        }
                                      } else {
                                        setState(() {
                                          _autoValidate = true;
                                        });
                                      }
                                      _myKey.currentState.clearTextFields();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: customGradientButton(
                                          title: LocaleKeys.generate_OTP.tr(),
                                          backgroundColor: primaryColor),
                                    ),
                                  ),
                                  sizedBoxheight20,
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding:
                                        const EdgeInsets.only(left: 0, top: 0),
                                    child: Text(
                                      LocaleKeys.OTP.tr(),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(),
                                  //   child: OTPTextField(
                                  //     length: 4,
                                  //     width: MediaQuery.of(context).size.width,
                                  //     fieldWidth: 40,
                                  //     textFieldAlignment:
                                  //         MainAxisAlignment.spaceAround,
                                  //     //fieldStyle: FieldStyle.underline,
                                  //     onChanged: (str) {
                                  //       if (str.length == 1) {}
                                  //     },
                                  //     onCompleted: (pin) {
                                  //       print("Completed: " + pin);
                                  //       otp = pin;
                                  //       // verifyotp();
                                  //     },
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(),
                                  //   child: OTPTextField(
                                  //     length: 4,
                                  //     width: MediaQuery.of(context).size.width,
                                  //     fieldWidth: 40,
                                  //     textFieldAlignment:
                                  //         MainAxisAlignment.spaceAround,
                                  //     //fieldStyle: FieldStyle.underline,
                                  //     onChanged: (str) {
                                  //       if (str.length == 1) {}
                                  //     },
                                  //     onCompleted: (pin) {
                                  //       print("Completed: " + pin);
                                  //       otp = pin;
                                  //       // verifyotp();
                                  //     },
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(),
                                    child: PinEntryTextField(
                                      fields: 4,
                                      key: _myKey,
                                      showFieldAsBox: false,
                                      onSubmit: (String pin) {
                                        otp = pin;
                                      },
                                    ),

                                    //child: pinEntryTextField
                                    // PinEntryTextField(
                                    //   showFieldAsBox: false,
                                    //   onSubmit: (String pin) {
                                    //     otp = pin;
                                    //   },
                                    // ),
                                  ),

                                  // customTextBox(
                                  //     icons: "assets/icon/otpIcon.png",
                                  //     hintText: "OTP"),
                                  sizedBoxheight30,
                                  InkWell(
                                    onTap: () {
                                      if (formKey.currentState.validate()) {
                                        if (passwordTextfield.text ==
                                            confirmPasswordTextfield.text) {
                                          // verifyotp(context);
                                          if (otp.isNotEmpty) {
                                            verifyotp(context);
                                          } else {
                                            Fluttertoast.showToast(
                                              msg: LocaleKeys.valid_OTP.tr(),
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 10,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: LocaleKeys.match_password.tr(),
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 10,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                        }
                                      } else {
                                        setState(() {
                                          _autoValidate = true;
                                        });
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: customGradientButton(
                                          title: LocaleKeys.SUBMIT.tr(),
                                          backgroundColor: primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            sizedBoxheight20,
                          ],
                        ),
                      ),
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
