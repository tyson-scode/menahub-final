import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  ProductItem({
    Key key,
    @required this.img,
    @required this.title,
    @required this.address,
    @required this.rating,
    imgs,
  }) : super(key: key);

  final String address;
  final String img;
  final String rating;
  final String title;

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                    height: 230,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                        image: AssetImage("assets/roles.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: null),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 20,
                        color: Colors.yellow,
                      ),
                      Text("5")
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.cake,
                            color: Colors.red,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Colors.red,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("16.99",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w700)),
                  Text("KIM CRAWFORD SAUV BLANC 3-25",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  Text("750 ML(Standard)",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
