import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MaterialApp(
      home: new menu(),
    ));

class menu extends StatefulWidget {
  @override
  _menuState createState() => _menuState();
}
class _menuState extends State<menu> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: height / 5,
                    width: width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: <Color>[
                      const Color(0xFF103D52),
                      const Color(0xFF103D52),
                      const Color(0xFF103D52),
                      const Color(0xFF103D52),
                    ])),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ClipRect(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        height: 110,
                        width: 110,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 20, 20, 20),
                            child: Image(
                              image: AssetImage('asset/user.png'),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 140,
                    top: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 6, left: 4),
                          child: Text(
                            'Hello Mohammeds',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6, left: 4),
                          child: Text(
                            'Mohammed23@gmail.com',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6, left: 4),
                          child: Text(
                            '+966 50 6547733',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('All Orders'),
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            size: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Divider(
                            height: 1,
                            thickness: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                            'asset/orderlist/quote.png',
                                          ),
                                          height: 25,
                                          width: 25,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Text(
                                            'Quote Request',
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'asset/orderlist/invoice.png'),
                                          height: 25,
                                          width: 25,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Text(
                                            'Order',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'asset/orderlist/error.png'),
                                          height: 25,
                                          width: 25,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Text(
                                            'Unpaid',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'asset/orderlist/exchange.png'),
                                          height: 25,
                                          width: 25,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Text(
                                            'Returns',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'asset/orderlist/review.png'),
                                          height: 25,
                                          width: 25,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Text(
                                            'Reviews',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.favorite_border,
                        size: 30,
                      ),
                      title: Transform(
                          transform: Matrix4.translationValues(-16, 0.0, 0.0),
                          child: Text('My Wishlist')),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        size: 30,
                      ),
                    ),
                    Divider(
                      height: 10,
                      thickness: 2,
                    ),
                    ListTile(
                      leading: Image(
                        image: AssetImage('asset/List/notebook.png'),
                      ),
                      title: Transform(
                          transform: Matrix4.translationValues(-16, 0.0, 0.0),
                          child: Text('Address Book')),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        size: 30,
                      ),
                    ),
                    Divider(
                      height: 10,
                      thickness: 2,
                    ),
                    ListTile(
                      leading: Image(
                        image: AssetImage('asset/List/credit-card.png'),
                      ),
                      title: Transform(
                          transform: Matrix4.translationValues(-16, 0.0, 0.0),
                          child: Text('Saved Cards')),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        size: 30,
                      ),
                    ),
                    Divider(
                      height: 10,
                      thickness: 2,
                    ),
                    ListTile(
                      leading: Image(
                        image: AssetImage('asset/List/resume.png'),
                      ),
                      title: Transform(
                          transform: Matrix4.translationValues(-16, 0.0, 0.0),
                          child: Text('Profile Details')),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      leading: Image(
                        image: AssetImage('asset/List/germany.png'),
                      ),
                      title: Transform(
                          transform: Matrix4.translationValues(-16, 0.0, 0.0),
                          child: Text('Country')),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        size: 30,
                      ),
                    ),
                    Divider(
                      height: 10,
                      thickness: 2,
                    ),
                    Container(
                      child: ListTile(
                        leading: Icon(
                          Icons.favorite,
                          color: Colors.black,
                          size: 30,
                        ),
                        title: Transform(
                            transform: Matrix4.translationValues(-16, 0.0, 0.0),
                            child: Text('Language')),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          size: 30,
                        ),
                      ),
                    ),
                    Divider(
                      height: 10,
                      thickness: 2,
                    ),
                    ListTile(
                      leading: Image(
                        image: AssetImage('asset/List/registration.png'),
                      ),
                      title: Transform(
                          transform: Matrix4.translationValues(-16, 0.0, 0.0),
                          child: Text('Seller Registration')),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: height / 15,
                width: width,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Image(
                        image: AssetImage(
                            'asset/Socialmedia/facebook-circular-logo.png'),
                      ),
                    ),
                    ClipOval(
                      child: Image(
                        image: AssetImage('asset/Socialmedia/instagram.png'),
                      ),
                    ),
                    ClipOval(
                      child: Image(
                        image: AssetImage('asset/Socialmedia/twitter.png'),
                      ),
                    ),
                    ClipOval(
                      child: Image(
                        image: AssetImage('asset/Socialmedia/linkedin.png'),
                      ),
                    ),
                    ClipOval(
                      child: Image(
                        image: AssetImage('asset/Socialmedia/snapchat.png'),
                      ),
                    ),
                    ClipOval(
                      child: Image(
                        image: AssetImage('asset/Socialmedia/google-plus.png'),
                      ),
                    ),
                    ClipOval(
                      child: Image(
                        image: AssetImage('asset/Socialmedia/youtube.png'),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('FAQ'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Contact US'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('About Us'),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text('App Version 4.2101.5'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
