import 'package:flutter/material.dart';
import 'package:menahub/DashBoard/DashBoard.dart';
import 'package:menahub/MyOrdersScreen/MyOrdersScreen.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/config/CustomLoader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:intl/intl.dart';

class OrderSuccessScreen extends StatefulWidget {
  final id;
  OrderSuccessScreen(this.id);
  @override
  _OrderSuccessScreenState createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  List productList = [];
  Map billingAddress;
  Map shippingAddressDetails;
  Map orderDetails;
  String orderId;

  @override
  void initState() {
    getOrderDetails();
    super.initState();
  }

  getOrderDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    ApiResponseModel responseData = await getApiCall(
      getUrl: "$getParticulareOrderurl${widget.id}",
      headers: headers,
      context: context,
    );
    if (responseData.statusCode == 200) {
      Map data = responseData.responseValue;
      setState(() {
        orderDetails = data;
        print('Order Details : $orderDetails');
        productList = data["items"];
        billingAddress = data["billing_address"];
        //response split by shipping address details
        Map extensionAttributesMap = data["extension_attributes"];
        List shippingAssignmentsList =
            extensionAttributesMap["shipping_assignments"];
        Map shippingAssignmentsMap = shippingAssignmentsList.first;
        Map shippingInfo = shippingAssignmentsMap["shipping"];
        shippingAddressDetails = shippingInfo[
            "address"]; //print("shipping :" + shippingAddressDetails.toString());
      });
    } else {
      print(responseData);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // var str = orderDetails["store_name"];
    // blockName1 == null ? "" : blockName1,
    // var parts = str.split('\n');
    // var crearted_at = orderDetails["created_at"];
    // //2021-05-03 06:12:17
    // var crearted_at_date = DateFormat('yyyy-MM-dd HH:mm:ss').parse(crearted_at);
    // var created_at_converted =
    //     DateFormat('dd/MM/yyyy').format(crearted_at_date);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: orderDetails == null
            ? Center(
                child: CustomerLoader(
                  dotType: DotType.circle,
                  dotOneColor: secondaryColor,
                  dotTwoColor: primaryColor,
                  dotThreeColor: Colors.red,
                  duration: Duration(milliseconds: 1000),
                ),
              )
            : SingleChildScrollView(
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
                              image: AssetImage('assets/order/orderStatus.png'),
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
                              image: AssetImage('assets/order/delivery.png'),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: Text(
                                  'Thanks for your Order Request',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
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
                                text: 'Request ID : ',
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: orderDetails["increment_id"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
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
                                text: 'Order Date: ',
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: DateFormat('dd/MM/yyyy').format(
                                          DateFormat('yyyy-MM-dd HH:mm:ss')
                                              .parse(
                                                  orderDetails["created_at"])),

                                      // text: created_at_converted,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
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
                                text: 'Store: ',
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: orderDetails["store_name"]
                                          .split('\n')[0]
                                          .trim(),
                                      // parts[0].trim(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
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
                                      text: orderDetails["status"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Ship To: ',
                                  style: TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            ' ${shippingAddressDetails["street"][0]}, ${shippingAddressDetails["city"]}, ${shippingAddressDetails["postcode"]}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Billing To: ',
                                  style: TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            ' ${billingAddress["street"][0]}, ${billingAddress["city"]}, ${billingAddress["postcode"]}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
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
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              padding: EdgeInsets.zero,
                              color: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 80),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyOrdersScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                          ButtonTheme(
                            // ignore: deprecated_member_use
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DashBoard(
                                        initialIndex: 0,
                                      ),
                                    ),
                                  );
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
      ),
    );
  }
}
