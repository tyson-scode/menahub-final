import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(home: new MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: height / 2,
                  width: width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                        const Color(0xFFE07C24),
                        const Color(0xFFE7852F),
                        const Color(0xFFF69402),
                      ]),
                      border: Border(),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(height / 2),
                          bottomRight: Radius.circular(height / 2))),
                ),
                Positioned(
                  top: 50,
                  left: 40,
                  child: Container(
                    height: height / 5,
                    width: width - 80,
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage('asset/order/Order.PNG'),
                    ),
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 170,
                  child: Container(
                    height: height / 10,
                    width: width / 8,
                    child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage('asset/order/delivery.png'),
                    ),
                  ),
                ),
                Positioned(
                  top: 250,
                  left: 100,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Text(
                          'Order Request Successful',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Text(
                          'Thanks for your Order Request',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                    //padding: const EdgeInsets.all(8.0),
                    //child: Text(
                    // 'Order Request Successful',
                    //  style: TextStyle(
                    //  color: Colors.white,
                    // fontSize: 16,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                height: height * 0.05,
                width: width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Order Request Summary',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(
                thickness: 2,
              ),
            ),
            Container(
              height: height * 0.05,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Request ID :',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' #MH3687',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(
                thickness: 2,
              ),
            ),
            Container(
              height: height * 0.05,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Order Date:',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' 12/01/2021',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(
                thickness: 2,
              ),
            ),
            Container(
              height: height * 0.05,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Store:',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Qatar',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(
                thickness: 2,
              ),
            ),
            Container(
              height: height * 0.05,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Order Request:',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Pending',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(
                thickness: 2,
              ),
            ),
            Container(
              height: height * 0.05,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Ship To:',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  ' Alwab Area,Khaliji 11 Street,Doha 12962,Qatar',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(
                thickness: 2,
              ),
            ),
            Container(
              height: height * 0.05,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Billing To::',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  ' Alwab Area,Khaliji 11 Street,Doha 12962,Qatar',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(
                thickness: 2,
              ),
            ),
            Container(
              height: height / 4,
              width: width,
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
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            gradient: LinearGradient(colors: <Color>[
                              const Color(0xFFE07C24),
                              const Color(0xFFF69402),
                              const Color(0xFFF5BB2A),
                            ])),
                        child: Text(
                          'View More Order Details',
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
                  ButtonTheme(
                    child: RaisedButton(
                      padding: EdgeInsets.zero,
                      color: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            gradient: LinearGradient(colors: <Color>[
                              const Color(0xFF103D52),
                              const Color(0xFF304C58),
                              const Color(0xFF2C5466),
                              const Color(0xFF4F7180),
                            ])),
                        child: Text(
                          'Back To Shopping',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          print('ok');
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
