import 'package:flutter/material.dart';
import 'package:menahub/Address/SelectAddressScreen.dart';
import 'package:menahub/DashBoard/MyAccountScreen/UpdateProfile.dart';
import 'package:menahub/MyOrdersScreen/MyOrdersScreen.dart';
import 'package:menahub/MyWishlist/MyWishlistScreen.dart';
import 'package:menahub/SignIn_SignUp_Flow/LanguageSelectScreen.dart';
import 'package:menahub/SignIn_SignUp_Flow/ResetPassword.dart';
import 'package:menahub/SignIn_SignUp_Flow/SignInScreen/SignInScreen.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/config/AppLoader.dart';
import 'package:menahub/config/CustomDialogBox%20.dart';
import 'package:menahub/config/CustomLoader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:menahub/DashBoard/MyAccountScreen/ChooseCountryScreen.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  Map accountDetails;
  String mobileNumber;
  String countryCode;
  String userType;

  @override
  void initState() {
    super.initState();
    getValues();
  }

  onGoBack(dynamic value) {
    setValues(value);
    setState(() {});
  }

  getValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userType = prefs.getString("userType");
    if (userType == "guest") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => SignIn(),
        ),
      );
    } else {
      var token = prefs.get("token");
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token"
      };
      ApiResponseModel responseData = await getApiCall(
        getUrl: myAccountUrl,
        headers: headers,
        context: context,
      );
      if (responseData.statusCode == 200) {
        Map data = responseData.responseValue;
        List customAttributes = data["custom_attributes"];
        Map extensionAttributes = data["extension_attributes"];

        int mobilenumberIndex = customAttributes
            .indexWhere((f) => f['attribute_code'] == "mobilenumber");
        int mobilenumberCodeIndex = customAttributes
            .indexWhere((f) => f['attribute_code'] == "mobilenumber_code");
        Map mobilenumberIndexMap = customAttributes[mobilenumberIndex];
        Map mobilenumberCodeIndexMap = customAttributes[mobilenumberCodeIndex];
        setState(() {
          accountDetails = data;
          mobileNumber = mobilenumberIndexMap["value"];
          countryCode = mobilenumberCodeIndexMap["value"];
          print("GET PROFILE");
          print("Account Details = $accountDetails");
          print("extensionAttributes Details = $extensionAttributes");
        });
      } else {
        print(responseData);
      }
    }
  }

  setValues(value) async {
    final overlay = LoadingOverlay.of(context);
    overlay.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userType = prefs.getString("userType");
    if (userType == "guest") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => SignIn(),
        ),
      );
    } else {
      var token = prefs.get("token");
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token"
      };
      ApiResponseModel responseData = await getApiCall(
        getUrl: myAccountUrl,
        headers: headers,
        context: context,
      );
      if (responseData.statusCode == 200) {
        overlay.hide();

        Map data = responseData.responseValue;
        List customAttributes = data["custom_attributes"];
        int mobilenumberIndex = customAttributes
            .indexWhere((f) => f['attribute_code'] == "mobilenumber");
        int mobilenumberCodeIndex = customAttributes
            .indexWhere((f) => f['attribute_code'] == "mobilenumber_code");
        Map mobilenumberIndexMap = customAttributes[mobilenumberIndex];
        Map mobilenumberCodeIndexMap = customAttributes[mobilenumberCodeIndex];
        setState(() {
          accountDetails = data;
          mobileNumber = mobilenumberIndexMap["value"];
          countryCode = mobilenumberCodeIndexMap["value"];
        });
      } else {
        print(responseData);
        overlay.hide();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: userType == "guest"
            ? guestUser(context: context)
            : accountDetails == null
                ? Center(
                    child: CustomerLoader(
                      dotType: DotType.circle,
                      dotOneColor: secondaryColor,
                      dotTwoColor: primaryColor,
                      dotThreeColor: Colors.red,
                      duration: Duration(milliseconds: 1000),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                const Color(0xFF103D52),
                                const Color(0xFF103D52),
                                const Color(0xFF103D52),
                                const Color(0xFF103D52),
                              ],
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 20,
                                  bottom: 20,
                                ),
                                child: ClipRect(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white,
                                    ),
                                    height: 100,
                                    width: 100,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            25, 20, 20, 20),
                                        child: Image(
                                          image: AssetImage('assets/user.png'),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '${accountDetails["firstname"]} ${accountDetails["lastname"]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  sizedBoxheight5,
                                  Text(
                                    accountDetails["email"].toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  sizedBoxheight5,
                                  Text(
                                    '$countryCode $mobileNumber',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  )
                                ],
                              ),
                            ],
                          ),
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
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MyOrdersScreen(),
                                        ),
                                      );
                                    },
                                    title: Text('All Orders'),
                                    trailing: Icon(
                                      Icons.keyboard_arrow_right,
                                      size: 30,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Divider(
                                      height: 1,
                                      thickness: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyOrdersScreen(
                                                      searchIndex: 1,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Image(
                                                      image: AssetImage(
                                                        'assets/orderlist/quote.png',
                                                      ),
                                                      height: 25,
                                                      width: 25,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8),
                                                      child: Text(
                                                        'Quote Request',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyOrdersScreen(
                                                      searchIndex: 2,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Image(
                                                      image: AssetImage(
                                                          'assets/orderlist/invoice.png'),
                                                      height: 25,
                                                      width: 25,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8),
                                                      child: Text(
                                                        'Order',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyOrdersScreen(
                                                      searchIndex: 3,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Image(
                                                      image: AssetImage(
                                                          'assets/orderlist/error.png'),
                                                      height: 25,
                                                      width: 25,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8),
                                                      child: Text(
                                                        'Unpaid',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyOrdersScreen(
                                                      searchIndex: 4,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Image(
                                                      image: AssetImage(
                                                          'assets/orderlist/exchange.png'),
                                                      height: 25,
                                                      width: 25,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8),
                                                      child: Text(
                                                        'Returns',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyWishlistScreen(),
                                    ),
                                  );
                                },
                                leading: Icon(
                                  Icons.favorite_border,
                                  size: 30,
                                ),
                                title: Transform(
                                    transform: Matrix4.translationValues(
                                        -16, 0.0, 0.0),
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
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SelectAddressScreen(
                                        router: "account",
                                      ),
                                    ),
                                  );
                                },
                                leading: Image(
                                  image: AssetImage('assets/List/notebook.png'),
                                ),
                                title: Transform(
                                    transform: Matrix4.translationValues(
                                        -16, 0.0, 0.0),
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
                                  image: AssetImage('assets/List/resume.png'),
                                ),
                                title: Transform(
                                    transform: Matrix4.translationValues(
                                        -16, 0.0, 0.0),
                                    child: Text('Profile Details')),
                                trailing: Icon(
                                  Icons.keyboard_arrow_right,
                                  size: 30,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateProfile(
                                        userProfile: accountDetails,
                                      ),
                                    ),
                                  ).then(onGoBack);
                                },
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
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChooseCountryScreen(),
                                    ),
                                  );
                                },
                                leading: Image(
                                  image: AssetImage('assets/List/germany.png'),
                                ),
                                title: Transform(
                                    transform: Matrix4.translationValues(
                                        -16, 0.0, 0.0),
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
                              ListTile(
                                leading: Icon(
                                  Icons.reset_tv,
                                ),
                                title: Transform(
                                    transform: Matrix4.translationValues(
                                        -16, 0.0, 0.0),
                                    child: Text('Reset Password')),
                                trailing: Icon(
                                  Icons.keyboard_arrow_right,
                                  size: 30,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResetPassword(
                                        router: "Account",
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Divider(
                                height: 10,
                                thickness: 2,
                              ),
                              Container(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            LanguageSelectScreen(
                                          router: "account",
                                        ),
                                      ),
                                    );
                                  },
                                  leading: Icon(
                                    Icons.favorite,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  title: Transform(
                                      transform: Matrix4.translationValues(
                                          -16, 0.0, 0.0),
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
                                leading: Icon(Icons.logout),
                                title: Transform(
                                    transform: Matrix4.translationValues(
                                        -16, 0.0, 0.0),
                                    child: Text('Logout')),
                                trailing: Icon(
                                  Icons.keyboard_arrow_right,
                                  size: 30,
                                ),
                                onTap: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.clear();
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SignIn(),
                                    ),
                                  );
                                },
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
                                      'assets/Socialmedia/facebook-circular-logo.png'),
                                ),
                              ),
                              ClipOval(
                                child: Image(
                                  image: AssetImage(
                                      'assets/Socialmedia/instagram.png'),
                                ),
                              ),
                              ClipOval(
                                child: Image(
                                  image: AssetImage(
                                      'assets/Socialmedia/twitter.png'),
                                ),
                              ),
                              ClipOval(
                                child: Image(
                                  image: AssetImage(
                                      'assets/Socialmedia/linkedin.png'),
                                ),
                              ),
                              ClipOval(
                                child: Image(
                                  image: AssetImage(
                                      'assets/Socialmedia/snapchat.png'),
                                ),
                              ),
                              ClipOval(
                                child: Image(
                                  image: AssetImage(
                                      'assets/Socialmedia/google-plus.png'),
                                ),
                              ),
                              ClipOval(
                                child: Image(
                                  image: AssetImage(
                                      'assets/Socialmedia/youtube.png'),
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
