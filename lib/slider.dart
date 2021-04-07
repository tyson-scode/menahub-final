import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class Banner1 {
  final String bannerId;
  final String name;
  final String status;
  final String type;
  final String content;
  final String image;
  final String urlBanner;
  final String title;
  final String newtab;
  DateTime createdAt;
  DateTime updatedAt;
  final String mobileLinkId;
  final String mobileType;
  final String position;

  Banner1({
    this.bannerId,
    this.name,
    this.status,
    this.type,
    this.content,
    this.image,
    this.urlBanner,
    this.title,
    this.newtab,
    this.createdAt,
    this.updatedAt,
    this.mobileLinkId,
    this.mobileType,
    this.position,
  });

  factory Banner1.fromJson(Map<String, dynamic> json) {
    return Banner1(
      bannerId: json['banner_id'] as String,
      name: json['name'] as String,
      status: json['status'] as String,
      type: json['type'] as String,
      content: json['content'] as String,
      image: json['image'] as String,
      urlBanner: json['url_banner'] as String,
      title: json['title'] as String,
      newtab: json['newtab'] as String,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      mobileLinkId: json['mobile_link_id'] as String,
      mobileType: json['mobile_type'] as String,
      position: json['position'] as String,
    );
  }
  factory Banner1.toJson(Map<String, dynamic> json) {
    return Banner1(
      bannerId: json['banner_id'],
      name: json['name'],
      status: json['status'],
      type: json['type'],
      content: json['content'],
      image: json['image'],
      urlBanner: json['url_banner'],
      title: json['title'],
      newtab: json['newtab'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      mobileLinkId: json['mobile_link_id'],
      mobileType: json['mobile_type'],
      position: json['position'],
    );
  }
}
/*main() async {
  var dio = Dio();
  Response response = await dio.get(
      'https://magento2blog.thestagings.com/rest/default/V1/bannersliderblocks/1');
  print(response.data);
}*/

void main() => runApp(new MaterialApp(
      home: new MyApp(),
    ));

Future<List<Banner1>> fetchPhotos(http.Client client) async {
  print("api call");
  final response = await client.get(Uri.parse(
      'https://magento2blog.thestagings.com/rest/default/V1/bannersliderblocks/1'));
  print(response.body);
  List res = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return res.map<Banner1>((json) => Banner1.fromJson(json)).toList();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Banner1> banner1;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Call'),
      ),
      body: Column(
        children: [
          FutureBuilder<List<Banner1>>(
            future: fetchPhotos(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        pauseAutoPlayOnTouch: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      ),
                      items: <Widget>[
                        for (var i = 0; i < snapshot.data.length; i++)
                          Container(
                            child: Image.network(
                              'https://magento2blog.thestagings.com/pub/media/mageplaza/bannerslider/banner/image/' +
                                  snapshot.data[i].image,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      for (var i = 0; i < snapshot.data.length; i++)
                        Container(
                          width: 30.0,
                          height: 5.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            shape: BoxShape.rectangle,
                            color: selectedIndex == i
                                ? Colors.orange.shade700
                                : Colors.black12,
                          ),
                        )
                    ])
                  ],
                );
              } else if (snapshot.hasError) {
                /*  return Text(
                    '${snapshot.error}',

  0            );*/
                print("  '${snapshot.error}'");
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
