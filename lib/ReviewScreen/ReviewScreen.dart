import 'package:flutter/material.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, bottom: 0),
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
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return reviewCard(
                      context: context, reviewDetails: _items[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
