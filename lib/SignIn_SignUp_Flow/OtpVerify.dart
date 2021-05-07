import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:menahub/CustomWidget/CustomButton.dart';
import 'package:menahub/SignIn_SignUp_Flow/ResetPassword.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/config/CustomBackground.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpVerify extends StatefulWidget {
  OtpVerify({this.mobilenumber, this.code});
  final String code;
  final String mobilenumber;
  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  FocusNode myFocusNode;

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

  verifyotp({String otp}) async {
    var body = jsonEncode({"telephone": widget.mobilenumber, "otp": otp});
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    ApiResponseModel responseData = await postApiCall(
        postUrl: verifyOtpApi, body: body, headers: headers, context: context);
    print(responseData.responseValue);
    if (responseData.statusCode == 200) {
      setState(() {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => ResetPassword(
              mobilenumber: widget.mobilenumber,
              code: widget.code,
              otp: otp,
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
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
                                                bottom: 20, top: 120),
                                            child: Text(
                                              'Verification Code',
                                              style: TextStyle(
                                                fontSize: 27,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(
                                              'Please check your email address for',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(
                                              'verification code',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ),
                                        ),
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
                                                    AutovalidateMode
                                                        .onUserInteraction,
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
                                                      BorderRadius.circular(20),
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
                                                      BorderRadius.circular(20),
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
                                                      BorderRadius.circular(20),
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
                                                followingFieldDecoration:
                                                    BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.white,
                                                  ),
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
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
                        InkWell(
                          onTap: () {
                            verifyotp(
                              otp: _pinPutController.text,
                            );
                          },
                          child: Container(
                            width: 220,
                            child: customButton(
                                title: "Continue",
                                backgroundColor: primaryColor),
                          ),
                        )
                      ],
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
                    onTap: () {},
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
