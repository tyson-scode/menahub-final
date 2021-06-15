import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:menahub/CustomWidget/CustomButton.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/config/AppLoader.dart';
import 'package:menahub/config/CustomLoader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:menahub/translation/codegen_loader.g.dart';
import 'package:menahub/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class EditAddressScreen extends StatefulWidget {
  EditAddressScreen({this.router, this.addressdetails, this.addressID});
  final String router;
  final List addressdetails;
  int addressID;

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  TextEditingController form1addressTitleTextField1 = TextEditingController();
  TextEditingController form1nameTextField1 = TextEditingController();
  TextEditingController form1companyNameTextField1 = TextEditingController();
  TextEditingController form1emailTextField1 = TextEditingController();
  TextEditingController form1mobileNumberTextField1 = TextEditingController();
  TextEditingController form1buildingNumberTextField1 = TextEditingController();
  TextEditingController form1streetNumberTextField1 = TextEditingController();
  TextEditingController form1zoneNumberTextField1 = TextEditingController();
  TextEditingController form1cityTextField1 = TextEditingController();
  TextEditingController form2addressTitleTextField2 = TextEditingController();
  TextEditingController form2nameTextField2 = TextEditingController();
  TextEditingController form2companyNameTextField2 = TextEditingController();
  TextEditingController form2emailTextField2 = TextEditingController();
  TextEditingController form2mobileNumberTextField2 = TextEditingController();
  TextEditingController form2buildingNumberTextField2 = TextEditingController();
  TextEditingController form2streetNumberTextField2 = TextEditingController();
  TextEditingController form2zoneNumberTextField2 = TextEditingController();
  TextEditingController form2cityTextField2 = TextEditingController();
  bool _form1address = false;
  bool _form1name = false;
  bool _form1company = false;
  bool _form1email = false;
  bool _form1mobile = false;
  bool _form1countrycode = false;

  bool _form1buildingno = false;
  bool _form1street = false;
  bool _form1zoneno = false;
  bool _form1city = false;
  bool _form1country = false;
  bool _form1region = false;

  bool _form2address = false;
  bool _form2name = false;
  bool _form2company = false;
  bool _form2email = false;
  bool _form2mobile = false;
  bool _form2buildingno = false;
  bool _form2street = false;
  bool _form2zoneno = false;
  bool _form2city = false;
  bool _form2country = false;
  String addressID;
  String customerID;
  List storecofigdetails;
  Map countrydetails;
  Map regiondetails;
  List region_QA;
  List region_IN;
  List region_AE;
  List<Map> _QA = [
    {'id': 'QA', "image": "assets/image/flag-of-Qatar.png", 'name': 'QATAR'},
  ];
  List<Map> _IN = [
    {'id': "IN", "image": "assets/image/india.png", 'name': 'INDIA'},
  ];
  List<Map> _AE = [
    {
      'id': "AE",
      "image": "assets/image/flag-of-United-Arab-Emirates.png",
      'name': 'UAE'
    },
  ];
  // ignore: non_constant_identifier_names
  final FocusNode Form1mobile = FocusNode();
  // ignore: non_constant_identifier_names
  final FocusNode Form1country = FocusNode();
  // ignore: non_constant_identifier_names
  final FocusNode Form2mobile = FocusNode();
  // ignore: non_constant_identifier_names
  final FocusNode Form2country = FocusNode();
  //variable
  bool form1addressType = true;
  bool form2addressType = true;

  //user profile details from api
  Map accountDetails;
  String userType;

  @override
  void initState() {
    super.initState();
    getProfileDetails();
    getStoreConfigDetails();
    setState(() {
      addressID = widget.addressdetails[widget.addressID]["id"].toString();
      customerID =
          widget.addressdetails[widget.addressID]["customer_id"].toString();
      List customAttributes =
          widget.addressdetails[widget.addressID]["custom_attributes"];
      int addresstitleIndex = customAttributes
          .indexWhere((f) => f['attribute_code'] == "addresscategory");

      Map addresstitleIndexMap = customAttributes[addresstitleIndex];
      String addresstitle = addresstitleIndexMap["value"];

      form1addressTitleTextField1.text = addresstitle.toString();
      _form1regionselection =
          widget.addressdetails[widget.addressID]["region_id"].toString();
      _form1countryselection =
          widget.addressdetails[widget.addressID]["country_id"].toString();

      String mob =
          widget.addressdetails[widget.addressID]["telephone"].toString();
      form1mobileNumberTextField1.text = '${mob.split(" ")[1]}'.toString();

      form1cityTextField1.text =
          widget.addressdetails[widget.addressID]["city"].toString();
      form1nameTextField1.text =
          widget.addressdetails[widget.addressID]["firstname"].toString();
      form1streetNumberTextField1.text =
          widget.addressdetails[widget.addressID]["street"][1].toString();
      form1buildingNumberTextField1.text =
          widget.addressdetails[widget.addressID]["street"][0].toString();
      form1zoneNumberTextField1.text =
          widget.addressdetails[widget.addressID]["postcode"].toString();
      String company =
          widget.addressdetails[widget.addressID]["company"].toString();
      String empty = " ";
      form1companyNameTextField1.text =
          company == null ? empty.toString() : company.toString();
    });
  }

  getStoreConfigDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    ApiResponseModel responseData = await getApiCall(
      getUrl: storecofig,
      headers: headers,
      context: context,
    );
    if (responseData.statusCode == 200) {
      storecofigdetails = responseData.responseValue;
      setState(() {
        countrydetails = storecofigdetails[0]["store"][0]["countries"];
        regiondetails = storecofigdetails[0]["store"][0]["region"];
        region_IN = regiondetails["IN"];
        // print('Indian =$region_IN');
        Map ind = region_IN.removeAt(0);

        // print("ind=$ind");
        // print("removed=$region_IN");
        region_QA = regiondetails["QA"];
        Map qa = region_QA.removeAt(0);
        region_AE = regiondetails["AE"];
        print(region_QA);
        print(region_IN);
        region = region_IN + region_QA + region_AE;
      });
    } else {
      print(responseData);
    }
  }

  getProfileDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
      int mobilenumberIndex = customAttributes
          .indexWhere((f) => f['attribute_code'] == "mobilenumber");
      int mobilenumberCodeIndex = customAttributes
          .indexWhere((f) => f['attribute_code'] == "mobilenumber_code");
      Map mobilenumberIndexMap = customAttributes[mobilenumberIndex];
      Map mobilenumberCodeIndexMap = customAttributes[mobilenumberCodeIndex];
      String mobileNumber = mobilenumberIndexMap["value"];
      String mobileNumbercode = mobilenumberCodeIndexMap["value"];

      // print(data);
      setState(() {
        accountDetails = data;
        // print('account = $accountDetails');
        Map mobileNumberMap = customAttributes[2];
        Map countryCodeMap = customAttributes[3];
        countryCode = countryCodeMap["value"];
        // print("mobileNumber  = $mobileNumber");
        // print("mobileNumber code = $mobileNumbercode");
        String mob =
            widget.addressdetails[widget.addressID]["telephone"].toString();
        countryCode = '${mob.split(" ")[0]}';
        form1emailTextField1.text = data["email"];

        // form1nameTextField1.text = data["firstname"];
      });
    } else {
      print(responseData);
    }
  }

  updateAddress(String customerID, String addressID) async {
    final overlay = LoadingOverlay.of(context);
    overlay.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    var body = jsonEncode({
      "address": {
        "id": addressID,
        "customer_id": customerID,
        "region": {
          "region_code": "Doha",
          "region": "Doha",
          "region_id": _form1regionselection,
        },
        "region_id": _form1regionselection,
        "country_id": _form1countryselection,
        "street": [
          form1streetNumberTextField1.text,
          form1buildingNumberTextField1.text
        ],
        "custom_attributes": [
          {
            "attribute_code": "addresscategory",
            "value": form1addressTitleTextField1.text
          },
          {"attribute_code": "landmark", "value": "NEAR LAKE"},
          {"attribute_code": "latitude", "value": "182.122"},
          {"attribute_code": "longitude", "value": "2496.536"}
        ],
        "company":
            form1addressType == false ? form1companyNameTextField1.text : "",
        "telephone":
            countryCode.toString() + " " + form1mobileNumberTextField1.text,
        "postcode": form1zoneNumberTextField1.text,
        "city": form1cityTextField1.text,
        "firstname": form1nameTextField1.text,
        "lastname": accountDetails["lastname"],
        "default_shipping": true,
        "default_billing": true
      }
    });
    ApiResponseModel responseData = await putApiCall(
      postUrl: "$addressSaveApi",
      headers: headers,
      context: context,
      body: body,
    );
    print(responseData.responseValue);
    if (responseData.statusCode == 200) {
      overlay.hide();
      Navigator.of(context).maybePop();
    } else {
      overlay.hide();
      Navigator.of(context).maybePop();
    }
  }

  List<Map> _myJson = [
    {'id': 'QA', "image": "assets/image/flag-of-Qatar.png", 'name': 'QATAR'},
    {
      'id': "AE",
      "image": "assets/image/flag-of-United-Arab-Emirates.png",
      'name': 'UAE'
    },
    {'id': "IN", "image": "assets/image/india.png", 'name': 'INDIA'},
  ];

  String _form1countryselection;
  String _form1regionselection;
  String countryCode;

  List region;

  String _form2countryselection;

  bool _isFavorited2 = false;
  bool billaddressdif = false;
  bool setdefault = false;
  bool locateme = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey2 = GlobalKey<FormState>();

  void _form1toggleFavorite() {
    setState(() {
      form1addressType = true;
    });
  }

  void _form1toggleFavorite1() {
    setState(() {
      form1addressType = false;
    });
  }

  void _form2toggleFavorite() {
    setState(() {
      form2addressType = true;
    });
  }

  void _form2toggleFavorite1() {
    setState(() {
      form2addressType = false;
    });
  }

  void _toggleFavorite2() {
    setState(() {
      _isFavorited2 = _isFavorited2 == false ? true : false;
      if (billaddressdif) {
        billaddressdif = false;
      } else {
        billaddressdif = true;
      }
    });
  }

  String dropval = '';
  void dropChange(String val) {}

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: Locale(context.locale.languageCode),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(LocaleKeys.Edit_Address.tr()),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
              const Color(0xFF02161F),
              const Color(0xFF0B3B52),
              const Color(0xFF103D52),
              const Color(0xFF304C58),
            ])),
          ),
        ),
        body: accountDetails == null
            ? Center(
                child: CustomerLoader(
                  dotType: DotType.circle,
                  dotOneColor: secondaryColor,
                  dotTwoColor: primaryColor,
                  dotThreeColor: Colors.red,
                  duration: Duration(milliseconds: 1000),
                ),
              )
            : GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Visibility(
                        // visible: billaddressdif == false ? true : false,
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _formkey,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    LocaleKeys.Shipping_Address.tr(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: ButtonTheme(
                                    height: 20,
                                    minWidth: 1,
                                    // ignore: deprecated_member_use
                                    child: RaisedButton(
                                      // borderSide: BorderSide(color: Colors.black),

                                      color: setdefault == true
                                          ? Color(0xFFF78500)
                                          : Color(0xFFFFFFFF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        side: BorderSide(
                                          color: setdefault == true
                                              ? Color(0xFFF78500)
                                              : Color(0xFF666666),
                                        ),
                                      ),
                                      child: Text(
                                        LocaleKeys.default_set.tr(),
                                        style: TextStyle(
                                            color: setdefault == true
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          setdefault = setdefault == false
                                              ? true
                                              : false;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 0, 10, 0),
                                child: Row(
                                  children: [
                                    ButtonTheme(
                                      height: 20,
                                      // ignore: deprecated_member_use
                                      child: RaisedButton.icon(
                                        icon: Icon(Icons.location_on,
                                            size: 15,
                                            color: locateme == true
                                                ? Colors.white
                                                : Colors.black),
                                        color: locateme == true
                                            ? Color(0xFFF78500)
                                            : Color(0xFFFFFFFF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                          side: BorderSide(
                                            color: locateme == true
                                                ? Color(0xFFF78500)
                                                : Color(0xFF666666),
                                          ),
                                        ),
                                        onPressed: () async {
                                          LocationResult result =
                                              await showLocationPicker(
                                            context,
                                            "AIzaSyBfKeIAyqhi4J7PVR9Rua7XXLsYJKuyQyI",
                                            automaticallyAnimateToCurrentLocation:
                                                true,
                                            myLocationButtonEnabled: true,
                                            requiredGPS: true,
                                            layersButtonEnabled: true,
                                            resultCardAlignment:
                                                Alignment.bottomCenter,
                                            desiredAccuracy:
                                                LocationAccuracy.best,
                                          );
                                          print("result = $result");
                                          // setState(() {
                                          // _pickedLocation = result;
                                          // print(_pickedLocation);
                                          // });
                                          // setState(() {
                                          //   locateme =
                                          //       locateme == false ? true : false;
                                          // });
                                        },
                                        label: Text(
                                          LocaleKeys.Locate_Me.tr(),
                                          style: TextStyle(
                                              color: locateme == true
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Form(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            25, 5, 25, 0),
                                        child: TextFormField(
                                          controller:
                                              form1addressTitleTextField1,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              _form1address = true;
                                            }
                                            return null;
                                          },
                                          textInputAction: TextInputAction.done,
                                          // onEditingComplete: () =>
                                          //     FocusScope.of(context)
                                          //         .requestFocus(email),
                                          // onFieldSubmitted: (_) =>
                                          //     FocusScope.of(context)
                                          //         .requestFocus(email),
                                          onChanged: (value) {
                                            setState(() {
                                              _form1address = false;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF0D3451))),
                                            hintText:
                                                LocaleKeys.Address_Title.tr(),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Visibility(
                                              visible: _form1address == true
                                                  ? true
                                                  : false,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 40, 0),
                                                child: Text(
                                                  LocaleKeys.Valid_title.tr(),
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              )),
                                        ],
                                      ),
                                      InkWell(
                                        radius: 25.0,
                                        onTap: () {
                                          setState(() {
                                            form1addressType = false;
                                          });
                                        },
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                25, 15, 25, 0),
                                            child: Row(
                                              children: [
                                                Text(LocaleKeys.Address_Type
                                                    .tr()),
                                                Flexible(
                                                  flex: 1,
                                                  child: IconButton(
                                                    icon: (form1addressType
                                                        ? Icon(Icons
                                                            .check_circle_outline)
                                                        : Icon(Icons
                                                            .radio_button_off)),
                                                    color: Colors.orange,
                                                    onPressed:
                                                        _form1toggleFavorite,
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 1,
                                                  child: Transform(
                                                    transform: Matrix4
                                                        .translationValues(
                                                            -8, 0.0, 0.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          form1addressType =
                                                              true;
                                                        });
                                                      },
                                                      child: Text(
                                                        LocaleKeys.home.tr(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 1,
                                                  child: IconButton(
                                                    icon: (form1addressType
                                                        ? Icon(Icons
                                                            .radio_button_off)
                                                        : Icon(Icons
                                                            .check_circle_outline)),
                                                    color: Colors.orange,
                                                    onPressed:
                                                        _form1toggleFavorite1,
                                                  ),
                                                ),
                                                Flexible(
                                                    flex: 1,
                                                    child: Transform(
                                                        transform: Matrix4
                                                            .translationValues(
                                                                -8, 0.0, 0.0),
                                                        child: Text(LocaleKeys
                                                            .Work.tr()))),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            25, 5, 25, 0),
                                        child: TextFormField(
                                          controller: form1nameTextField1,
                                          textInputAction: TextInputAction.done,
                                          onEditingComplete: () =>
                                              node.nextFocus(),
                                          // onFieldSubmitted: (_) => node.unfocus(),
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              _form1name = true;
                                              return;
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              _form1name = false;
                                              // Resets the error
                                            });
                                          },
                                          decoration: InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF0D3451))),
                                            hintText: LocaleKeys.name.tr(),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Visibility(
                                              visible: _form1name == true
                                                  ? true
                                                  : false,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 40, 0),
                                                child: Text(
                                                  LocaleKeys.valid_Name.tr(),
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              )),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            25, 5, 25, 0),
                                        child: Visibility(
                                          visible: form1addressType == false,
                                          child: TextFormField(
                                            controller:
                                                form1companyNameTextField1,
                                            textInputAction:
                                                TextInputAction.done,
                                            onEditingComplete: () =>
                                                node.nextFocus(),
                                            // onFieldSubmitted: (_) => node.unfocus(),
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                _form1company = true;
                                                return;
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                _form1company = false;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              hintText:
                                                  LocaleKeys.Company_Name.tr(),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xFF0D3451))),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Visibility(
                                              visible: _form1company == true &&
                                                      form1addressType == false
                                                  ? true
                                                  : false,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        25, 5, 25, 0),
                                                child: Text(
                                                  LocaleKeys.valid_company.tr(),
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              )),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            25, 5, 25, 0),
                                        child: TextFormField(
                                          controller: form1emailTextField1,
                                          textInputAction: TextInputAction.done,
                                          onEditingComplete: () =>
                                              node.nextFocus(),
                                          // onFieldSubmitted: (_) => node.unfocus(),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            hintText: LocaleKeys.Email.tr(),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF0D3451))),
                                          ),
                                          validator: (String value) {
                                            String pattern =
                                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                            RegExp regex = new RegExp(pattern);
                                            if (value.isEmpty) {
                                              _form1email = true;
                                            } else if (!regex.hasMatch(value)) {
                                              _form1email = true;
                                            }

                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              String pattern =
                                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                              RegExp regex =
                                                  new RegExp(pattern);
                                              if (!regex.hasMatch(value)) {
                                                _form1email = true;
                                              } else {
                                                _form1email = false;
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Visibility(
                                              visible: _form1email == true
                                                  ? true
                                                  : false,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 40, 0),
                                                child: Text(
                                                  LocaleKeys.valid_email.tr(),
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              )),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            25, 5, 25, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Flexible(
                                              flex: 1,
                                              child: ButtonTheme(
                                                child: DropdownButtonFormField(
                                                  decoration: InputDecoration(
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xFF0D3451))),
                                                  ),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1,
                                                  icon: Icon(Icons
                                                      .keyboard_arrow_down_outlined),
                                                  hint: Text(
                                                      LocaleKeys.Code.tr()),
                                                  value: countryCode,
                                                  onChanged: (String newValue) {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            Form1mobile);

                                                    setState(() {
                                                      _form1countrycode = false;
                                                      countryCode = newValue;
                                                      countryCode == "+91"
                                                          ? _form1countryselection =
                                                              'IN'
                                                          : _form1countryselection =
                                                              'QA';
                                                      countryCode == "+91"
                                                          ? region = region_IN
                                                          : region = region_QA;
                                                      countryCode == "+974"
                                                          ? _form1regionselection =
                                                              '717'
                                                          : _form1regionselection =
                                                              '533';
                                                    });
                                                  },
                                                  items: [
                                                    DropdownMenuItem(
                                                      child: Text('+91'),
                                                      value: '+91',
                                                    ),
                                                    DropdownMenuItem(
                                                      child: Text('+974'),
                                                      value: '+974',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                              child: Text(
                                                '|',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 3,
                                              child: TextFormField(
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      10)
                                                ],
                                                controller:
                                                    form1mobileNumberTextField1,
                                                focusNode: Form1mobile,
                                                textInputAction:
                                                    TextInputAction.done,
                                                onEditingComplete: () =>
                                                    node.nextFocus(),
                                                keyboardType:
                                                    TextInputType.number,
                                                validator: (String value) {
                                                  String pattern =
                                                      r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                                  RegExp regex =
                                                      new RegExp(pattern);

                                                  if (value.isEmpty) {
                                                    _form1mobile = true;
                                                    return;
                                                  } else if (!regex
                                                      .hasMatch(value)) {}
                                                  return null;
                                                },
                                                onChanged: (value) {
                                                  setState(() {
                                                    _form1mobile = false;
                                                    // Resets the error
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  hintText:
                                                      LocaleKeys.Mobile.tr(),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFF0D3451))),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 11,
                                                          right: 3,
                                                          top: 0,
                                                          bottom: 0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Visibility(
                                              visible: _form1countrycode == true
                                                  ? true
                                                  : false,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        25, 5, 25, 0),
                                                child: Text(
                                                  '***',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              )),
                                          Visibility(
                                              visible: _form1mobile == true
                                                  ? true
                                                  : false,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 40, 0),
                                                child: Text(
                                                  LocaleKeys.valid_mobile.tr(),
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              )),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            25, 5, 25, 0),
                                        child: TextFormField(
                                          controller:
                                              form1buildingNumberTextField1,
                                          textInputAction: TextInputAction.done,
                                          onEditingComplete: () =>
                                              Form1mobile.requestFocus(
                                                  FocusNode()),
                                          onFieldSubmitted: (_) =>
                                              node.unfocus(),
                                          keyboardType:
                                              TextInputType.streetAddress,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              _form1buildingno = true;
                                              return;
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              _form1buildingno = false;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText:
                                                LocaleKeys.Building_Name.tr(),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF0D3451))),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Visibility(
                                              visible: _form1buildingno == true
                                                  ? true
                                                  : false,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        25, 5, 25, 0),
                                                child: Text(
                                                  LocaleKeys.valid_Building
                                                      .tr(),
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              )),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            25, 5, 25, 0),
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                                child: TextFormField(
                                              controller:
                                                  form1streetNumberTextField1,
                                              textInputAction:
                                                  TextInputAction.done,
                                              onEditingComplete: () =>
                                                  node.nextFocus(),
                                              onFieldSubmitted: (_) =>
                                                  node.unfocus(),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  _form1street = true;
                                                  return;
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                setState(() {
                                                  _form1street = false;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                hintText:
                                                    LocaleKeys.Street_No.tr(),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFF0D3451))),
                                              ),
                                            )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                                child: TextFormField(
                                              controller:
                                                  form1zoneNumberTextField1,
                                              textInputAction:
                                                  TextInputAction.done,
                                              onEditingComplete: () =>
                                                  node.nextFocus(),
                                              onFieldSubmitted: (_) =>
                                                  node.unfocus(),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  _form1zoneno = true;
                                                  return;
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                setState(() {
                                                  _form1zoneno = false;
                                                  // Resets the error
                                                });
                                              },
                                              decoration: InputDecoration(
                                                hintText:
                                                    LocaleKeys.Zone_No.tr(),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFF0D3451))),
                                              ),
                                            ))
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Visibility(
                                              visible: _form1street == true
                                                  ? true
                                                  : false,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        40, 10, 0, 0),
                                                child: Text(
                                                  LocaleKeys.valid_street.tr(),
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              )),
                                          Visibility(
                                              visible: _form1zoneno == true
                                                  ? true
                                                  : false,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 40, 0),
                                                child: Text(
                                                  LocaleKeys.valid_zone.tr(),
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              )),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            25, 5, 25, 0),
                                        child: TextFormField(
                                          controller: form1cityTextField1,
                                          textInputAction: TextInputAction.done,
                                          onFieldSubmitted: (_) =>
                                              node.unfocus(),
                                          onEditingComplete: () =>
                                              node.nextFocus(),
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              _form1city = true;
                                              return;
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              _form1city = false;
                                              // Resets the error
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText: LocaleKeys.City.tr(),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF0D3451))),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Visibility(
                                              visible: _form1city == true
                                                  ? true
                                                  : false,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        25, 5, 25, 0),
                                                child: Text(
                                                  LocaleKeys.valid_city.tr(),
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              )),
                                        ],
                                      ),
                                      DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              25, 5, 25, 0),
                                          child: DropdownButtonFormField(
                                              hint: Text(LocaleKeys
                                                  .Select_Region.tr()),
                                              decoration: InputDecoration(
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFF0D3451))),
                                              ),
                                              // focusNode: myFocusNode,
                                              icon: Icon(Icons
                                                  .keyboard_arrow_down_outlined),
                                              value: _form1regionselection,
                                              //   onTap: () => node.requestFocus(),
                                              onChanged: (newValue) {
                                                FocusScope.of(context)
                                                    .requestFocus(Form1country);
                                                setState(() {
                                                  _form1region = false;
                                                  _form1country = false;
                                                  _form1regionselection =
                                                      newValue;
                                                  // _form1countryselection = int
                                                  //             .parse(
                                                  //                 _form1regionselection) ==
                                                  //         765
                                                  //     ? _form1countryselection =
                                                  //         'QA'
                                                  //     : _form1countryselection =
                                                  //         'IN';
                                                });
                                              },
                                              validator: (var value) {
                                                if (value == null) {
                                                  _form1region = true;
                                                }
                                                return null;
                                              },
                                              items: region == null
                                                  ? []
                                                  : region.map((item) {
                                                      return DropdownMenuItem(
                                                          value: item['value']
                                                              .toString(),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            0),
                                                                child: Text(item[
                                                                    'title']),
                                                              ),
                                                            ],
                                                          ));
                                                    }).toList()),
                                        ),
                                      )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Visibility(
                                              visible: _form1region == true
                                                  ? true
                                                  : false,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        25, 5, 25, 0),
                                                child: Text(
                                                  LocaleKeys.valid_region.tr(),
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              )),
                                        ],
                                      ),
                                      DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              25, 5, 25, 0),
                                          child: DropdownButtonFormField(
                                              hint: Text(LocaleKeys
                                                  .Select_Country.tr()),
                                              decoration: InputDecoration(
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFF0D3451))),
                                              ),
                                              // focusNode: myFocusNode,
                                              icon: Icon(Icons
                                                  .keyboard_arrow_down_outlined),
                                              value: _form1countryselection,
                                              //   onTap: () => node.requestFocus(),
                                              onChanged: (newValue) {
                                                FocusScope.of(context)
                                                    .requestFocus(Form1country);
                                                setState(() {
                                                  _form1countryselection =
                                                      newValue;
                                                  _form1country = false;
                                                });
                                              },
                                              validator: (String value) {
                                                if (value == null) {
                                                  _form1country = true;
                                                }
                                                return null;
                                              },
                                              items: countryCode == '+91'
                                                  ? _IN.map((item) {
                                                      return DropdownMenuItem(
                                                          value: item['id']
                                                              .toString(),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              new Image.asset(
                                                                  item['image'],
                                                                  width: 20),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                                child: Text(item[
                                                                    'name']),
                                                              )
                                                            ],
                                                          ));
                                                    }).toList()
                                                  : _QA.map((item) {
                                                      return DropdownMenuItem(
                                                          value: item['id']
                                                              .toString(),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              new Image.asset(
                                                                  item['image'],
                                                                  width: 20),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                                child: Text(item[
                                                                    'name']),
                                                              )
                                                            ],
                                                          ));
                                                    }).toList()),
                                        ),
                                      )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Visibility(
                                              visible: _form1country == true
                                                  ? true
                                                  : false,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        25, 5, 25, 0),
                                                child: Text(
                                                  LocaleKeys.valid_Country.tr(),
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              )),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            25, 5, 25, 0),
                                        child: TextFormField(
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10)
                                          ],
                                          //   focusNode: FocusNode(canRequestFocus: true),

                                          focusNode: Form1country,

                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText:
                                                LocaleKeys.optional_mobile.tr(),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF0D3451))),
                                          ),
                                        ),
                                      ),
                                      // widget.router != "account"
                                      //     ? Padding(
                                      //         padding:
                                      //             const EdgeInsets.fromLTRB(
                                      //                 10, 15, 0, 0),
                                      //         child: Row(
                                      //           children: [
                                      //             IconButton(
                                      //               icon: (_isFavorited2 ==
                                      //                       false
                                      //                   ? Icon(Icons
                                      //                       .radio_button_off)
                                      //                   : Icon(Icons
                                      //                       .check_circle_outline)),
                                      //               color: Colors.orange,
                                      //               onPressed: _toggleFavorite2,
                                      //             ),
                                      //             GestureDetector(
                                      //                 onTap: () {
                                      //                   setState(() {
                                      //                     _isFavorited2 =
                                      //                         _isFavorited2 ==
                                      //                                 true
                                      //                             ? false
                                      //                             : true;
                                      //                     billaddressdif =
                                      //                         billaddressdif ==
                                      //                                 false
                                      //                             ? true
                                      //                             : false;
                                      //                   });
                                      //                 },
                                      //                 child: Text(
                                      //                   'Billing Address is Different',
                                      //                   style: TextStyle(
                                      //                       fontWeight:
                                      //                           billaddressdif == true
                                      //                               ? FontWeight
                                      //                                   .bold
                                      //                               : FontWeight
                                      //                                   .normal),
                                      //                 )),
                                      //           ],
                                      //         ),
                                      //       )
                                      //     : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Visibility(
                      //   visible: billaddressdif == true ? true : false,
                      //   child: Form(
                      //     autovalidateMode: AutovalidateMode.onUserInteraction,
                      //     key: _formkey2,
                      //     child: Column(
                      //       children: <Widget>[
                      //         // Column(
                      //         //   children: [
                      //         //     GestureDetector(
                      //         //       onTap: () {
                      //         //         setState(() {
                      //         //           billaddressdif = false;
                      //         //         });
                      //         //       },
                      //         //       child: SizedBox(
                      //         //         //  height: 50,
                      //         //         width: width,
                      //         //         //color: Colors.orange,
                      //         //         child: Padding(
                      //         //           padding:
                      //         //               const EdgeInsets.fromLTRB(20, 20, 0, 10),
                      //         //           child: Text(
                      //         //             'Shipping Address',
                      //         //           ),
                      //         //         ),
                      //         //       ),
                      //         //     ),
                      //         //     Divider(
                      //         //       thickness: 2,
                      //         //       height: 1,
                      //         //     ),
                      //         //     Row(
                      //         //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         //       children: [
                      //         //         Padding(
                      //         //           padding:
                      //         //               const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      //         //           child: Text(
                      //         //             'Address Title',
                      //         //           ),
                      //         //         ),
                      //         //         Padding(
                      //         //           padding: const EdgeInsets.only(right: 8),
                      //         //           child: ButtonTheme(
                      //         //             height: 20,
                      //         //             minWidth: 1,
                      //         //             // ignore: deprecated_member_use
                      //         //             child: RaisedButton(
                      //         //               // borderSide: BorderSide(color: Colors.black),
                      //         //
                      //         //               color: setdefault == true
                      //         //                   ? Color(0xFFF78500)
                      //         //                   : Color(0xFFFFFFFF),
                      //         //               shape: RoundedRectangleBorder(
                      //         //                 borderRadius:
                      //         //                     BorderRadius.circular(40.0),
                      //         //                 side: BorderSide(
                      //         //                   color: setdefault == true
                      //         //                       ? Color(0xFFF78500)
                      //         //                       : Color(0xFF666666),
                      //         //                 ),
                      //         //               ),
                      //         //               child: Text(
                      //         //                 'Edit',
                      //         //               ),
                      //         //               onPressed: () {
                      //         //                 setState(() {
                      //         //                   setdefault = setdefault == false
                      //         //                       ? true
                      //         //                       : false;
                      //         //                 });
                      //         //               },
                      //         //             ),
                      //         //           ),
                      //         //         ),
                      //         //       ],
                      //         //     ),
                      //         //     Row(
                      //         //       children: [
                      //         //         IconButton(
                      //         //           icon: (billaddressdif == true
                      //         //               ? Icon(Icons.check_circle_outline)
                      //         //               : Icon(Icons.radio_button_off)),
                      //         //           color: Colors.orange,
                      //         //           onPressed: _toggleFavorite2,
                      //         //         ),
                      //         //         GestureDetector(
                      //         //             onTap: () {
                      //         //               setState(() {
                      //         //                 _isFavorited2 = _isFavorited2 == true
                      //         //                     ? false
                      //         //                     : true;
                      //         //                 billaddressdif = billaddressdif == true
                      //         //                     ? false
                      //         //                     : true;
                      //         //               });
                      //         //             },
                      //         //             child: Text(
                      //         //               'Billing Address is Different',
                      //         //               style: TextStyle(
                      //         //                   fontWeight: FontWeight.bold),
                      //         //             )),
                      //         //       ],
                      //         //     ),
                      //         //   ],
                      //         // ),
                      //         Container(
                      //           child: Form(
                      //             autovalidateMode:
                      //                 AutovalidateMode.onUserInteraction,
                      //             child: Column(
                      //               children: <Widget>[
                      //                 Padding(
                      //                   padding: const EdgeInsets.fromLTRB(
                      //                       25, 5, 25, 0),
                      //                   child: TextFormField(
                      //                     controller:
                      //                         form2addressTitleTextField2,
                      //                     validator: (String value) {
                      //                       if (value.isEmpty) {
                      //                         _form2address = true;
                      //                       }
                      //                       return null;
                      //                     },
                      //                     onChanged: (value) {
                      //                       setState(() {
                      //                         _form2address = false;
                      //                       });
                      //                     },
                      //                     decoration: InputDecoration(
                      //                       focusedBorder: UnderlineInputBorder(
                      //                           borderSide: BorderSide(
                      //                               color: Color(0xFF0D3451))),
                      //                       hintText: 'Address Title',
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.end,
                      //                   children: [
                      //                     Visibility(
                      //                         visible: _form2address == true
                      //                             ? true
                      //                             : false,
                      //                         child: Padding(
                      //                           padding:
                      //                               const EdgeInsets.fromLTRB(
                      //                                   0, 10, 40, 0),
                      //                           child: Text(
                      //                             'Please enter Address Title',
                      //                             style: TextStyle(
                      //                                 color: Colors.red),
                      //                           ),
                      //                         )),
                      //                   ],
                      //                 ),
                      //                 InkWell(
                      //                   radius: 25.0,
                      //                   onTap: () {
                      //                     setState(() {
                      //                       form2addressType = false;
                      //                     });
                      //                   },
                      //                   child: Container(
                      //                     child: Padding(
                      //                       padding: const EdgeInsets.fromLTRB(
                      //                           25, 15, 25, 0),
                      //                       child: Row(
                      //                         children: [
                      //                           Text('Address Type'),
                      //                           Flexible(
                      //                             flex: 1,
                      //                             child: IconButton(
                      //                               icon: (form2addressType
                      //                                   ? Icon(Icons
                      //                                       .check_circle_outline)
                      //                                   : Icon(Icons
                      //                                       .radio_button_off)),
                      //                               color: Colors.orange,
                      //                               onPressed:
                      //                                   _form2toggleFavorite,
                      //                             ),
                      //                           ),
                      //                           Flexible(
                      //                             flex: 1,
                      //                             child: Transform(
                      //                               transform: Matrix4
                      //                                   .translationValues(
                      //                                       -8, 0.0, 0.0),
                      //                               child: GestureDetector(
                      //                                 onTap: () {
                      //                                   setState(() {
                      //                                     form2addressType =
                      //                                         true;
                      //                                   });
                      //                                 },
                      //                                 child: Text(
                      //                                   'Home',
                      //                                 ),
                      //                               ),
                      //                             ),
                      //                           ),
                      //                           Flexible(
                      //                             flex: 1,
                      //                             child: IconButton(
                      //                               icon: (form2addressType
                      //                                   ? Icon(Icons
                      //                                       .radio_button_off)
                      //                                   : Icon(Icons
                      //                                       .check_circle_outline)),
                      //                               color: Colors.orange,
                      //                               onPressed:
                      //                                   _form2toggleFavorite1,
                      //                             ),
                      //                           ),
                      //                           Flexible(
                      //                               flex: 1,
                      //                               child: Transform(
                      //                                   transform: Matrix4
                      //                                       .translationValues(
                      //                                           -8, 0.0, 0.0),
                      //                                   child: Text('Work'))),
                      //                         ],
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Padding(
                      //                   padding: const EdgeInsets.fromLTRB(
                      //                       25, 5, 25, 0),
                      //                   child: TextFormField(
                      //                     controller: form2nameTextField2,
                      //                     textInputAction: TextInputAction.done,
                      //                     onEditingComplete: () =>
                      //                         node.nextFocus(),
                      //                     validator: (String value) {
                      //                       if (value.isEmpty) {
                      //                         _form2name = true;
                      //                         return;
                      //                       }
                      //                       return null;
                      //                     },
                      //                     onChanged: (value) {
                      //                       setState(() {
                      //                         _form2name = false;
                      //                         // Resets the error
                      //                       });
                      //                     },
                      //                     decoration: InputDecoration(
                      //                       focusedBorder: UnderlineInputBorder(
                      //                           borderSide: BorderSide(
                      //                               color: Color(0xFF0D3451))),
                      //                       hintText: ' Name',
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.end,
                      //                   children: [
                      //                     Visibility(
                      //                         visible: _form2name == true
                      //                             ? true
                      //                             : false,
                      //                         child: Padding(
                      //                           padding:
                      //                               const EdgeInsets.fromLTRB(
                      //                                   0, 10, 40, 0),
                      //                           child: Text(
                      //                             'Please enter Name',
                      //                             style: TextStyle(
                      //                                 color: Colors.red),
                      //                           ),
                      //                         )),
                      //                   ],
                      //                 ),
                      //                 Padding(
                      //                   padding: const EdgeInsets.fromLTRB(
                      //                       25, 5, 25, 0),
                      //                   child: Visibility(
                      //                     visible: form2addressType == false,
                      //                     child: TextFormField(
                      //                       controller:
                      //                           form2companyNameTextField2,
                      //                       textInputAction:
                      //                           TextInputAction.done,
                      //                       onEditingComplete: () =>
                      //                           node.nextFocus(),
                      //                       validator: (String value) {
                      //                         if (value.isEmpty) {
                      //                           _form2company = true;
                      //                           return;
                      //                         }
                      //                         return null;
                      //                       },
                      //                       onChanged: (value) {
                      //                         setState(() {
                      //                           _form2company = false;
                      //                         });
                      //                       },
                      //                       decoration: InputDecoration(
                      //                         hintText: 'Company Name',
                      //                         focusedBorder:
                      //                             UnderlineInputBorder(
                      //                                 borderSide: BorderSide(
                      //                                     color: Color(
                      //                                         0xFF0D3451))),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.end,
                      //                   children: [
                      //                     Visibility(
                      //                         visible: _form2company == true &&
                      //                                 form2addressType == false
                      //                             ? true
                      //                             : false,
                      //                         child: Padding(
                      //                           padding:
                      //                               const EdgeInsets.fromLTRB(
                      //                                   0, 10, 40, 0),
                      //                           child: Text(
                      //                             'Please enter Company Name',
                      //                             style: TextStyle(
                      //                                 color: Colors.red),
                      //                           ),
                      //                         )),
                      //                   ],
                      //                 ),
                      //                 Padding(
                      //                   padding: const EdgeInsets.fromLTRB(
                      //                       25, 5, 25, 0),
                      //                   child: TextFormField(
                      //                     controller: form2emailTextField2,
                      //                     textInputAction: TextInputAction.done,
                      //                     onEditingComplete: () =>
                      //                         node.nextFocus(),
                      //                     keyboardType:
                      //                         TextInputType.emailAddress,
                      //                     decoration: InputDecoration(
                      //                       hintText: 'Email',
                      //                       focusedBorder: UnderlineInputBorder(
                      //                           borderSide: BorderSide(
                      //                               color: Color(0xFF0D3451))),
                      //                     ),
                      //                     validator: (String value) {
                      //                       String pattern =
                      //                           r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      //                       RegExp regex = new RegExp(pattern);
                      //                       if (value.isEmpty) {
                      //                         _form2email = true;
                      //                       } else if (!regex.hasMatch(value)) {
                      //                         _form2email = true;
                      //                       }
                      //
                      //                       return null;
                      //                     },
                      //                     onChanged: (value) {
                      //                       setState(() {
                      //                         String pattern =
                      //                             r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      //                         RegExp regex =
                      //                             new RegExp(pattern);
                      //                         if (!regex.hasMatch(value)) {
                      //                           _form2email = true;
                      //                         } else {
                      //                           _form2email = false;
                      //                         }
                      //                       });
                      //                     },
                      //                   ),
                      //                 ),
                      //                 Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.end,
                      //                   children: [
                      //                     Visibility(
                      //                         visible: _form2email == true
                      //                             ? true
                      //                             : false,
                      //                         child: Padding(
                      //                           padding:
                      //                               const EdgeInsets.fromLTRB(
                      //                                   0, 10, 40, 0),
                      //                           child: Text(
                      //                             'Please enter Valid Email',
                      //                             style: TextStyle(
                      //                                 color: Colors.red),
                      //                           ),
                      //                         )),
                      //                   ],
                      //                 ),
                      //                 Padding(
                      //                   padding: const EdgeInsets.fromLTRB(
                      //                       25, 5, 25, 0),
                      //                   child: Row(
                      //                     mainAxisSize: MainAxisSize.min,
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.end,
                      //                     children: <Widget>[
                      //                       Flexible(
                      //                         flex: 1,
                      //                         child: ButtonTheme(
                      //                           child: DropdownButtonFormField<
                      //                               String>(
                      //                             decoration: InputDecoration(
                      //                               focusedBorder:
                      //                                   UnderlineInputBorder(
                      //                                       borderSide: BorderSide(
                      //                                           color: Color(
                      //                                               0xFF0D3451))),
                      //                             ),
                      //                             style: Theme.of(context)
                      //                                 .textTheme
                      //                                 .subtitle1,
                      //                             icon: Icon(Icons
                      //                                 .keyboard_arrow_down_outlined),
                      //                             value: countryCode,
                      //                             onChanged: (String newValue) {
                      //                               FocusScope.of(context)
                      //                                   .requestFocus(
                      //                                       Form2mobile);
                      //                               setState(() {
                      //                                 countryCode = newValue;
                      //                               });
                      //                             },
                      //                             onTap: () =>
                      //                                 node.requestFocus(),
                      //                             items: [
                      //                               DropdownMenuItem(
                      //                                 child: Text('+ 91'),
                      //                                 value: '+ 91',
                      //                               ),
                      //                               DropdownMenuItem(
                      //                                 child: Text('+ 974'),
                      //                                 value: '+ 974',
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       SizedBox(
                      //                         width: 10,
                      //                         child: Text(
                      //                           '|',
                      //                           style: TextStyle(
                      //                               fontSize: 30,
                      //                               color: Colors.grey),
                      //                         ),
                      //                       ),
                      //                       Flexible(
                      //                         flex: 3,
                      //                         child: TextFormField(
                      //                           inputFormatters: [
                      //                             LengthLimitingTextInputFormatter(
                      //                                 10)
                      //                           ],
                      //                           controller:
                      //                               form2mobileNumberTextField2,
                      //                           // focusNode: _form2mobilefocus,
                      //                           // focusNode: myFocusNode,
                      //                           textInputAction:
                      //                               TextInputAction.done,
                      //
                      //                           onEditingComplete: () =>
                      //                               node.nextFocus(),
                      //                           keyboardType:
                      //                               TextInputType.number,
                      //                           validator: (String value) {
                      //                             String pattern =
                      //                                 r'(^(?:[+0]9)?[0-9]{10,12}$)';
                      //                             RegExp regex =
                      //                                 new RegExp(pattern);
                      //
                      //                             if (value.isEmpty) {
                      //                               _form2mobile = true;
                      //                               return;
                      //                             } else if (!regex
                      //                                 .hasMatch(value)) {}
                      //                             return null;
                      //                           },
                      //                           onChanged: (value) {
                      //                             setState(() {
                      //                               _form2mobile = false;
                      //                               // Resets the error
                      //                             });
                      //                           },
                      //                           decoration: InputDecoration(
                      //                             hintText: 'Mobile Number',
                      //                             focusedBorder:
                      //                                 UnderlineInputBorder(
                      //                                     borderSide: BorderSide(
                      //                                         color: Color(
                      //                                             0xFF0D3451))),
                      //                             contentPadding:
                      //                                 EdgeInsets.only(
                      //                                     left: 11,
                      //                                     right: 3,
                      //                                     top: 0,
                      //                                     bottom: 0),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.end,
                      //                   children: [
                      //                     Visibility(
                      //                         visible: _form2mobile == true
                      //                             ? true
                      //                             : false,
                      //                         child: Padding(
                      //                           padding:
                      //                               const EdgeInsets.fromLTRB(
                      //                                   0, 10, 40, 0),
                      //                           child: Text(
                      //                             'Please enter Mobile No',
                      //                             style: TextStyle(
                      //                                 color: Colors.red),
                      //                           ),
                      //                         )),
                      //                   ],
                      //                 ),
                      //                 Padding(
                      //                   padding: const EdgeInsets.fromLTRB(
                      //                       25, 5, 25, 0),
                      //                   child: TextFormField(
                      //                     controller:
                      //                         form2buildingNumberTextField2,
                      //                     textInputAction: TextInputAction.done,
                      //                     onEditingComplete: () =>
                      //                         node.nextFocus(),
                      //                     focusNode: Form2mobile,
                      //                     keyboardType:
                      //                         TextInputType.streetAddress,
                      //                     validator: (String value) {
                      //                       if (value.isEmpty) {
                      //                         _form2buildingno = true;
                      //                         return;
                      //                       }
                      //                       return null;
                      //                     },
                      //                     onChanged: (value) {
                      //                       setState(() {
                      //                         _form2buildingno = false;
                      //                       });
                      //                     },
                      //                     decoration: InputDecoration(
                      //                       hintText:
                      //                           'Building Name and Number',
                      //                       focusedBorder: UnderlineInputBorder(
                      //                           borderSide: BorderSide(
                      //                               color: Color(0xFF0D3451))),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.end,
                      //                   children: [
                      //                     Visibility(
                      //                         visible: _form2buildingno == true
                      //                             ? true
                      //                             : false,
                      //                         child: Padding(
                      //                           padding:
                      //                               const EdgeInsets.fromLTRB(
                      //                                   0, 10, 40, 0),
                      //                           child: Text(
                      //                             'Please enter Building Name and No',
                      //                             style: TextStyle(
                      //                                 color: Colors.red),
                      //                           ),
                      //                         )),
                      //                   ],
                      //                 ),
                      //                 Padding(
                      //                   padding: const EdgeInsets.fromLTRB(
                      //                       25, 5, 25, 0),
                      //                   child: Row(
                      //                     children: <Widget>[
                      //                       Flexible(
                      //                           child: TextFormField(
                      //                         controller:
                      //                             form2streetNumberTextField2,
                      //                         textInputAction:
                      //                             TextInputAction.done,
                      //                         onEditingComplete: () =>
                      //                             node.nextFocus(),
                      //                         keyboardType:
                      //                             TextInputType.number,
                      //                         validator: (String value) {
                      //                           if (value.isEmpty) {
                      //                             _form2street = true;
                      //                             return;
                      //                           }
                      //                           return null;
                      //                         },
                      //                         onChanged: (value) {
                      //                           setState(() {
                      //                             _form2street = false;
                      //                           });
                      //                         },
                      //                         decoration: InputDecoration(
                      //                           hintText: 'Street No',
                      //                           focusedBorder:
                      //                               UnderlineInputBorder(
                      //                                   borderSide: BorderSide(
                      //                                       color: Color(
                      //                                           0xFF0D3451))),
                      //                         ),
                      //                       )),
                      //                       SizedBox(
                      //                         width: 10,
                      //                       ),
                      //                       Flexible(
                      //                           child: TextFormField(
                      //                         controller:
                      //                             form2zoneNumberTextField2,
                      //                         textInputAction:
                      //                             TextInputAction.done,
                      //                         onEditingComplete: () =>
                      //                             node.nextFocus(),
                      //                         keyboardType:
                      //                             TextInputType.number,
                      //                         validator: (String value) {
                      //                           if (value.isEmpty) {
                      //                             _form2zoneno = true;
                      //                             return;
                      //                           }
                      //                           return null;
                      //                         },
                      //                         onChanged: (value) {
                      //                           setState(() {
                      //                             _form2zoneno = false;
                      //                             // Resets the error
                      //                           });
                      //                         },
                      //                         decoration: InputDecoration(
                      //                           hintText: 'Zone No',
                      //                           focusedBorder:
                      //                               UnderlineInputBorder(
                      //                                   borderSide: BorderSide(
                      //                                       color: Color(
                      //                                           0xFF0D3451))),
                      //                         ),
                      //                       ))
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceBetween,
                      //                   children: [
                      //                     Visibility(
                      //                         visible: _form2street == true
                      //                             ? true
                      //                             : false,
                      //                         child: Padding(
                      //                           padding:
                      //                               const EdgeInsets.fromLTRB(
                      //                                   40, 10, 0, 0),
                      //                           child: Text(
                      //                             'Please enter Street No',
                      //                             style: TextStyle(
                      //                                 color: Colors.red),
                      //                           ),
                      //                         )),
                      //                     Visibility(
                      //                         visible: _form2zoneno == true
                      //                             ? true
                      //                             : false,
                      //                         child: Padding(
                      //                           padding:
                      //                               const EdgeInsets.fromLTRB(
                      //                                   0, 10, 40, 0),
                      //                           child: Text(
                      //                             'Please enter Zone No',
                      //                             style: TextStyle(
                      //                                 color: Colors.red),
                      //                           ),
                      //                         )),
                      //                   ],
                      //                 ),
                      //                 Padding(
                      //                   padding: const EdgeInsets.fromLTRB(
                      //                       25, 5, 25, 0),
                      //                   child: TextFormField(
                      //                     controller: form2cityTextField2,
                      //                     textInputAction: TextInputAction.done,
                      //                     onEditingComplete: () =>
                      //                         node.nextFocus(),
                      //                     validator: (String value) {
                      //                       if (value.isEmpty) {
                      //                         _form2city = true;
                      //                         return;
                      //                       }
                      //                       return null;
                      //                     },
                      //                     onChanged: (value) {
                      //                       setState(() {
                      //                         _form2city = false;
                      //                         // Resets the error
                      //                       });
                      //                     },
                      //                     decoration: InputDecoration(
                      //                       hintText: 'City',
                      //                       focusedBorder: UnderlineInputBorder(
                      //                           borderSide: BorderSide(
                      //                               color: Color(0xFF0D3451))),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.end,
                      //                   children: [
                      //                     Visibility(
                      //                         visible: _form2city == true
                      //                             ? true
                      //                             : false,
                      //                         child: Padding(
                      //                           padding:
                      //                               const EdgeInsets.fromLTRB(
                      //                                   0, 10, 40, 0),
                      //                           child: Text(
                      //                             'Please enter City',
                      //                             style: TextStyle(
                      //                                 color: Colors.red),
                      //                           ),
                      //                         )),
                      //                   ],
                      //                 ),
                      //                 DropdownButtonHideUnderline(
                      //                     child: ButtonTheme(
                      //                   alignedDropdown: true,
                      //                   child: Padding(
                      //                     padding: const EdgeInsets.fromLTRB(
                      //                         25, 5, 25, 0),
                      //                     child: DropdownButtonFormField(
                      //                       hint: Text('Select Country'),
                      //                       decoration: InputDecoration(
                      //                         focusedBorder:
                      //                             UnderlineInputBorder(
                      //                                 borderSide: BorderSide(
                      //                                     color: Color(
                      //                                         0xFF0D3451))),
                      //                       ),
                      //                       icon: Icon(Icons
                      //                           .keyboard_arrow_down_outlined),
                      //                       value: _form2countryselection,
                      //                       onChanged: (newValue) {
                      //                         FocusScope.of(context)
                      //                             .requestFocus(Form2country);
                      //                         setState(() {
                      //                           _form2countryselection =
                      //                               newValue;
                      //                           _form2country = false;
                      //                         });
                      //                       },
                      //                       validator: (String value) {
                      //                         if (value == null) {
                      //                           _form2country = true;
                      //                         }
                      //                         return null;
                      //                       },
                      //                       items: _myJson.map((item) {
                      //                         return DropdownMenuItem(
                      //                             value: item['id'].toString(),
                      //                             child: Row(
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment.start,
                      //                               children: <Widget>[
                      //                                 new Image.asset(
                      //                                     item['image'],
                      //                                     width: 20),
                      //                                 Container(
                      //                                   margin: EdgeInsets.only(
                      //                                       left: 10),
                      //                                   child:
                      //                                       Text(item['name']),
                      //                                 )
                      //                               ],
                      //                             ));
                      //                       }).toList(),
                      //                     ),
                      //                   ),
                      //                 )),
                      //                 Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.end,
                      //                   children: [
                      //                     Visibility(
                      //                         visible: _form2country == true
                      //                             ? true
                      //                             : false,
                      //                         child: Padding(
                      //                           padding:
                      //                               const EdgeInsets.fromLTRB(
                      //                                   0, 10, 40, 0),
                      //                           child: Text(
                      //                             'Please Choose your Country',
                      //                             style: TextStyle(
                      //                                 color: Colors.red),
                      //                           ),
                      //                         )),
                      //                   ],
                      //                 ),
                      //                 Padding(
                      //                   padding: const EdgeInsets.fromLTRB(
                      //                       25, 5, 25, 0),
                      //                   child: TextFormField(
                      //                     inputFormatters: [
                      //                       LengthLimitingTextInputFormatter(10)
                      //                     ],
                      //                     onEditingComplete: () =>
                      //                         node.nextFocus(),
                      //                     textInputAction: TextInputAction.done,
                      //                     focusNode: Form2country,
                      //                     keyboardType: TextInputType.number,
                      //                     decoration: InputDecoration(
                      //                       hintText:
                      //                           'Alternate Phone Number(Optional)',
                      //                       focusedBorder: UnderlineInputBorder(
                      //                           borderSide: BorderSide(
                      //                               color: Color(0xFF0D3451))),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 /*    Visibility(
                      //                     visible: billaddress == false ? true : false,
                      //                     child: Padding(
                      //                       padding: const EdgeInsets.fromLTRB(
                      //                           30, 15, 40, 0),
                      //                       child: Row(
                      //                         children: [
                      //                           IconButton(
                      //                             icon: (_isFavorited2
                      //                                 ? Icon(Icons.check_circle_outline)
                      //                                 : Icon(Icons.radio_button_off)),
                      //                             color: Colors.orange,
                      //                             onPressed: _toggleFavorite2,
                      //                           ),
                      //                           GestureDetector(
                      //                               onTap: () {
                      //                                 setState(() {
                      //                                   _isFavorited2 =
                      //                                   _isFavorited2 == true
                      //                                       ? false
                      //                                       : true;
                      //                                   billaddress =
                      //                                   billaddress == false
                      //                                       ? true
                      //                                       : false;
                      //                                 });
                      //                               },
                      //                               child: Text(
                      //                                   'Billing Address is Different')),
                      //                         ],
                      //                       ),
                      //                     ),
                      //                   ),*/
                      //                 SizedBox(
                      //                   height: 50,
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
        persistentFooterButtons: <Widget>[
          Container(
            height: 40,
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: customButton(
                        title: LocaleKeys.CANCEL.tr(),
                        backgroundColor: primaryColor,
                      )),
                ),
                sizedBoxwidth10,
                Expanded(
                  flex: 2,
                  child: InkWell(
                    child: customButton(
                      title: widget.router == "account"
                          ? LocaleKeys.UPDATE.tr()
                          : LocaleKeys.UPDATE.tr(),
                      backgroundColor: secondaryColor,
                    ),
                    onTap: () {
                      setState(() {
                        form1addressTitleTextField1.text.isEmpty
                            ? _form1address = true
                            : _form1address = false;

                        form1nameTextField1.text.isEmpty
                            ? _form1name = true
                            : _form1name = false;

                        form1companyNameTextField1.text.isEmpty &&
                                form1addressType == false
                            ? _form1company = true
                            : _form1company = false;

                        form1emailTextField1.text.isEmpty
                            ? _form1email = true
                            : _form1email = false;

                        form1mobileNumberTextField1.text.isEmpty
                            ? _form1mobile = true
                            : _form1mobile = false;

                        form1buildingNumberTextField1.text.isEmpty
                            ? _form1buildingno = true
                            : _form1buildingno = false;

                        form1streetNumberTextField1.text.isEmpty
                            ? _form1street = true
                            : _form1street = false;

                        form1zoneNumberTextField1.text.isEmpty
                            ? _form1zoneno = true
                            : _form1zoneno = false;

                        form1cityTextField1.text.isEmpty
                            ? _form1city = true
                            : _form1city = false;
                        _form1countryselection == null
                            ? _form1country = true
                            : _form1country = false;
                        _form1regionselection == null
                            ? _form1region = true
                            : _form1region = false;
                        countryCode == null
                            ? _form1countrycode = true
                            : _form1countrycode = false;

                        if (form1addressType == true) if (_form1address ||
                            _form1email ||
                            _form1mobile ||
                            _form1name ||
                            _form1country ||
                            _form1buildingno ||
                            _form1zoneno ||
                            _form1city ||
                            _form1street ||
                            _form1countrycode ||
                            _form1region ||
                            _form1country) {
                          print("Form 1 Conatins Error");
                        } else {
                          print(form1addressTitleTextField1.text);
                          print(form1nameTextField1.text);
                          print(form1emailTextField1.text);
                          print(form1mobileNumberTextField1.text);
                          print(form1buildingNumberTextField1.text);
                          print(form1streetNumberTextField1.text);
                          print(form1zoneNumberTextField1.text);
                          print(form1cityTextField1.text);
                          updateAddress(customerID, addressID);
                        }
                        if (form1addressType == false) {
                          if (_form1address ||
                              _form1email ||
                              _form1mobile ||
                              _form1name ||
                              _form1company ||
                              _form1country ||
                              _form1buildingno ||
                              _form1zoneno ||
                              _form1city ||
                              _form1street) {
                            print("Form 1 Conatins Error");
                          } else {
                            print(form1addressTitleTextField1.text);
                            print(form1nameTextField1.text);
                            print(form1companyNameTextField1.text);
                            print(form1emailTextField1.text);
                            print(form1mobileNumberTextField1.text);
                            print(form1buildingNumberTextField1.text);
                            print(form1streetNumberTextField1.text);
                            print(form1zoneNumberTextField1.text);
                            print(form1cityTextField1.text);
                            updateAddress(customerID, addressID);
                          }
                        }

                        if (billaddressdif == true) {
                          form2addressTitleTextField2.text.isEmpty
                              ? _form2address = true
                              : _form2address = false;

                          form2nameTextField2.text.isEmpty
                              ? _form2name = true
                              : _form2name = false;

                          form2companyNameTextField2.text.isEmpty &&
                                  form2addressType == false
                              ? _form2company = true
                              : _form2company = false;

                          form2emailTextField2.text.isEmpty
                              ? _form2email = true
                              : _form2email = false;

                          form2mobileNumberTextField2.text.isEmpty
                              ? _form2mobile = true
                              : _form2mobile = false;

                          form2buildingNumberTextField2.text.isEmpty
                              ? _form2buildingno = true
                              : _form2buildingno = false;

                          form2streetNumberTextField2.text.isEmpty
                              ? _form2street = true
                              : _form2street = false;

                          form2zoneNumberTextField2.text.isEmpty
                              ? _form2zoneno = true
                              : _form2zoneno = false;

                          form2cityTextField2.text.isEmpty
                              ? _form2city = true
                              : _form2city = false;
                          _form2countryselection == null
                              ? _form2country = true
                              : _form2country = false;
                          if (_form2address ||
                              _form2email ||
                              _form2mobile ||
                              _form2name ||
                              _form2country ||
                              _form2buildingno ||
                              _form2zoneno ||
                              _form2city ||
                              _form2street) {
                            print("Form 2 Contains Error");
                          } else {
                            print(form2addressTitleTextField2.text);
                            print(form2nameTextField2.text);
                            print(form2emailTextField2.text);
                            print(form2mobileNumberTextField2.text);
                            print(form2buildingNumberTextField2.text);
                            print(form2streetNumberTextField2.text);
                            print(form2zoneNumberTextField2.text);
                            print(form2cityTextField2.text);
                          }
                          if (form2addressType == false) {
                            if (_form2address ||
                                _form2email ||
                                _form2mobile ||
                                _form2name ||
                                _form2company ||
                                _form2country ||
                                _form2buildingno ||
                                _form2zoneno ||
                                _form2city ||
                                _form2street) {
                              print("Form 2 Conatins Error");
                            } else {
                              print(form2addressTitleTextField2.text);
                              print(form2nameTextField2.text);
                              print(form2companyNameTextField2.text);
                              print(form2emailTextField2.text);
                              print(form2mobileNumberTextField2.text);
                              print(form2buildingNumberTextField2.text);
                              print(form2streetNumberTextField2.text);
                              print(form2zoneNumberTextField2.text);
                              print(form2cityTextField2.text);
                            }
                          }
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
