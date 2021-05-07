import 'package:flutter/material.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List notificationList = ["", ""];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: appBarColor,
        ),
        body: Container(
          color: whiteColor,
          height: double.infinity,
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: notificationList.length,
            itemBuilder: (context, index) {
              return Container(
                child: Container(
                    child: Column(
                  children: [
                    Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          image: DecorationImage(
                            image: AssetImage("assets/image/bannerImage1.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: null),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, right: 15, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Rock Bottom Prices on electronics",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 7.0, right: 7, top: 2, bottom: 2),
                                  child: Text(
                                    "New",
                                    style: TextStyle(
                                        color: whiteColor, fontSize: 12),
                                  ),
                                ),
                              )
                            ],
                          ),
                          sizedBoxheight5,
                          Row(
                            children: [
                              Text("No Cost emi",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)),
                              sizedBoxwidth5,
                              Container(
                                width: 1,
                                height: 10,
                                color: greyColor,
                              ),
                              sizedBoxwidth5,
                              Text("Exchange offer",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    sizedBoxheight10,
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Card(
                        elevation: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                                child: Text(
                              "Buy Now",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
              );
            },
          ),
        ),
      ),
    );
  }
}
