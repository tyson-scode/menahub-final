import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/config/CustomLoader.dart';
import 'package:menahub/translation/locale_keys.g.dart';
import 'ReviewCard.dart';
import 'package:easy_localization/easy_localization.dart';

class ReviewScreen extends StatefulWidget {
  final productId;

  ReviewScreen({this.productId});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  List _items = [];
  bool loaderStatus = false;

  @override
  void initState() {
    super.initState();
    print(widget.productId);
    getReviewsList();
  }

  getReviewsList() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    ApiResponseModel response = await getApiCall(
      getUrl: "${getReview}${widget.productId}",
      headers: headers,
      context: context,
    );
    List responseData = response.responseValue;
    if (response.statusCode == 200) {
      List reviewsList = responseData[0]["reviews"];
      print(responseData);
      print(reviewsList.length);
      setState(() {
        _items = reviewsList;
        loaderStatus = true;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          LocaleKeys.Reviews.tr(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ProgressHUD(
        child: Builder(
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            color: HexColor("#F1F3F6"),
            child: loaderStatus == false
                ? Center(
                    child: CustomerLoader(
                      dotType: DotType.circle,
                      dotOneColor: secondaryColor,
                      dotTwoColor: primaryColor,
                      dotThreeColor: Colors.red,
                      duration: Duration(milliseconds: 1000),
                    ),
                  )
                : _items.length == 0
                    ? Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: Center(
                            child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width -
                              MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 20, 15),
                                child: Center(
                                  child: Text("No " +
                                    LocaleKeys.Reviews.tr()+ " Yet",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      letterSpacing: 1,
                                      color: whiteColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )))
                    : Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, bottom: 0),
                              child: Text(
                                "${_items.length} " + LocaleKeys.Reviews.tr(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 15),
                              ),
                            ),
                            sizedBoxheight10,
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: _items.length ,
                                itemBuilder: (context, index) {
                                  return reviewCard(
                                      context: context,
                                      reviewDetails: _items[index]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
