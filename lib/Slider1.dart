import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:http/http.dart' as http;

void main() => runApp(new MaterialApp(
      home: new TestingApi(),
    ));

class TestingApi extends StatefulWidget {
  @override
  _TestingApiState createState() => _TestingApiState();
}

class _TestingApiState extends State<TestingApi> {
  List<String> sliderList1 = [];
  String imageBaseUrl =
      "https://magento2blog.thestagings.com/pub/media/mageplaza/bannerslider/banner/image/";
  @override
  void initState() {
    super.initState();
    getSlider();
  }

  getSlider() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    http.Response response = await http.get(
      Uri.parse(
          "https://magento2blog.thestagings.com/rest/default/V1/bannersliderblocks/1"),
      headers: headers,
    );
    if (response.statusCode == 200) {
      List sliderData1 = json.decode(response.body);
      for (Map item in sliderData1) {
        sliderList1.add(item["image"]);
      }
      setState(() {
        sliderList1 = sliderList1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //banner
              CarouselSlider(
                items: sliderList1
                    .map((item) => Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            child: Image.network("$imageBaseUrl$item",
                                fit: BoxFit.fill, width: 1000.0),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  pageSnapping: true,
                  autoPlay: true,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
