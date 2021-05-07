// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_paginator/flutter_paginator.dart';
// import 'package:menahub/Models/ProductListModel.dart';
// import 'Util/Api/ApiUrls.dart';
// import 'Util/ConstantData.dart';
// import 'Util/Widget.dart';
// import 'config/CustomLoader.dart';

// void main() => runApp(SampleDemo());

// class SampleDemo extends StatefulWidget {
//   @override
//   _SampleDemoState createState() => _SampleDemoState();
// }

// class _SampleDemoState extends State<SampleDemo> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Container(
//           child: Column(
//             children: [Expanded(child: HomePage())],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return HomeState();
//   }
// }

// class HomeState extends State<HomePage> {
//   GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return Paginator.listView(
//       key: paginatorGlobalKey,
//       pageLoadFuture: sendCountriesDataRequest,
//       pageItemsGetter: listItemsGetter,
//       listItemBuilder: listItemBuilder,
//       loadingWidgetBuilder: loadingWidgetMaker,
//       errorWidgetBuilder: errorWidgetMaker,
//       emptyListWidgetBuilder: emptyListWidgetMaker,
//       totalItemsGetter: totalPagesGetter,
//       pageErrorChecker: pageErrorChecker,
//       scrollPhysics: BouncingScrollPhysics(),
//     );
//   }

//   Future<ProductListModel> sendCountriesDataRequest(int page) async {
//     print('page $page');
//     String url =
//         'https://magento2blog.thestagings.com/rest/default/V1/products?searchCriteria[filter_groups][1][filters][1][field]=visibility&searchCriteria[sortOrders][1][field]=name&searchCriteria[sortOrders][1][direction]=ASC&searchCriteria[filter_groups][1][filters][1][value]=4&searchCriteria[page_size]=20&searchCriteria[current_page]=$page';
//     http.Response response = await http.get(
//       Uri.parse(url),
//     );
//     print(response.body);
//     return productListModelFromJson(response.body);
//   }

//   List<Item> listItemsGetter(ProductListModel productListModel) {
//     return productListModel.items;
//   }

//   Widget listItemBuilder(value, int index) {
//     Item productDetails = value;
//     List<CustomAttribute> customAttributes = productDetails.customAttributes;
//     int producImageIndex =
//         customAttributes.indexWhere((f) => f.attributeCode == "image");
//     CustomAttribute productDescriptionMap =
//         customAttributes[producImageIndex.abs()];
//     var productImage = productDescriptionMap.value;
//     return Container(
//       color: whiteColor,
//       margin: EdgeInsets.all(10),
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               flex: 3,
//               child: Container(
//                 margin: EdgeInsets.only(right: 10),
//                 height: 80,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                   image: DecorationImage(
//                     image: NetworkImage("$imageBaseUrl$productImage"),
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 child: null,
//               ),
//             ),
//             Expanded(
//               flex: 6,
//               child: Column(
//                 children: [
//                   Text(
//                     value.name,
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   sizedBoxheight5,
//                   Row(
//                     children: [
//                       Text(
//                         "QAR ${value.price}",
//                         style: TextStyle(
//                             color: secondaryColor,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       sizedBoxwidth10,
//                       Text(
//                         "QAR 699.00",
//                         style: TextStyle(
//                             color: greyColor,
//                             fontSize: 12,
//                             decoration: TextDecoration.lineThrough,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       sizedBoxwidth10,
//                       Text(
//                         "7% off",
//                         style: TextStyle(
//                             color: greyColor,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               flex: 0,
//               child: InkWell(
//                 child: Container(
//                   child: Image.asset(
//                     "assets/icon/heartIcon.png",
//                     height: 25,
//                     width: 25,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget loadingWidgetMaker() {
//     return Container(
//       padding: EdgeInsets.only(top: 20, bottom: 20),
//       child: CustomerLoader(
//         dotType: DotType.circle,
//         dotOneColor: secondaryColor,
//         dotTwoColor: primaryColor,
//         dotThreeColor: Colors.red,
//         duration: Duration(milliseconds: 1000),
//       ),
//     );
//   }

//   Widget errorWidgetMaker(ProductListModel productListModel, retryListener) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Text(productListModel.toString()),
//         ),
//         FlatButton(
//           onPressed: retryListener,
//           child: Text('Retry'),
//         )
//       ],
//     );
//   }

//   Widget emptyListWidgetMaker(ProductListModel productListModel) {
//     // product list can empty
//     return Center(
//       child: Text('list empty'),
//     );
//   }

//   int totalPagesGetter(ProductListModel productListModel) {
//     // to add product total count
//     return productListModel.totalCount;
//   }

//   bool pageErrorChecker(ProductListModel productListModel) {
//     /// to add api status
//     return false;
//   }
// }
