import 'dart:convert';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:menahub/Address/SelectAddressScreen.dart';
import 'package:menahub/OrdersInfo/OrderSuccessScreen.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/config/AppLoader.dart';
import 'package:menahub/config/CustomLoader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentMethodChoose extends StatefulWidget {
  final Map screenInfo;
  final Map billingAddress;
  final String cartId;
  PaymentMethodChoose({this.screenInfo, this.billingAddress, this.cartId});
  @override
  _PaymentMethodChooseState createState() => _PaymentMethodChooseState();
}

class _PaymentMethodChooseState extends State<PaymentMethodChoose> {
  int selectedRadio = 0;
  bool agree = false;
  bool otherinfovisible = false;
  List paymentList;
  Map paymentInformation;
  int paymentTypeId = 0;
  String orderId;
  void initState() {
    super.initState();
    selectedRadio = 0;
    paymentList = widget.screenInfo["payment_methods"];
    print("payment info $paymentList");
    print('address = ${widget.billingAddress}');
    paymentInformation = widget.screenInfo["totals"];
  }

  setPaymentInformation() async {
    final overlay = LoadingOverlay.of(context);
    overlay.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    var body = jsonEncode({
      "cartId": widget.cartId,
      "paymentMethod": {"method": "cashondelivery"},
      "billingAddress": {
        "customerAddressId": widget.billingAddress["save_in_address_book"],
        "countryId": widget.billingAddress["country_id"],
        "regionCode": widget.billingAddress["region"],
        "region": widget.billingAddress["region"],
        "customerId": widget.billingAddress["customer_id"],
        "street": widget.billingAddress["street"],
        "company": widget.billingAddress["company"],
        "telephone": widget.billingAddress["telephone"],
        "fax": null,
        "postcode": widget.billingAddress["postcode"],
        "city": widget.billingAddress["city"],
        "firstname": widget.billingAddress["firstname"],
        "lastname": widget.billingAddress["lastname"],
        "middlename": null,
        "prefix": null,
        "suffix": null,
        "vatId": null,
        "customAttributes": [],
        "saveInAddressBook": null
      }
    });
    ApiResponseModel responseData = await postApiCall(
      postUrl: "$setPaymentInformationApi",
      headers: headers,
      context: context,
      body: body,
    );
    print(responseData.responseValue);

    if (responseData.statusCode == 200) {
      overlay.hide();

      getPaymentInformation();
    } else {
      overlay.hide();
    }
  }

  getPaymentInformation() async {
    final overlay = LoadingOverlay.of(context);
    overlay.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    ApiResponseModel responseData = await getApiCall(
      getUrl: "$getPaymentInformationApi",
      headers: headers,
      context: context,
    );
    print(responseData.responseValue);
    if (responseData.statusCode == 200) {
      overlay.hide();

      Map responseMap = responseData.responseValue;
      placeOrder(paymentInformation: responseMap);
    } else {
      overlay.hide();
    }
  }

  placeOrder({Map paymentInformation}) async {
    final overlay = LoadingOverlay.of(context);
    overlay.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    var body = jsonEncode({
      "billingAddress": {
        "customerAddressId": widget.billingAddress["save_in_address_book"],
        "countryId": widget.billingAddress["country_id"],
        "regionCode": widget.billingAddress["region"],
        "region": widget.billingAddress["region"],
        "customerId": widget.billingAddress["customer_id"],
        "street": widget.billingAddress["street"],
        "company": widget.billingAddress["company"],
        "telephone": widget.billingAddress["telephone"],
        "fax": null,
        "postcode": widget.billingAddress["postcode"],
        "city": widget.billingAddress["city"],
        "firstname": widget.billingAddress["firstname"],
        "lastname": widget.billingAddress["lastname"],
        "middlename": null,
        "prefix": null,
        "suffix": null,
        "vatId": null,
        "customAttributes": [],
        "saveInAddressBook": null
      },
      "paymentMethod": {
        "method": "cashondelivery",
        "po_number": null,
        "additional_data": null
      }
    });
    ApiResponseModel responseData = await postApiCall(
      postUrl: "$placeOrderApi",
      headers: headers,
      context: context,
      body: body,
    );
    print(responseData.responseValue);
    orderId = responseData.responseValue;
    Navigator.of(context).pop();

    if (responseData.statusCode == 200) {
      overlay.hide();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderSuccessScreen(orderId),
        ),
      );
    } else {
      overlay.hide();
      Navigator.of(context).pop();
    }
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  const Color(0xFF02161F),
                  const Color(0xFF0B3B52),
                  const Color(0xFF103D52),
                  const Color(0xFF304C58),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                //delevery details
                Container(
                  width: width,
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectAddressScreen(),
                        ),
                      );
                    },
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
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 5, 0, 5),
                                    child: Text(
                                      'Delivery Details',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    flex: 9,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 8, 0, 8),
                                      child: Text(
                                        '${widget.billingAddress["firstname"]}' +
                                            ' ' +
                                            '${widget.billingAddress["lastname"]}' +
                                            " " +
                                            '${widget.billingAddress["street"][0]},' +
                                            ' ' +
                                            '${widget.billingAddress["city"]},' +
                                            ' ' +
                                            '${widget.billingAddress["postcode"]},' +
                                            '' +
                                            '${widget.billingAddress["telephone"]},', // ,17 North Jennings Rd.Morrissville, USA',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child: Icon(
                                        Icons.keyboard_arrow_right,
                                        size: 30,
                                      ),
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
                ),
                sizedBoxheight10,
                //Additional Information
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
                            if (otherinfovisible == false) {
                              otherinfovisible = true;
                            } else {
                              otherinfovisible = false;
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
                                        fontWeight: otherinfovisible == true
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
                        visible: otherinfovisible == true ? true : false,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  //enabled: false,
                                  decoration: new InputDecoration(
                                    // hintText:
                                    //     'Lorem Ipsum is simply dummy text of printing and typesetting industry.Lorem Ipsum has been the industrys standard dummy text ever since the 1500s',
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
                              CheckboxListTile(
                                activeColor: Theme.of(context).accentColor,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: Transform(
                                  transform:
                                      Matrix4.translationValues(-18, 0.0, 0.0),
                                  child: Text(
                                    'I agree to the terms and conditions and the privacy policy*',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                value: agree,
                                onChanged: (bool value) {
                                  setState(() {
                                    agree = value;
                                  });
                                },
                              ),
                              Visibility(
                                  visible: agree == false ? true : false,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(50, 0, 0, 10),
                                    child: Text(
                                      "[ Required *]",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )),
                              /* GestureDetector(
                                onTap: () {
                                  print('Text $agree');
                                  setState(() {
                                    if (agree == true)
                                      agree = true;
                                    else
                                      agree = false;
                                  });
                                },
                                child: Row(
                                  children: [

                                       Flexible(
                                      flex: 1,
                                      child:

                                      Checkbox(
                                          value: agree,
                                          onChanged: (bool value) {
                                            setState(() {
                                              agree = value;
                                              print('Agree = $agree');
                                            });
                                          }),
                                    ),
                                    Flexible(
                                      fit: FlexFit.loose,
                                      flex: 8,
                                      child: Text(
                                        'I agree to the terms and conditions and the privacy policy*',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                             */
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                sizedBoxheight10,

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
                      Container(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: paymentList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  paymentTypeId = index;
                                });
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          index == paymentTypeId
                                              ? Icons.radio_button_checked
                                              : Icons.radio_button_unchecked,
                                          color: index == paymentTypeId
                                              ? Colors.blue
                                              : Colors.black,
                                        ),
                                        sizedBoxheight5,
                                        Text(
                                          paymentList[index]["title"],
                                          style: TextStyle(
                                            color: index == paymentTypeId
                                                ? Colors.blue
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 5,
                                    thickness: 1,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
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
                            Text(
                                'Sub Total (${paymentInformation["items_qty"]} items)'),
                            Text(
                              'QAR ${paymentInformation["subtotal"]}',
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
                              'QAR ${paymentInformation["shipping_amount"]}',
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
                              'QAR ${paymentInformation["grand_total"]}',
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        persistentFooterButtons: [
          Container(
            height: 60,
            width: width,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ButtonTheme(
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                      padding: EdgeInsets.zero,
                      color: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 60),
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
                        if (agree == false) {
                          setState(() {
                            otherinfovisible = true;
                          });
                        } else {
                          setPaymentInformation();
                        }
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
