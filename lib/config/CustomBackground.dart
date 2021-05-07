import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  CustomBackground({this.backgroundColor, this.imageColor});
  final Color backgroundColor;
  final Color imageColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/image/topDesign.png",
                height: 150,
                width: 150,
                color: imageColor,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                "assets/image/bottomDesign.png",
                height: 150,
                width: 150,
                color: imageColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
