import 'package:flutter/material.dart';
import 'package:menahub/ProductsDetails/ProductsDetailsScreen.dart';
import 'package:menahub/Util/ConstantData.dart';

class FilterByCategoriesScreen extends StatefulWidget {
  final List categoriesList;
  FilterByCategoriesScreen({this.categoriesList});
  @override
  _FilterByCategoriesScreenState createState() =>
      _FilterByCategoriesScreenState();
}

class _FilterByCategoriesScreenState extends State<FilterByCategoriesScreen> {
  int rightMenuTappedIndex;
  Color unselectedbtncolor = Colors.grey[200];
  Color unselectedtextcolor = Colors.black;

  @override
  void initState() {
    super.initState();
  }

//catogry
  catogryList() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: widget.categoriesList.length,
      itemBuilder: (context, index) {
        return filterItem(widget.categoriesList[index], index);
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
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                values["display"],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: rightMenuTappedIndex == index
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color:
                      rightMenuTappedIndex == index ? primaryColor : blackColor,
                ),
              ),
              Text(
                values["count"].toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: rightMenuTappedIndex == index
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color:
                      rightMenuTappedIndex == index ? primaryColor : blackColor,
                ),
              ),
            ],
          ),
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
          // bottomNavigationBar: Container(
          //   color: whiteColor,
          //   height: 50,
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 5.0, bottom: 5),
          //     child: Row(
          //       children: [
          //         Expanded(
          //           flex: 2,
          //           child: Container(
          //             child: Center(
          //                 child: Text(
          //               'Clear',
          //               style: TextStyle(
          //                   fontSize: 20,
          //                   fontWeight: FontWeight.w600,
          //                   color: greyColor),
          //             )),
          //           ),
          //         ),
          //         Expanded(flex: 2, child: customButton(title: "APPLY")),
          //       ],
          //     ),
          //   ),
          // ),

          appBar: AppBar(
            centerTitle: false,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              "Category",
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
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  //search
                  // Container(
                  //   height: 43,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(5),
                  //     border: Border.all(
                  //       color: greyColor,
                  //       width: 1,
                  //     ),
                  //   ),
                  //   child: TextField(
                  //     decoration: new InputDecoration(
                  //       border: InputBorder.none,
                  //       hintText: 'Search',
                  //       prefixIcon: const Icon(
                  //         Icons.search,
                  //         color: Colors.grey,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: catogryList(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
