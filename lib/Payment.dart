
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_selectaddress_new/Add%20Address.dart';
import 'package:dotted_line/dotted_line.dart';

void main() => runApp(new MaterialApp(
      home: new MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

bool agree = false;
bool visible = false;

class _MyAppState extends State<MyApp> {
  int selectedRadio = 0;

  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

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
        title: Text('Choose Payment'),
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
      body: // Padding(
          // padding: EdgeInsets.only(
          //   top: height * 0.01,
          //  right: width * 0.02,
          //  left: width * 0.02,
//        ),
          SafeArea(
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
                    Container(
                      width: width,
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
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
                            padding: const EdgeInsets.fromLTRB(20, 8, 0, 0),
                            child: Row(
                              children: [Text('Address Type: Home')],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 8, 0, 8),
                                child: Text(
                                  'Muhammad,17 North Jennings Rd.Morrissville,USA',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 0, 8),
                      child: Text(
                        'Additional Information',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(
                      height: 5,
                      thickness: 1,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (visible == false) {
                            visible = true;
                          } else {
                            visible = false;
                          }
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Flexible(
                              flex: 8,
                              fit: FlexFit.tight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 8, 0, 10),
                                child: Text(
                                  'Other Details',
                                  style: TextStyle(
                                      fontWeight: visible == true
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Visibility(
                      visible: visible == true ? true : false,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            /*Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                              child: Text('Other Details',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                            ),*/
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
                    ),
                    Visibility(
                      visible: visible == true ? true : false,
                      child: GestureDetector(
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                          child: Text(
                            'Choose Payment',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 5,
                      thickness: 1,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: 1,
                                groupValue: selectedRadio,
                                onChanged: (val) {
                                  setSelectedRadio(val);
                                  print(val);
                                }),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  setSelectedRadio(1);
                                });
                              },
                              child: Transform(
                                transform:
                                    Matrix4.translationValues(-10, 0.0, 0.0),
                                child: Text(
                                  'Credit/ Debit/ATM Card',
                                  style: TextStyle(
                                      color: selectedRadio == 1
                                          ? Colors.blue
                                          : Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 0, 2),
                          child: Row(
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                flex: 1,
                                child: Transform(
                                  transform: Matrix4.translationValues(
                                      -16, -12.0, 0.0),
                                  child: Text(
                                    'Lorem Ipsum is simply dummy text of the printing and typeset industry.Loreum Ipsum has been the industry',
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 5,
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 2,
                                groupValue: selectedRadio,
                                onChanged: (val) {
                                  setSelectedRadio(val);
                                  print(val);
                                }),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  setSelectedRadio(2);
                                });
                              },
                              child: Transform(
                                transform:
                                    Matrix4.translationValues(-10, 0.0, 0.0),
                                child: Text(
                                  'Cash on Delivery',
                                  style: TextStyle(
                                      color: selectedRadio == 2
                                          ? Colors.blue
                                          : Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      height: 5,
                      thickness: 1,
                    ),
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
                      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
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
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                    /*  Padding(
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
                            'Place Order Request',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPressed: () {
                          print('hi');
                        },
                      ),
                    ),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: <Widget>[
        Container(
          height: height / 12,
          width: width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonTheme(
                child: RaisedButton(
                  padding: EdgeInsets.zero,
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        gradient: LinearGradient(colors: <Color>[
                          const Color(0xFFE07C24),
                          const Color(0xFFF69402),
                          const Color(0xFFF5BB2A),
                        ])),
                    child: Text(
                      'Place Order Request',
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
    );
  }
}
