import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:menahub/OrdersInfo/OrderDetailsScreen.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:menahub/Util/StaticFunction.dart';

downloadInvoice(BuildContext _context) async {
  final progress = ProgressHUD.of(_context);
  progress.show();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get("token");
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': "Bearer $token"
  };

  ApiResponseModel response = await getApiCall(
    getUrl: downloadInvoiceApi,
    headers: headers,
  );
  if (response.statusCode == 200) {
    await createFileFromString(baseString: response.responseValue);
    progress.dismiss();
  } else {
    progress.dismiss();
  }
}

Future createFileFromString({String baseString}) async {
  var bytes = base64Decode(baseString.replaceAll('\n', ''));
  final output = await getTemporaryDirectory();
  final file = File("${output.path}/menahubInvoice.pdf");
  await file.writeAsBytes(bytes.buffer.asUint8List());
  print("${output.path}/menahubInvoice.pdf");
  await OpenFile.open("${output.path}/menahubInvoice.pdf");
}

orderItem({Map orderDetails, BuildContext context}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              OrderDetailsScreen(orderId: orderDetails["entity_id"].toString()),
        ),
      );
    },
    child: Container(
      color: whiteColor,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Order Placed",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "15 April 2020",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
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
                      "Order ID",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${orderDetails["increment_id"]}",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
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
                          color: orderDetails["status"] == "pending_payment"
                              ? secondaryColor
                              : orderDetails["status"] == "canceled"
                                  ? Colors.red
                                  : orderDetails["status"] == "delivered"
                                      ? primaryColor
                                      : orderDetails["status"] == "processing"
                                          ? secondaryColor
                                          : orderDetails["status"] == "pending"
                                              ? secondaryColor
                                              : primaryColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 4, bottom: 4),
                        child: Text(
                          "${orderDetails["status"]}".capitalize(),
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Text(
                      "22 April 2020",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            sizedBoxheight5,
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Sub Total (${orderDetails["items"].length} items)",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      sizedBoxwidth30,
                      Text(
                        " ${orderDetails["base_currency_code"]} ${orderDetails["subtotal"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  sizedBoxheight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Address :",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          " ${orderDetails["billing_address"]["street"][0]}, ${orderDetails["billing_address"]["postcode"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            sizedBoxheight10,
            Text(
              "Grand Total : ${orderDetails["base_currency_code"]} ${orderDetails["grand_total"]}",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            sizedBoxheight10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      downloadInvoice(context);
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(
                            "Download Invoice",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  height: 13,
                  color: greyColor,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          "Track Order Status",
                          style: TextStyle(
                              color: secondaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
