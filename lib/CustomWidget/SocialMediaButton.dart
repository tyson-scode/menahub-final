import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget socialMediaButton({Color backgroundColor, socialMediaIcon}) {
  return Container(
    decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
    child: Padding(padding: const EdgeInsets.all(20.0), child: socialMediaIcon),
  );
}
