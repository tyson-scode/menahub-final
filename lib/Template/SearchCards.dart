import 'package:flutter/material.dart';

class SearchCards extends StatefulWidget {
  @override
  _SearchCardsState createState() => _SearchCardsState();
}

class _SearchCardsState extends State<SearchCards> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 5.5,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              child: Image.asset(
                "assets/beer.jpeg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            left: 10.0,
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Row(
                children: <Widget>[
                  Text(
                    " Beer ",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
