import 'package:flutter/material.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/config/CustomLoader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:menahub/translation/locale_keys.g.dart';

class ChooseCountryScreen extends StatefulWidget {
  @override
  _ChooseCountryScreenState createState() => _ChooseCountryScreenState();
}

class _ChooseCountryScreenState extends State<ChooseCountryScreen> {
  int selectIndex;
  bool loaderStatus = false;
  List countryList = [];

  @override
  void initState() {
    super.initState();
    getStoreCongif();
  }

  getStoreCongif() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    ApiResponseModel response = await getApiCall(
      getUrl: getStoreConfig,
      headers: headers,
      context: context,
    );
    if (response.statusCode == 200) {
      List responseData = response.responseValue;
      Map storeMap = responseData[0];
      List storeListData = storeMap["store"];
      Map countriesMap = storeListData[0]["countries"];
      List countryList = countriesMap.values.toList();
      print(countryList);
      setState(() {
        this.countryList = countryList;
        loaderStatus = true;
      });
    } else {
      setState(() {
        loaderStatus = true;
      });
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
        appBar: AppBar(
          backgroundColor: primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(LocaleKeys.Country.tr()),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
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
              : ListView.builder(
                  itemCount: countryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectIndex = index;
                            });
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  // Icon(selectIndex == index
                                  //     ? Icons.check_box
                                  //     : Icons.check_box_outline_blank),
                                  // sizedBoxwidth10,
                                  Text(countryList[index]),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider()
                      ],
                    );
                  }),
        ),
      ),
    );
  }
}
