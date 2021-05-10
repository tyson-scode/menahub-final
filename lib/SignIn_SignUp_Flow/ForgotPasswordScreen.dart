import 'dart:convert';
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

import 'SignInScreen/SignInScreen.dart';

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
      print(responseData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                                            'Forgot Password',
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
                                            'Enter your email address to reset',
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
                                            'your password',
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
                                  'Email / Mobile Number',
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
                                        items: <String>['+ 91', '+ 974']
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
                                            hintText: "Email / Mobile Number",
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: greyColor,
                                            ),
                                          ),
                                          validator: (value) {
                                            bool isemail = false;
                                            if (value.isEmpty) {
                                              return "Email / Mobile Number";
                                            } else if (value.isNotEmpty) {
                                              try {
                                                print(int.parse(value[0]));
                                                isemail = false;
                                              } on Exception catch (_) {
                                                isemail = true;
                                                print('never reached');
                                              }
                                              if (isemail) {
                                                final validyEmail =
                                                    emailvalidation(
                                                        email: value);
                                                if (validyEmail != true) {
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
                                  title: "Continue",
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
                'Already have an account?',
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
                    '  Sign in',
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
