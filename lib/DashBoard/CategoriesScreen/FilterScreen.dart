import 'package:flutter/material.dart';
import 'package:menahub/CustomWidget/CustomButton.dart';
import 'package:menahub/ProductsDetails/ProductsDetailsScreen.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';

class FilterScreen extends StatefulWidget {
  final Map filterMap;
  FilterScreen({Key key, this.filterMap}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String indexname;
  List rightMenuItemList = [];
  Color selectedbtncolor = whiteColor;
  Color selectedtextcolor = secondaryColor;
  int leftMenuTappedIndex = 0;
  int rightMenuTappedIndex;
  Color unselectedbtncolor = Colors.grey[200];
  Color unselectedtextcolor = Colors.black;
  List leftMenuItemList = [];

  @override
  void initState() {
    super.initState();
    widget.filterMap.removeWhere((key, value) => key == "Category");
    List filterKeysList = widget.filterMap.keys.toList();
    this.leftMenuItemList = filterKeysList;
    rightMenuItemList = widget.filterMap[leftMenuItemList.first];
    print(widget.filterMap);
  }

//right side  items
  filterList() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: rightMenuItemList.length,
      itemBuilder: (context, index) {
        return filterItem(rightMenuItemList[index], index);
      },
    );
  }

  filterItem(Map values, index) {
    return InkWell(
      onTap: () {
        setState(() {
          rightMenuTappedIndex = index;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contexts) => ProductsDetailsScreen(
                productId: values["value"],
                title: values["display"],
              ),
            ),
          );
        });
      },
      child: Container(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  sizedBoxwidth10,
                  Text(
                    values["display"],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: rightMenuTappedIndex == index
                          ? secondaryColor
                          : blackColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    values["count"],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: rightMenuTappedIndex == index
                          ? secondaryColor
                          : blackColor,
                    ),
                  ),
                  sizedBoxwidth5,
                  Container(
                    child: Image.asset(
                      "assets/icon/unselectRadioIcon.png",
                      height: 20,
                      width: 20,
                      color: rightMenuTappedIndex == index
                          ? secondaryColor
                          : blackColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//left side type of catogry
  filtertypeList() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: leftMenuItemList.length,
      itemBuilder: (context, index) {
        return filtertypeItem(leftMenuItemList[index], index);
      },
    );
  }

  filtertypeItem(name, index) {
    return InkWell(
      onTap: () {
        setState(() {
          leftMenuTappedIndex = index;
          rightMenuItemList = widget.filterMap[leftMenuItemList[index]];
          rightMenuTappedIndex = null;
        });
      },
      child: Container(
        color: leftMenuTappedIndex == index
            ? selectedbtncolor
            : unselectedbtncolor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                name,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: leftMenuTappedIndex == index
                        ? selectedtextcolor
                        : unselectedtextcolor),
              ),
            ),
          ],
        ),
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
          bottomNavigationBar: Container(
            color: whiteColor,
            height: 50,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Center(
                        child: Text(
                      'Clear',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: greyColor),
                    )),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: customButton(
                        title: "APPLY",
                        backgroundColor: secondaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            centerTitle: false,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              "Filters",
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: whiteColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            backgroundColor: appBarColor,
            brightness: Brightness.dark,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.grey[200],
                        child: filtertypeList(),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        height: MediaQuery.of(context).size.height - 148,
                        child: filterList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
