import 'package:flutter/material.dart';
import 'package:menahub/Template/OrderInfo/ProductItemCart.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/config/CustomLoader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:menahub/translation/codegen_loader.g.dart';
import 'package:menahub/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;
  final String incId;

  OrderDetailsScreen({this.orderId, this.incId});
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  List productList = [];
  Map billingAddress;
  Map shippingAddressDetails;
  Map orderDetails;

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
      getUrl: "$getParticulareOrderurl${widget.orderId}",
      headers: headers,
      context: context,
    );
    if (responseData.statusCode == 200) {
      Map data = responseData.responseValue;
      setState(() {
        orderDetails = data;
        productList = data["items"];
        billingAddress = data["billing_address"];
        //response split by shipping address details
        Map extensionAttributesMap = data["extension_attributes"];
        List shippingAssignmentsList =
            extensionAttributesMap["shipping_assignments"];
        Map shippingAssignmentsMap = shippingAssignmentsList.first;
        Map shippingInfo = shippingAssignmentsMap["shipping"];
        shippingAddressDetails = shippingInfo["address"];
      });
    } else {
      print(responseData);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: Locale(context.locale.languageCode),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //appbar
        appBar: AppBar(
          backgroundColor: appBarColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            LocaleKeys.Order_Detalis.tr(),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          centerTitle: false,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.grey[100],
          child: shippingAddressDetails == null
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
                    children: [
                      // order dates
                      Container(
                        color: whiteColor,
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        LocaleKeys.Order_Placed.tr(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      sizedBoxheight5,
                                      Text(
                                        DateFormat('dd/MM/yyyy').format(
                                            DateFormat('yyyy-MM-dd HH:mm:ss')
                                                .parse(orderDetails[
                                                    "created_at"])),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 1,
                                    height: 15,
                                    color: greyColor,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        LocaleKeys.Order_ID.tr(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      sizedBoxheight5,
                                      Text(
                                        orderDetails["increment_id"],
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 1,
                                    height: 15,
                                    color: greyColor,
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: secondaryColor,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 4,
                                              bottom: 4),
                                          child: Text(
                                            orderDetails["status"],
                                            style: TextStyle(
                                                color: whiteColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                      sizedBoxheight5,
                                      Text(
                                        "22 April 2020",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // shipping address
                      sizedBoxheight5,
                      Container(
                        color: whiteColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 20,
                                right: 20,
                                bottom: 5,
                              ),
                              child: Text(
                                LocaleKeys.SHIPPING_ADDRESS.tr(),
                                style: TextStyle(
                                  color: greyColor,
                                ),
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                bottom: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.home.tr(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  sizedBoxheight5,
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              '${shippingAddressDetails["firstname"]},',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                            text:
                                                ' ${shippingAddressDetails["street"][0]}, ${shippingAddressDetails["city"]}, ${shippingAddressDetails["postcode"]}'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      sizedBoxheight5,
                      //price detailsd
                      Container(
                        color: whiteColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 20,
                                right: 20,
                                bottom: 5,
                              ),
                              child: Text(
                                LocaleKeys.PRICE_DETAILS.tr(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: greyColor,
                                ),
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                bottom: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //sub total
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        LocaleKeys.Sub_Total.tr() +
                                            "(${orderDetails["total_qty_ordered"]} " +
                                            LocaleKeys.items.tr() +
                                            ")",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "QAR ${orderDetails["base_subtotal"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizedBoxheight5,
                                  //tax
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        LocaleKeys.Tax.tr(),
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "QAR ${orderDetails["base_tax_amount"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizedBoxheight5,
                                  //Shipping
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        LocaleKeys.Shipping.tr(),
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "QAR ${orderDetails["shipping_amount"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizedBoxheight5,
                                  //Discounts
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        LocaleKeys.Discounts.tr(),
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "QAR ${orderDetails["base_discount_amount"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizedBoxheight5,
                                  //Promotional Discount
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       "Promotional Discount",
                                  //       style: TextStyle(
                                  //         fontSize: 12,
                                  //       ),
                                  //     ),
                                  //     Text(
                                  //       "QAR 11497.00",
                                  //       style: TextStyle(
                                  //         fontSize: 12,
                                  //         color: Colors.blue,
                                  //         fontWeight: FontWeight.w600,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // sizedBoxheight5,
                                  //Total
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        LocaleKeys.Total.tr(),
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "QAR ${orderDetails["total_due"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizedBoxheight10,
                                  //Total
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        LocaleKeys.Grand_Total.tr(),
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "QAR ${orderDetails["base_grand_total"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      sizedBoxheight10,
                      //email InVoice
                      Container(
                        width: screenSize.width,
                        color: whiteColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 20,
                                right: 20,
                                bottom: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.notes,
                                        color: Colors.blue,
                                      ),
                                      sizedBoxwidth10,
                                      Text(
                                        LocaleKeys.Email_InVoice.tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // product List
                      Container(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: productList.length,
                          itemBuilder: (context, index) {
                            return productItemCart(
                                productDetails: productList[index],
                                context: context);
                          },
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
