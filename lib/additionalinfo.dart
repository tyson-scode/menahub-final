import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dotted_line/dotted_line.dart';

void main() => runApp(new MaterialApp(
      home: new MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool agree = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () {},
        ),
        title: Text('Additional Information'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
            const Color(0xFF02161F),
            const Color(0xFF0B3B52),
            const Color(0xFF103D52),
            const Color(0xFF304C58),
          ])),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SafeArea(
          bottom: true,
          left: true,
          right: true,
          top: true,
          maintainBottomViewPadding: true,
          // minimum: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: width,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Icon(Icons.location_on_outlined),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2, 8, 0, 8),
                            child: Text(
                              'Delivery Details',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 5,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 8, 0, 0),
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Address Type: Home',

                                // overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                              flex: 8,
                              fit: FlexFit.loose,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(30, 8, 0, 8),
                                child: Text(
                                  'Muhammad,17 North Jennings Rd. Morriss vile,USA',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.loose,
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: width,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
                        child: Text(
                          'Additional Information',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Divider(
                        height: 5,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                              child: Text('Other Details',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                //enabled: false,
                                decoration: new InputDecoration(
                                  hintText:
                                      'Lorem Ipsum is simply dummy text of printing and typesetting industry.Lorem Ipsum has been the industrys standard dummy text ever since the 1500s',
                                  hintMaxLines: 5,
                                  hintStyle: TextStyle(fontSize: 14),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (agree == true)
                              agree = false;
                            else
                              agree = true;
                          });
                        },
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Checkbox(
                                  value: agree,
                                  onChanged: (bool value) {
                                    setState(() {
                                      agree = value;
                                    });
                                  }),
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                              flex: 8,
                              child: Text(
                                'I agree to the terms and conditions and the privacy policy*',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 120,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18, bottom: 6),
                        child: Row(
                          children: [
                            Text(
                              'PRICE DETAILS',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 5,
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Sub Total (4 items)'),
                            Text(
                              'QAR 11497.00',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 8, 15, 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Shipping'),
                            Text(
                              'QAR 25.00',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 10.0,
                        dashColor: Colors.grey,
                        dashRadius: 5.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Grand Total',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'QAR 11497.00',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1.0,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1.0,

                              // offset:Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          padding: EdgeInsets.zero,
                          color: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 60),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                gradient: LinearGradient(colors: <Color>[
                                  const Color(0xFFE07C24),
                                  const Color(0xFFF69402),
                                  const Color(0xFFF5BB2A),
                                ])),
                            child: Text(
                              'Continue to Payment',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPressed: () {
                            print('hi');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
