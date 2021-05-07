import 'package:flutter/material.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/StaticFunction.dart';

Widget customTextBox({
  BuildContext context,
  String hintText,
  String icons,
  String backgroundColor,
  TextEditingController controller,
  String errorMessage,
  bool passwordField = false,
  bool confirmpasswordfield = false,
  bool emailField = false,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
    ),
    elevation: 2,
    child: Container(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          children: [
            Image.asset(
              icons,
              height: 30,
              width: 30,
            ),
            Expanded(
              child: TextFormField(
                controller: controller,
                obscureText: passwordField,
                keyboardType: keyboardType,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15, right: 15),
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: greyColor,
                  ),
                ),
                validator: (value) {
                  if (emailField) {
                    if (value.isEmpty) {
                      return 'Please enter Email';
                    } else if (value.isNotEmpty) {
                      final validyEmail = emailvalidation(email: value);
                      // ignore: unrelated_type_equality_checks
                      if (validyEmail != true) {
                        return 'Please enter valid Email';
                      }
                    }
                    return null;
                  } else {
                    if (value.isEmpty) {
                      return 'Please enter $hintText';
                    }

                    return null;
                  }
                },
              ),
            )
          ],
        ),
      ),
    ),
  );
}