import 'package:flutter/material.dart';
import 'dart:ui';

class EnquireNowScreen extends StatefulWidget {
  @override
  _EnquireNowScreenState createState() => _EnquireNowScreenState();
}

class _EnquireNowScreenState extends State<EnquireNowScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: Text(
              "Work In progress",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
