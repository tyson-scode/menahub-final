import 'package:flutter/material.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:flutter/material.dart';
import 'package:menahub/Util/ConstantData.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:menahub/config/CustomLoader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List notificationList =[];

  @override
  void initState() {
    super.initState();
    getNewNotification();
  }

  getNewNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    ApiResponseModel responseData = await getApiCall(
      getUrl: getNotification,
      headers: headers,
      context: context,
    );
    if (responseData.statusCode == 200) {
      setState(() {
        notificationList = responseData.responseValue;
        print("notificationList : $notificationList");
      });
    }else {
      print(responseData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: Locale(context.locale.languageCode),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Notifications"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: appBarColor,
        ),
        body:notificationList.isEmpty
            ? Center(
          child: CustomerLoader(
            dotType: DotType.circle,
            dotOneColor: secondaryColor,
            dotTwoColor: primaryColor,
            dotThreeColor: Colors.red,
            duration: Duration(milliseconds: 1000),
          ),
        )
            :
        Container(
          color: whiteColor,
          height: double.infinity,
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: notificationList.length,
            itemBuilder: (context, index) {
              return Card(elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  child: Column(
                    children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15,bottom: 10, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notificationList[index]["order_status"],
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        sizedBoxheight5,
                        Text(
                            notificationList[index]["content"],
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
