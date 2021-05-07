import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:menahub/ProductsDetails/ProductsDetailsScreen.dart';
import 'package:menahub/SearchScreen/SearchScreen.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/config/CustomLoader.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List categoriesLists = [];
  List colorLists = [];
  String indexname;
  int rightMenuTappedIndex;
  int leftMenuTappedIndex;
  int subListTappedIndex;

  Color selectedbtncolor = whiteColor;
  Color selectedtextcolor = redColor;
  Color unselectedbtncolor = Colors.grey[200];
  Color unselectedtextcolor = Colors.black;
  bool subListType = false;

  @override
  initState() {
    super.initState();
    getValues();
  }

  getValues() async {
    var body = jsonEncode({});
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    ApiResponseModel responseData = await postApiCall(
        postUrl: categoriesWithImage,
        body: body,
        headers: headers,
        context: context);
    if (responseData.statusCode == 200) {
      Map categoriesMap = responseData.responseValue[0][0];
      List categoriesList = categoriesMap["children"];
      setState(() {
        categoriesLists = categoriesList;
        for (var i = 0; i < categoriesLists.length; i++)
          colorLists.add(Color(Random().nextInt(0xffffffff)));
      });
    } else {
      print(responseData);
    }
  }

  //catogry
  categoriesList(values, index) {
    return InkWell(
      onTap: () {
        setState(() {
          rightMenuTappedIndex = index;
          leftMenuTappedIndex = null;
          subListTappedIndex = null;
        });
      },
      child: Container(
        decoration: BoxDecoration(color: colorLists[index]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        values["name"],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: rightMenuTappedIndex == index
                              ? appBarColor
                              : blackColor,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: leftMenuTappedIndex == index
                            ? appBarColor
                            : blackColor,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    height: 90,
                    width: 90,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorLists[index],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              image: DecorationImage(
                                image: NetworkImage(
                                    "$categoriesImageBaseUrl${values["image"]}"),
                                fit: BoxFit.contain,
                              ),
                            ),
                            child: null),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // if select any field show
            if (rightMenuTappedIndex == index)
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        leftMenuTappedIndex = index;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (contexts) => ProductsDetailsScreen(
                              productId: values["id"],
                              title: values["name"],
                            ),
                          ),
                        );
                      });
                    },
                    child: Container(
                      color: whiteColor,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 30, bottom: 10, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "See all ${values["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: secondaryColor,
                              ),
                            ),
                            // Icon(
                            //   Icons.keyboard_arrow_down,
                            //   color: leftMenuTappedIndex == index
                            //       ? appBarColor
                            //       : blackColor,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  filtertypeList(subList: values["children"]),
                ],
              )
          ],
        ),
      ),
    );
  }

  //sub catogry
  filtertypeList({List subList}) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: subList.length,
      itemBuilder: (context, index) {
        return filtertypeItem(subList[index], index);
      },
    );
  }

  filtertypeItem(values, index) {
    List subList = values["children"];
    print("sublist count ${subList.length}");
    print(subList.length);
    return InkWell(
      onTap: () {
        setState(() {
          leftMenuTappedIndex = index;
          subListTappedIndex = index;
          if (subList.isNotEmpty) {
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contexts) => ProductsDetailsScreen(
                  productId: values["id"],
                  title: values["name"],
                ),
              ),
            );
          }
        });
      },
      child: Container(
        color: whiteColor,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 30, bottom: 10, top: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${values["name"]} (${values["product_count"]})",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: leftMenuTappedIndex == index
                          ? appBarColor
                          : blackColor,
                    ),
                  ),
                  if (subList.isNotEmpty)
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: leftMenuTappedIndex == index
                          ? appBarColor
                          : blackColor,
                    ),
                ],
              ),
              // if select any field show
              if (subListTappedIndex == index)
                subListcatogry(subList: values["children"]),
            ],
          ),
        ),
      ),
    );
  }

//subcatogry tree
  subListcatogry({List subList}) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: subList.length,
      itemBuilder: (context, index) {
        return filtertypeItem(subList[index], index);
      },
    );
  }

  subListItem(values, index) {
    List subList = values["children"];
    print("sublist count ${subList.length}");
    print(subList.length);
    return InkWell(
      onTap: () {
        setState(() {
          subListTappedIndex = index;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contexts) => ProductsDetailsScreen(
                productId: values["id"],
                title: values["name"],
              ),
            ),
          );
        });
      },
      child: Container(
        color: whiteColor,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 30, bottom: 10, top: 10),
          child: Text(
            "${values["name"]} (${values["product_count"]})",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: subListTappedIndex == index ? appBarColor : blackColor,
            ),
          ),
        ),
      ),
    );
  }

  navigationSearchScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        top: false,
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: categoriesLists.isEmpty == true
                ? Center(
                    child: CustomerLoader(
                      dotType: DotType.circle,
                      dotOneColor: secondaryColor,
                      dotTwoColor: primaryColor,
                      dotThreeColor: Colors.red,
                      duration: Duration(milliseconds: 1000),
                    ),
                  )
                : Column(
                    children: [
                      //search
                      InkWell(
                        onTap: () {
                          navigationSearchScreen();
                        },
                        child: Container(
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
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20, top: 10, bottom: 10),
                            child: Container(
                              height: 39,
                              decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextField(
                                enabled: false,
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      'Search by Products, Brands & More...',
                                  hintStyle: TextStyle(color: Colors.white),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 10),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: categoriesLists.length,
                          itemBuilder: (context, index) {
                            return categoriesList(
                                categoriesLists[index], index);
                          },
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
