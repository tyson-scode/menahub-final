import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget appButton(
    {BuildContext context,
    String title,
    String icons,
    String backgroundColor,
    onpress}) {
  return Padding(
    padding: EdgeInsets.only(left: 50.0, right: 50.0),
    child: Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      // ignore: deprecated_member_use
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: HexColor(backgroundColor),
        onPressed: onpress,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  icons,
                  height: 25.0,
                  width: 25.0,
                ),
                Container(
                  width: 20.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
