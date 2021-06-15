import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/StaticFunction.dart';
import 'package:menahub/translation/codegen_loader.g.dart';
import 'package:menahub/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

Widget customTextBox({
  BuildContext context,
  bool enabled = true,
  String hintText,
  String icons,
  String backgroundColor,
  TextEditingController controller,
  String errorMessage,
  bool passwordField = false,
  bool confirmpasswordfield = false,
  bool emailField = false,
  bool passwordfield = false,
  bool signinpasswordField = false,
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
                enabled: enabled,
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
                  errorMaxLines: 4,
                ),
                validator: (value) {
                  if (passwordField) {
                    if (value.isEmpty) {
                      return LocaleKeys.valid_password.tr();
                    }
                    if (value.length < 6) {
                      return LocaleKeys.valid_password1.tr();
                    }
                    // else if (value.isNotEmpty) {
                    //   final validatepassword =
                    //       passwordvalidation(password: value);
                    //   if (validatepassword != true) {
                    //     return 'Password must have at least one uppercase, one lowercase, one digit(0-9), one special character';
                    //   }
                    // }
                  }
                  if (emailField) {
                    if (value.isEmpty) {
                      return LocaleKeys.valid_email1.tr();
                    } else if (value.isNotEmpty) {
                      final validyEmail = emailvalidation(email: value);
                      // ignore: unrelated_type_equality_checks
                      if (validyEmail != true) {
                        return LocaleKeys.valid_email.tr();
                      }
                    }
                    return null;
                  } else {
                    if (value.isEmpty) {
                      return LocaleKeys.enter.tr() + ' $hintText';
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

Widget customTextBox1({
  BuildContext context,
  String hintText,
  String icons,
  String backgroundColor,
  TextEditingController controller,
  String errorMessage,
  bool passwordField = false,
  bool confirmpasswordfield = false,
  bool emailField = false,
  bool passwordfield = false,
  bool signinpasswordField = false,
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
                  errorMaxLines: 4,
                ),
                validator: (value) {
                  if (passwordField) {
                    if (value.isEmpty) {
                      return LocaleKeys.valid_password.tr();
                    }

                    return null;
                  }
                  return null;
                },
              ),
            )
          ],
        ),
      ),
    ),
  );
}
