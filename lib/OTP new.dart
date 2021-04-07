import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:pinput/pin_put/pin_put_state.dart';

void main() => runApp(new MaterialApp(home: new MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FocusNode myFocusNode;

  static get boxShadow => null;
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

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Flutter layout demo',
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          body: Container(
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
                        'asset/images/Group 2.png',
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
                                /*1*/
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /*2*/
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            bottom: 20, top: 120),
                                        //Center(
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
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
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
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
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

                                          // height: 70,
                                          // width: 350,
                                          child: PinPut(
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            separator: SizedBox(
                                              width: 0,
                                            ),
                                            fieldsAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            eachFieldConstraints:
                                                BoxConstraints(
                                                    // minHeight: 50,
                                                    // minWidth: 50,
                                                    ),
                                            eachFieldHeight: 60,
                                            eachFieldWidth: 60,
                                            fieldsCount: 4,
                                            focusNode: _pinPutFocusNode,
                                            controller: _pinPutController,
                                            disabledDecoration: BoxDecoration(
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
                              /*3*/
                            ],
                          ),
                        ),
                        // textSection,
                        //otp(),
                      ],
                    ),
                    ButtonTheme(
                      child: RaisedButton(
                        padding: EdgeInsets.zero,
                        color: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 100),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              gradient: LinearGradient(colors: <Color>[
                                const Color(0xFF011A26),
                                const Color(0xFF163340),
                                const Color(0xFF13303D),
                                const Color(0xFF2F434C),
                              ])),
                          child: Text(
                            'CONTINUE',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
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
              )),
        ),
      ),
    );
  }
}
