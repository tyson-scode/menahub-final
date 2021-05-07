import 'package:flutter/material.dart';
import 'package:menahub/Util/ConstantData.dart';

Widget customErrorText(String errorText) {
  return Text(
    errorText,
    style: TextStyle(
      color: redColor,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  );
}
