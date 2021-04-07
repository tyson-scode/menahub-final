import 'package:flutter/foundation.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:badges/badges.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

List<String> images = [
  'asset/Home/m0gQdQ_4_.png',
  'asset/Home/AEcPZr_7_.png',
  'asset/Home/Nircus_7_.png',
  'asset/Home/Vp0aGX_7_.png',
  'asset/Home/JhJVQk_7_.png',
  'asset/Home/Z1t94t_7_.png',
  'asset/Home/TrNynw_7_.png',
  'asset/Home/cWQmGn.tif_3_.png',
  'asset/Home/grxGQw_7_.png',
];

class Sample5 {
  final String image, title1, title2;

  Sample5({
    this.image,
    this.title1,
    this.title2,
  });
}

List<Sample5> samples5 = [
  Sample5(
    image: "asset/sample05/BuW9A8.tif_1_.png",
    title1: "Lenova|Yoga Tab S10 X705F,Iron Grey",
    title2: "QAR 999.00",
  ),
  Sample5(
    image: "asset/sample05/gUMp1V.tif_1_.png",
    title1: "Lenova|M10 FHD-TabX606X,Iron Grey",
    title2: "QAR 899.00",
  ),
  Sample5(
    image: "asset/sample05/Layer_0_3_.png",
    title1: "Lenova|Tab V7-6505,Black|ZA4L0064AE",
    title2: "QAR 499.00",
  ),
];

class Product {
  final String image, title;
  final Color color;
  Product({
    this.image,
    this.title,
    this.color,
  });
}

List<Product> products = [
  Product(
      title: "Office and Commercial Supplies",
      image: "asset/sample3/Rectangle 755.png",
      color: Color(0xFFF7C4BA)),
  Product(
      title: "Arts & Entertainment",
      image: "asset/sample3/Group 1636.png",
      color: Color(0xFFF9D1AA)),
  Product(
      title: "Machinery",
      image: "asset/sample3/Rectangle 760.png",
      color: Color(0xFFE2DED9)),
  Product(
      title: "Electronics",
      image: "asset/sample3/Rectangle 763.png",
      color: Color(0xFFC3D3E0)),
];

class Quote {
  final String image, title;
  final Color color;
  Quote({
    this.image,
    this.title,
    this.color,
  });
}

List<Quote> quotes = [
  Quote(
      title: "100% from   Qatar Stores",
      image: "asset/navigation/Group 637.png",
      color: Color(0xFFE5E5E1)),
];

class Quote1 {
  final String image, title;
  final Color color;
  Quote1({
    this.image,
    this.title,
    this.color,
  });
}

List<Quote1> quotes1 = [
  Quote1(
      title: "Secure Online Payment Gateway",
      image: "asset/navigation/Group 639.png",
      color: Color(0xFFE5E5E1)),
];

@override
class Product1 {
  final String image, title1, title2;
  Color color1, color2;
  IconData icon;

  Product1(
      {this.image,
      this.icon,
      this.title1,
      this.title2,
      this.color1,
      this.color2});
}

bool color = false;
List<Product1> products1 = [
  Product1(
      image: "asset/sample2/WnqiWO.tif_5_.png",
      icon: Icons.favorite,
      title1: "DJ Multiplayer Disc Driver",
      title2: "QAR 9000",
      color1: Color(0xFF707070),
      color2: Color(0xFFF60202)),
  Product1(
      image: "asset/sample2/ViMhI9_5_.png",
      icon: Icons.favorite,
      title1: "Bose Bluetooth Speaker",
      title2: "QAR 9000",
      color1: Color(0xFF707070),
      color2: Color(0xFFF60202)),
  Product1(
      image: "asset/sample2/Group 1746.png",
      icon: Icons.favorite,
      title1: "Headphones",
      title2: "QAR 499",
      color1: Color(0xFF707070),
      color2: Color(0xFFF60202)),
  Product1(
      image: "asset/sample2/Layer_0_7_.png",
      icon: Icons.favorite,
      title1: "Bluetooth Speaker",
      title2: "QAR 499",
      color1: Color(0xFF707070),
      color2: Color(0xFFF60202)),
];

class Topbrands {
  final String image, title1, title2, title3;

  Topbrands({
    this.image,
    this.title1,
    this.title2,
    this.title3,
  });
}

List<Topbrands> brands = [
  Topbrands(
    image: "asset/topbrands/Rectangle 811.png",
    title1: "QAR 150.00",
    title2: "QAR 160.00",
    title3: "10% off",
  ),
  Topbrands(
    image: "asset/topbrands/Rectangle 812.png",
    title1: "QAR 150.00",
    title2: "QAR 160.00",
    title3: "10% off",
  ),
  Topbrands(
    image: "asset/topbrands/Rectangle 813.png",
    title1: "QAR 150.00",
    title2: "QAR 160.00",
    title3: "10% off",
  ),
  Topbrands(
    image: "asset/topbrands/Rectangle 814.png",
    title1: "QAR 150.00",
    title2: "QAR 160.00",
    title3: "10% off",
  ),
  Topbrands(
    image: "asset/topbrands/Rectangle 815.png",
    title1: "QAR 150.00",
    title2: "QAR 160.00",
    title3: "10% off",
  ),
  Topbrands(
    image: "asset/topbrands/Rectangle 816.png",
    title1: "QAR 150.00",
    title2: "QAR 160.00",
    title3: "10% off",
  ),
];
String blockName1;
String blockName2;
String blockName3;
String blockName4;
String blockName5;
String blockName6;
String blockName7;
String block5img1, block5img2, block5img3;
String block5img1name, block5img2name, block5img3name;
String block5img1price, block5img2price, block5img3price;

List<String> banner1 = [];
List<String> banner2 = [];
List sampleBlock1 = [];
List sampleBlock2 = [];
List sampleBlock3 = [];
List sampleBlock4 = [];
List sampleBlock5 = [];
List sampleBlock6 = [];
List sampleBlock7 = [];

String sliderBaseUrl =
    "https://magento2blog.thestagings.com/pub/media/mageplaza/bannerslider/banner/image/";
String blockBaseUrl =
    "https://magento2blog.thestagings.com/pub/media/catalog/product/";
List cardList3 = [Item3(), Item3(), Item3()];

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

void main() => runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  int selectedIndex1 = 0;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    Slider1();
    Slider2();
    sampleblock1();
    sampleblock2();
    sampleblock3();
    sampleblock4();
    sampleblock5();
    sampleblock6();
    sampleblock7();
  }

  Slider1() async {
    http.Response slider1 = await http.get(
      Uri.parse(
          "https://magento2blog.thestagings.com/rest/default/V1/bannersliderblocks/1"),
    );

    if (slider1.statusCode == 200) {
      List sliderData1 = json.decode(slider1.body);
      for (Map item in sliderData1) {
        banner1.add(item["image"]);
      }
      setState(() {
        banner1 = banner1;
      });
    }
  }

  Slider2() async {
    http.Response slider2 = await http.get(
      Uri.parse(
          "https://magento2blog.thestagings.com/rest/default/V1/bannersliderblocks/2"),
    );

    if (slider2.statusCode == 200) {
      List sliderData2 = json.decode(slider2.body);
      for (Map item in sliderData2) {
        banner2.add(item["image"]);
      }
      setState(() {
        banner2 = banner2;
      });
    }
  }

  sampleblock1() async {
    http.Response tabresponse = await http.get(
      Uri.parse(
          "https://magento2blog.thestagings.com/rest/default/V1/productblocks/1"),
    );

    if (tabresponse.statusCode == 200) {
      List responseList = json.decode(tabresponse.body);
      Map responseMap = responseList[0];
      List itemList = responseMap["items"];
      String blockName = responseMap["name"];

      //print(blockName);
      //   print(itemList.length);
      //  print(itemList);
      setState(() {
        sampleBlock1 = itemList;
        blockName1 = blockName;
      });
    }
  }

  sampleblock2() async {
    http.Response tabresponse = await http.get(
      Uri.parse(
        "https://magento2blog.thestagings.com/rest/default/V1/productblocks/2",
      ),
    );

    if (tabresponse.statusCode == 200) {
      List responseList = json.decode(tabresponse.body);
      Map responseMap = responseList[0];
      List itemList = responseMap["items"];
      String blockName = responseMap["name"];

      //print(blockName);
      //   print(itemList.length);
      //  print(itemList);
      setState(() {
        sampleBlock2 = itemList;
        blockName2 = blockName;
      });
    }
  }

  sampleblock3() async {
    http.Response tabresponse = await http.get(
      Uri.parse(
          "https://magento2blog.thestagings.com/rest/default/V1/productblocks/3"),
    );

    if (tabresponse.statusCode == 200) {
      List responseList = json.decode(tabresponse.body);
      Map responseMap = responseList[0];
      List itemList = responseMap["items"];
      String blockName = responseMap["name"];

      //print(blockName);
      //   print(itemList.length);
      //  print(itemList);
      setState(() {
        sampleBlock3 = itemList;
        blockName3 = blockName;
      });
    }
  }

  sampleblock4() async {
    http.Response tabresponse = await http.get(
      Uri.parse(
          "https://magento2blog.thestagings.com/rest/default/V1/productblocks/4"),
    );

    if (tabresponse.statusCode == 200) {
      List responseList = json.decode(tabresponse.body);
      Map responseMap = responseList[0];
      List itemList = responseMap["items"];
      String blockName = responseMap["name"];

      setState(() {
        sampleBlock4 = itemList;
        blockName4 = blockName;
      });
    }
  }

  sampleblock5() async {
    http.Response tabresponse = await http.get(
      Uri.parse(
          "https://magento2blog.thestagings.com/rest/default/V1/productblocks/5"),
    );

    if (tabresponse.statusCode == 200) {
      List responseList = json.decode(tabresponse.body);
      Map responseMap = responseList[0];
      List itemList = responseMap["items"];
      String blockName = responseMap["name"];
      String img1 = itemList[0]["image"];
      String img2 = itemList[1]["image"];
      String img3 = itemList[2]["image"];
      String name1 = itemList[0]["name"];
      String price1 = itemList[0]["price"];
      String name2 = itemList[1]["name"];
      String price2 = itemList[1]["price"];
      String name3 = itemList[2]["name"];
      String price3 = itemList[2]["price"];

      setState(() {
        sampleBlock5 = itemList;
        blockName5 = blockName;
        block5img1 = img1;
        block5img2 = img2;
        block5img3 = img3;
        block5img1name = name1;
        block5img2name = name2;
        block5img3name = name3;
        block5img1price = price1;
        block5img2price = price2;
        block5img3price = price3;
      });
    }
  }

  sampleblock6() async {
    http.Response tabresponse = await http.get(
      Uri.parse(
          "https://magento2blog.thestagings.com/rest/default/V1/productblocks/6"),
    );

    if (tabresponse.statusCode == 200) {
      List responseList = json.decode(tabresponse.body);
      Map responseMap = responseList[0];
      List itemList = responseMap["items"];
      String blockName = responseMap["name"];

      //print(blockName);
      //   print(itemList.length);
      //  print(itemList);
      setState(() {
        sampleBlock6 = itemList;
        blockName6 = blockName;
      });
    }
  }

  sampleblock7() async {
    http.Response tabresponse = await http.get(
      Uri.parse(
          "https://magento2blog.thestagings.com/rest/default/V1/productblocks/7"),
    );

    if (tabresponse.statusCode == 200) {
      List responseList = json.decode(tabresponse.body);
      Map responseMap = responseList[0];
      List itemList = responseMap["items"];
      String blockName = responseMap["name"];

      //print(blockName);
      //   print(itemList.length);
      //  print(itemList);
      setState(() {
        sampleBlock7 = itemList;
        blockName7 = blockName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Color(0xFF003254), Color(0xFF035D7C)],
                ),
              ),
            ),
            leadingWidth: width * 0.5,
            leading: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Image(
                  image: AssetImage('asset/Home/Group 1621.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Badge(
                  position: BadgePosition.topEnd(end: -5),

                  badgeContent: Text(
                    '4',
                    style: TextStyle(color: Colors.white),
                  ),
                  child: Image.asset(
                    "asset/Home/bell.png",
                  ),
                  // child: Icon(
                  //   Icons.notifications_outlined,
                  //   color: Colors.white,
                  //   size: 30,
                  // ),
                ),
              ),
            ],
          ),
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Column(children: [
              Container(
                width: width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[
                      Color(0xFF003254), Color(0xFF035D7C)
                      //   const Color(0xFF035D7C),
                    ])),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(),
                        filled: true,
                        hintText: 'Search by Products,Brands & More...',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                        fillColor: Color(0xFF2C687F),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          // borderSide: const BorderSide(
                          //   color: Color(0xFF003254),
                          //)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,

                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          // borderSide: const BorderSide(
                          //   color: Color(0xFF003254),
                        )),
                  ),
                ),
                // child: Container(
                //   child: TextField(
                //     style: TextStyle(color: Colors.white),
                //     decoration: InputDecoration(
                //       contentPadding: const EdgeInsets.symmetric(
                //         vertical: 10.0,
                //       ),
                //       filled: true,
                //       hintText: 'Search by Products,Brands & More...',
                //       hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                //       fillColor: Color(0xFF035D7C),
                //       prefixIcon: Icon(
                //         Icons.search_rounded,
                //         size: 30,
                //         color: Colors.white,
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //       ),
                //     ),
                //   ),
                // ),
              ),
              /*Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                fit: BoxFit.fill,
                                image: AssetImage('asset/Home/Group 1621.png'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Badge(
                                badgeContent: Text(
                                  '4',
                                  style: TextStyle(color: Colors.white),
                                ),
                                child: Icon(
                                  Icons.notifications_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              //height: 20,
                              width: width - 40,
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                  ),
                                  filled: true,
                                  hintText: 'Search by Products,Brands & More...',
                                  hintStyle:
                                      TextStyle(color: Colors.white, fontSize: 14),
                                  fillColor: Color(0xFF035D7C),
                                  prefixIcon: Icon(
                                    Icons.search_rounded,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),*/

              Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 2.0,
                      pageSnapping: true,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                    items: banner1
                        .map((image) => Container(
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                child: Image.network("$sliderBaseUrl$image",
                                    fit: BoxFit.fill, width: 1000.0),
                              ),
                            ))
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(banner1, (index, url) {
                      return Container(
                        width: 30.0,
                        height: 5.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          shape: BoxShape.rectangle,
                          color: selectedIndex == index
                              ? Colors.orange.shade700
                              : Colors.black12,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$blockName1",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          FlatButton(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.orange.shade700, width: 2),
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {},
                              child: Text(
                                "View All",
                                style: TextStyle(
                                  color: Colors.orange.shade700,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: sampleBlock1.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        String image = sampleBlock1[index]["image"];
                        //print(image);
                        return GestureDetector(
                          onTap: () {
                            String sku = sampleBlock1[index]["sku"];
                            String name = sampleBlock1[index]["name"];
                            String price = sampleBlock1[index]["price"];

                            print("Product Name: $sku,$name\nPrice:$price ");
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12)),
                              child: Center(
                                child: Image.network(
                                  "$blockBaseUrl$image",
                                  height: 100,
                                  width: 100,
                                  // fit: BoxFit.fill,
                                ),
                              )
                              // Text(sampleBlock1[index]["name"])
                              ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Container(
                height: height * 0.4,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue.shade50,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                          child: Text(
                            "$blockName2",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                            child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.orange.shade700,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {},
                                child: Text(
                                  "View All",
                                  style: TextStyle(
                                    color: Colors.orange.shade700,
                                  ),
                                )))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: sampleBlock2.length,
                          itemBuilder: (BuildContext context, int index) {
                            String image = sampleBlock2[index]["image"];
                            return Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: GestureDetector(
                                onTap: () {
                                  String sku = sampleBlock2[index]["sku"];
                                  String name = sampleBlock2[index]["name"];
                                  String price = sampleBlock2[index]["price"];

                                  print(
                                      "Product Name: $sku,$name\nPrice:$price ");
                                },
                                child: ClipRect(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black12)),
                                    child: Container(
                                      color: Colors.white,
                                      width: width * 0.4,
                                      height: height * 0.8,
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: FavoriteButton(
                                                    iconSize: 40,
                                                    isFavorite: false,
                                                    valueChanged:
                                                        (_isFavorite) {},
                                                  ),
                                                  // child: Icon(
                                                  //   Icons.favorite, size: 30,
                                                  //   color: Color(0xFF707070),
                                                  //   //  products1[index].icon,
                                                  //   //    color: products1[index].color1,
                                                  // ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: ClipRect(
                                                child: Image.network(
                                                  "$blockBaseUrl$image",
                                                  // fit: BoxFit.fill,
                                                  height: 100,
                                                  width: 150,
                                                ),
                                              ),
                                            )),
                                          ),
                                          Positioned(
                                            bottom: 30,
                                            left: 10,
                                            right: 30,
                                            child: Container(
                                              child: Text(
                                                sampleBlock2[index]["name"],
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                //   softWrap: false,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 10,
                                            left: 10,
                                            right: 30,
                                            child: SizedBox(
                                              child: Text(
                                                "QAR " +
                                                    sampleBlock2[index]
                                                        ["price"],
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.orange),
                                              ),
                                            ),
                                          ),
                                          /*Positioned(
                                            bottom: 0.0,
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              color: Colors.red,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(2.0),
                                                    child: Text(
                                                      sampleBlock2[index]["name"],
                                                      textAlign: TextAlign.center,
                                                      softWrap: true,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(2.0),
                                                    child: Text(
                                                      sampleBlock2[index]["price"],
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          color: Color(0xFFF78500)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),*/
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$blockName3",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      FlatButton(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.orange.shade700, width: 2),
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {},
                          child: Text(
                            "View All",
                            style: TextStyle(
                              color: Colors.orange.shade700,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: sampleBlock3.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    String image = sampleBlock3[index]["image"];
                    String baseclr = "0xFFF7";
                    String clr = sampleBlock3[index]["color"];
                    Color circlecolor = Color(int.parse("$baseclr" + "$clr"));

                    return Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: GestureDetector(
                        onTap: () {
                          String sku = sampleBlock3[index]["sku"];
                          String name = sampleBlock3[index]["name"];
                          String price = sampleBlock3[index]["price"];
                          print("Product Name: $sku,$name\nPrice:$price ");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          child: Container(
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Center(
                                    child: CircleAvatar(
                                  radius: 50,
                                  //foregroundColor: circlecolor,
                                  backgroundColor: circlecolor,
                                )),
                                /* Center(
                                  child: Container(
                                    height: 100,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            "$blockBaseUrl$image",
                                          ),
                                        )),
                                  ),
                                ),*/
                                Center(
                                  child: Container(
                                      child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: ClipRect(
                                      child: Image.network(
                                        "$blockBaseUrl$image",
                                        // fit: BoxFit.fill,
                                        height: 100,
                                        width: 150,
                                      ),
                                    ),
                                  )),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  right: 30,
                                  child: Container(
                                    width: width * 0.2,
                                    child: Text(
                                      sampleBlock3[index]["name"],
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                    /*Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: InkWell(
                          onTap: () {},
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(
                                child: CircleAvatar(
                                    //   backgroundColor: sampleBlock3[index]["color"],
                                    // radius: 70,
                                    ),
                              ),
                              Center(
                                  child: Image.network(
                                "$blockBaseUrl$image",
                                // fit: BoxFit.fill,
                              )),
                              Positioned(
                                  bottom: 0,
                                  child: Center(
                                    child: Text(
                                      sampleBlock3[index]["sku"],
                                      style:
                                          TextStyle(fontWeight: FontWeight.w700),
                                    ),
                                  ))
                            ],
                          )),
                    );*/
                  },
                ),
              ),
              Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 1.0,
                      pageSnapping: true,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          selectedIndex1 = index;
                        });
                      },
                    ),
                    items: banner2
                        .map((image) => Container(
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                child: Image.network("$sliderBaseUrl$image",
                                    fit: BoxFit.fill, width: 1000.0),
                              ),
                            ))
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(banner2, (index, url) {
                      return Container(
                        width: 30.0,
                        height: 5.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          shape: BoxShape.rectangle,
                          color: selectedIndex1 == index
                              ? Colors.orange.shade700
                              : Colors.black12,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Container(
                  height: height * 0.40,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.orange),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                            child: Text(
                              "$blockName4",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                              child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white, width: 2),
                                      borderRadius: BorderRadius.circular(20)),
                                  onPressed: () {},
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )))
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.30,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: sampleBlock4.length,
                          itemBuilder: (BuildContext context, int index) {
                            String image = sampleBlock4[index]["image"];
                            return Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: GestureDetector(
                                onTap: () {
                                  String sku = sampleBlock4[index]["sku"];
                                  String name = sampleBlock4[index]["name"];
                                  String price = sampleBlock4[index]["price"];

                                  print(
                                      "Product Name: $sku,$name\nPrice:$price ");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.black12)),
                                  child: Container(
                                    color: Colors.white,
                                    width: width * 0.4,
                                    height: height * 0.9,
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: FavoriteButton(
                                                  iconSize: 40,
                                                  isFavorite: false,
                                                  valueChanged:
                                                      (_isFavorite) {},
                                                ),
                                                // child: Icon(
                                                //   Icons.favorite, size: 30,
                                                //
                                                //   //   color: Color(0xFF707070),
                                                //   //  products1[index].icon,
                                                //   //    color: products1[index].color1,
                                                // ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                              child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: ClipRect(
                                              child: Image.network(
                                                "$blockBaseUrl$image",
                                                // fit: BoxFit.fill,
                                                height: 100,
                                                width: 150,
                                                /* height: 150,
                                                width: 200,*/
                                              ),
                                            ),
                                          )),
                                        ),
                                        Positioned(
                                          bottom: 30,
                                          left: 10,
                                          right: 30,
                                          child: SizedBox(
                                            width: width * 0.3,
                                            child: Text(
                                              sampleBlock4[index]["name"],
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 10,
                                          left: 10,
                                          right: 30,
                                          child: SizedBox(
                                            width: width * 0.3,
                                            child: Text(
                                              "QAR " +
                                                  sampleBlock4[index]["price"],
                                              textAlign: TextAlign.left,
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange),
                                            ),
                                          ),
                                        ),
                                        /*Positioned(
                                          bottom: 0.0,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            color: Colors.red,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    sampleBlock2[index]["name"],
                                                    textAlign: TextAlign.center,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    sampleBlock2[index]["price"],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(0xFFF78500)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),*/
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                            /*Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12)),
                                child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      color: Colors.white,
                                      width: width * 0.4,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            right: 0,
                                            top: 10,
                                            child: Icon(
                                              Icons.favorite,
                                              color: Color(0xFF707070),
                                              // products1[index].icon,
                                              //   color: products1[index].color1,
                                            ),
                                          ),
                                          Center(
                                              child: Image.network(
                                            "$blockBaseUrl$image",
                                            // fit: BoxFit.fill,
                                          )),
                                          Positioned(
                                              bottom: 20,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 2),
                                                child: Text(
                                                  sampleBlock4[index]["sku"],
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 12),
                                                ),
                                              )),
                                          Positioned(
                                              bottom: 0,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 2),
                                                child: Text(
                                                  sampleBlock4[index]["price"],
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xFFF78500)),
                                                ),
                                              )),
                                        ],
                                      ),
                                    )),
                              ),
                            );*/
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Container(
                  height: height * 0.75,
                  width: width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                            child: Text(
                              'Top Brands',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                              child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.orange.shade700,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20)),
                                  onPressed: () {},
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                      color: Colors.orange.shade700,
                                    ),
                                  )))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                            child: Text(
                              'SENCOR',
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 5),
                            ),
                          ),
                        ],
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: height / 2,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          pauseAutoPlayOnTouch: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              selectedIndex1 = index;
                            });
                          },
                        ),
                        items: cardList3.map((container) {
                          return Builder(builder: (BuildContext context) {
                            return Container(
                              width: width,
                              decoration: BoxDecoration(color: Colors.black12),
                              child: container,
                            );
                          });
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: map<Widget>(cardList3, (index, url) {
                            return Container(
                              width: 30.0,
                              height: 5.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                shape: BoxShape.rectangle,
                                color: selectedIndex1 == index
                                    ? Colors.orange.shade700
                                    : Colors.black12,
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),*/

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Container(
                  height: height * 0.75,
                  width: width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                        const Color(0xFFF6B367),
                        const Color(0xFF70828E),
                      ])),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                            child: Text(
                              "$blockName5",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                              child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.black, width: 2),
                                      borderRadius: BorderRadius.circular(20)),
                                  onPressed: () {},
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ))),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: height * 0.60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 200,
                                      width: 200,
                                      child:
                                          /*Image.asset(
                                          'asset/sample05/Layer_0_3_.png',
                                          fit: BoxFit.fill,
                                        ),*/
                                          Image.network(
                                        "$blockBaseUrl$block5img1",

                                        height: 100,
                                        width: 150, //  fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        width: width * 0.4,
                                        child: Center(
                                          child: Text(
                                            "$block5img1name",
                                            // sampleBlock5[0]["name"],
                                            // 'Lenova|Yoga Tab S10 - X705F,Iron Grey',
                                            // overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        width: width * 0.3,
                                        child: Center(
                                          child: Text(
                                            "QAR $block5img1price",
                                            //sampleBlock5[0]["price"],
                                            //'QAR 999.00',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: VerticalDivider(
                                  thickness: 5,
                                  width: 2,
                                ),
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Container(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 20, 0, 0),
                                                    child: Container(
                                                      height: 100,
                                                      width: 100,
                                                      child:
                                                          /*Image.asset(
                                          'asset/sample05/Layer_0_3_.png',
                                          fit: BoxFit.fill,
                                        ),*/
                                                          Image.network(
                                                        "$blockBaseUrl$block5img2",
                                                        height: 100,
                                                        width: 150,

                                                        //  fit: BoxFit.fitWidth,
                                                      ),
                                                    ),
                                                    /*Container(
                                                      child: Image.asset(
                                                          'asset/sample05/BuW9A8.tif_1_.png'),
                                                    ),*/
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Container(
                                                      width: width * 0.3,
                                                      child: Center(
                                                        child: Text(
                                                          "$block5img2name",
                                                          //   sampleBlock5[1]["name"],
                                                          //  'Lenova | M10 FHD - Tab X066X,Iron Grey',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Container(
                                                      width: width * 0.3,
                                                      child: Center(
                                                        child: Text(
                                                          "QAR $block5img2price",
                                                          //  sampleBlock5[1] ["price"],
                                                          //    'QAR 899.00',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.orange,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Divider(
                                              height: 2,
                                              thickness: 5,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 10, 0, 0),
                                                    child: Container(
                                                      height: 100,
                                                      width: 100,
                                                      child:
                                                          /*Image.asset(
                                          'asset/sample05/Layer_0_3_.png',
                                          fit: BoxFit.fill,
                                        ),*/
                                                          Image.network(
                                                        "$blockBaseUrl$block5img3",
                                                        height: 100,
                                                        width: 150,

                                                        //  fit: BoxFit.fitWidth,
                                                      ),
                                                    ),

                                                    /*Container(
                                                      child: Image.asset(
                                                          'asset/sample05/gUMp1V.tif_1_.png'),
                                                    ),*/
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Container(
                                                      width: width * 0.3,
                                                      child: Center(
                                                        child: Text(
                                                          "$block5img3name",
                                                          // sampleBlock5[2]["name"],
                                                          //   'Lenova|Tab V7-6505,Black|ZA4L0064AE',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Container(
                                                      width: width * 0.3,
                                                      child: Center(
                                                        child: Text(
                                                          "QAR $block5img3price",
                                                          // sampleBlock5[2]["price"],

                                                          //'QAR 499.00',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.orange,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Container(
                    height: height / 4,
                    width: width,
                    decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                          image: AssetImage('asset/Home/o1rZuR_2_.png'),
                          fit: BoxFit.fill,
                        ))),
              ),
              Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$blockName6",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          FlatButton(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.orange.shade700, width: 2),
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {},
                              child: Text(
                                "View All",
                                style: TextStyle(
                                  color: Colors.orange.shade700,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: sampleBlock6.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        String image = sampleBlock6[index]["image"];
                        //print(image);
                        return GestureDetector(
                          onTap: () {
                            String sku = sampleBlock6[index]["sku"];
                            String name = sampleBlock6[index]["name"];
                            String price = sampleBlock6[index]["price"];

                            print("Product Name: $sku,$name\nPrice:$price ");
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12)),
                              child: Image.network(
                                "$blockBaseUrl$image",
                                height: 100,
                                width: 100,

                                // fit: BoxFit.fill,
                              )
                              // Text(sampleBlock1[index]["name"])
                              ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: width,
                    //  height: height * 0.1,
                    color: Color(0xFFF9E6D7),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 20, 0, 0),
                      child: Text(
                        'Get the Best Quote',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
                  ),
                  Container(
                    height: height * 0.3,
                    width: width,
                    color: Color(0xFFF9E6D7),
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DottedBorder(
                        dashPattern: [10, 5],
                        strokeWidth: 2,
                        color: Colors.black12,
                        child: Container(
                          child: Column(
                            children: [
                              Flexible(
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  //   scrollDirection: Axis.horizontal,
                                  itemCount: quotes.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black12)),
                                          child: Container(
                                            color: Colors.white,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  fit: FlexFit.loose,
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              quotes[index]
                                                                  .color,
                                                          radius: 20,
                                                        ),
                                                        Image.asset(
                                                          quotes[index].image,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                    flex: 2,
                                                    fit: FlexFit.loose,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          quotes[index].title),
                                                    )),
                                                Flexible(
                                                  flex: 1,
                                                  fit: FlexFit.loose,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              quotes[index]
                                                                  .color,
                                                          radius: 20,
                                                        ),
                                                        Image.asset(
                                                          quotes1[index].image,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                    flex: 3,
                                                    fit: FlexFit.loose,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          quotes1[index].title),
                                                    ))
                                              ],
                                            ),
                                          )),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        //   scrollDirection: Axis.horizontal,
                                        itemCount: quotes.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 2, 8, 2),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black12)),
                                                child: Container(
                                                  height: height * 0.1,
                                                  color: Colors.white,
                                                  child: Row(
                                                    children: [
                                                      Flexible(
                                                        fit: FlexFit.loose,
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                    quotes[index]
                                                                        .color,
                                                                radius: 20,
                                                              ),
                                                              Image.asset(
                                                                quotes[index]
                                                                    .image,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                          flex: 2,
                                                          fit: FlexFit.loose,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                                quotes[index]
                                                                    .title),
                                                          )),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        //   scrollDirection: Axis.horizontal,
                                        itemCount: quotes.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 2, 8, 2),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black12)),
                                                child: Container(
                                                  height: height * 0.1,
                                                  color: Colors.white,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Flexible(
                                                        fit: FlexFit.loose,
                                                        flex: 1,
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundColor:
                                                                  quotes1[index]
                                                                      .color,
                                                              radius: 20,
                                                            ),
                                                            Image.asset(
                                                              quotes1[index]
                                                                  .image,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Flexible(
                                                          flex: 2,
                                                          fit: FlexFit.loose,
                                                          child: Text(
                                                              quotes1[index]
                                                                  .title)),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      width: width,
                      child: Image.asset(
                        'asset/sample3/bkEJue_2_.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$blockName7",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // ignore: deprecated_member_use
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                            height: 25,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.orange.shade700,
                                ),
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {},
                            child: Text(
                              "View All",
                              style: TextStyle(
                                color: Colors.orange.shade700,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: sampleBlock7.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    String image = sampleBlock7[index]["image"];
                    return Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: GestureDetector(
                        onTap: () {
                          String sku = sampleBlock7[index]["sku"];
                          String name = sampleBlock7[index]["name"];
                          String price = sampleBlock7[index]["price"];

                          print("Product Name: $sku,$name\nPrice:$price ");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          child: Container(
                            color: Colors.white,
                            width: width * 0.3,
                            height: height * 0.8,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: FavoriteButton(
                                          iconSize: 40,
                                          isFavorite: false,
                                          valueChanged: (_isFavorite) {},
                                        ),
                                        // child: Icon(
                                        //   Icons.favorite, size: 30,
                                        //   color: Color(0xFF707070),
                                        //   //  products1[index].icon,
                                        //   //    color: products1[index].color1,
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                      child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: ClipRect(
                                      child: Image.network(
                                        "$blockBaseUrl$image",
                                        // fit: BoxFit.fill,
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                  )),
                                ),
                                Positioned(
                                  bottom: 30,
                                  left: 10,
                                  right: 30,
                                  child: SizedBox(
                                    width: width * 0.3,
                                    child: Text(
                                      sampleBlock7[index]["name"],
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  right: 30,
                                  child: SizedBox(
                                    width: width * 0.3,
                                    child: Text(
                                      "QAR " + sampleBlock7[index]["price"],
                                      textAlign: TextAlign.left,
                                      softWrap: true,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange),
                                    ),
                                  ),
                                ),
                                /*Positioned(
                                          bottom: 0.0,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            color: Colors.red,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    sampleBlock2[index]["name"],
                                                    textAlign: TextAlign.center,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    sampleBlock2[index]["price"],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(0xFFF78500)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),*/
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                    /*Container(
                      //   decoration: BoxDecoration(
                      // border: Border.all(color: Colors.black12)),
                      child: GestureDetector(
                        onTap: () {
                          _selectedIndex = index;
                        },
                        child: Stack(
                          children: [
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Icon(
                                Icons.favorite,
                                /* products1[index].icon,
                                  color: _selectedIndex == index && color == false
                                      ? products1[index].color2
                                      : products1[index].color1*/
                              ),
                            ),
                            Center(
                                child: Image.network(
                              "$blockBaseUrl$image",
                              fit: BoxFit.fill,
                            )),
                            Positioned(
                                bottom: 20,
                                left: 20,
                                child: Text(
                                  sampleBlock7[index]["sku"],
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )),
                            Positioned(
                                bottom: 0,
                                left: 20,
                                child: Text(
                                  sampleBlock7[index]["price"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFF78500)),
                                )),
                          ],
                        ),
                      ),
                    );*/
                  },
                ),
              ),
            ]),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.blue.shade900,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(
                    'asset/navigation/Group 637.png',
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(
                    'asset/navigation/Group 637.png',
                  ),
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(
                    'asset/navigation/Group 639.png',
                  ),
                ),
                label: 'Enquire Now',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(
                    'asset/navigation/Group 641.png',
                  ),
                ),
                label: 'My Account',
              ),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(
                      'asset/navigation/Group 645.png',
                    ),
                  ),
                  label: 'MyCart'),
            ],
          ),
        ),
      ),
    );
  }
}

class Item3 extends StatelessWidget {
  const Item3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: brands.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0,
            childAspectRatio: MediaQuery.of(context).size.width /
                MediaQuery.of(context).size.height),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            //  color: Colors.white,
            child: InkWell(
                onTap: () {},
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            brands[index].image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            brands[index].title1,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.orange),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                brands[index].title2,
                                style: TextStyle(
                                  fontSize: 10,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ),
                            Text(
                              brands[index].title3,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
