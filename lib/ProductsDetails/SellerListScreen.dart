import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:menahub/CustomWidget/CustomButton.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';

class SellerListScreen extends StatefulWidget {
  final List sellerDataList;
  final Map productDetails;
  SellerListScreen({this.sellerDataList, this.productDetails});
  @override
  _SellerListScreenState createState() => _SellerListScreenState();
}

class _SellerListScreenState extends State<SellerListScreen> {
  int tappedIndex;
  String productImage;
  //seller List
  sellerLists(Map values, index) {
    return InkWell(
      onTap: () {
        setState(() {
          tappedIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        color: tappedIndex == index ? Colors.blue[50] : whiteColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //price details
                  Row(
                    children: [
                      Text(
                        "QAR ${values["price"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: secondaryColor,
                        ),
                      ),
                      sizedBoxwidth20,
                      Text(
                        "QAR 9000.00",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough,
                          color: greyColor,
                        ),
                      ),
                      sizedBoxwidth20,
                      Text(
                        "7% off",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                  // sizedBoxheight10,
                  //ratings
                  // Row(
                  //   children: [
                  //     RatingBar.builder(
                  //       itemSize: 25,
                  //       ignoreGestures: true,
                  //       initialRating: 4,
                  //       minRating: 1,
                  //       direction: Axis.horizontal,
                  //       allowHalfRating: true,
                  //       itemCount: 5,
                  //       itemPadding: EdgeInsets.symmetric(horizontal: 0),
                  //       itemBuilder: (context, _) => Icon(
                  //         Icons.star,
                  //         color: Colors.amber,
                  //       ),
                  //       onRatingUpdate: (rating) {
                  //         print(rating);
                  //       },
                  //     ),
                  //     sizedBoxwidth10,
                  //     Text(
                  //       "(4 Ratings)",
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 12,
                  //         color: greyColor,
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // sizedBoxheight10,
                  //other information
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(
                  //       flex: 2,
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "Sold By:MH Seller - D002",
                  //             style: TextStyle(
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: 12,
                  //             ),
                  //           ),
                  //           sizedBoxheight10,
                  //           Row(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "Always in Stock: ",
                  //                 style: TextStyle(
                  //                   fontWeight: FontWeight.w600,
                  //                   fontSize: 12,
                  //                 ),
                  //               ),
                  //               Text(
                  //                 "90%",
                  //                 style: TextStyle(
                  //                     fontWeight: FontWeight.w600,
                  //                     color: secondaryColor),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     sizedBoxwidth10,
                  //     Expanded(
                  //       flex: 2,
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "Warranty : 2 Years Warranty",
                  //             style: TextStyle(
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: 12,
                  //             ),
                  //           ),
                  //           sizedBoxheight10,
                  //           Row(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "Ships On Time: ",
                  //                 style: TextStyle(
                  //                   fontWeight: FontWeight.w600,
                  //                   fontSize: 12,
                  //                 ),
                  //               ),
                  //               Text(
                  //                 "99%",
                  //                 style: TextStyle(
                  //                     fontWeight: FontWeight.w600,
                  //                     color: secondaryColor),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // ),

                  Html(data: values["description"])
                ],
              ),
            ),
            tappedIndex == index
                ? Container(
                    color: whiteColor,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: greyColor,
                              ),
                              Text(
                                "Select Seller",
                                style: TextStyle(
                                  color: greyColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider()
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    List bannerImageList = widget.productDetails["media_gallery_entries"];
    List imageList = bannerImageList.map((e) => e["file"].toString()).toList();
    productImage = imageList.first;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 0,
          title: Text(
            "${widget.sellerDataList.length} Sellers Available",
            style: TextStyle(
              color: blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: blackColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          color: whiteColor,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //product image & details
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        child: Image.network(
                          "$imageBaseUrl$productImage",
                          fit: BoxFit.contain,
                          height: 100,
                        ),
                      ),
                      sizedBoxwidth20,
                      Expanded(
                        child: Text(
                          widget.productDetails["name"],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //seller list
                ListView.builder(
                  padding: EdgeInsets.only(top: 0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: widget.sellerDataList.length,
                  itemBuilder: (context, index) {
                    return sellerLists(widget.sellerDataList[index], index);
                  },
                ), //view product
                Container(
                  height: 50,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Sole By: MH Seller - D005",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: customButton(
                              title: "View product",
                              backgroundColor: primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
