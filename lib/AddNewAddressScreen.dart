import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new AddNewAddressScreen(),
    ));

class AddNewAddressScreen extends StatefulWidget {
  @override
  _AddNewAddressScreenState createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
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
  bool _form1buildingno = false;
  bool _form1street = false;
  bool _form1zoneno = false;
  bool _form1city = false;
  bool _form1country = false;
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
  FocusNode _form1addressfocus = FocusNode();

  FocusNode _form1namefocus = FocusNode();
  FocusNode _form1companyfocus = FocusNode();
  FocusNode _form1emailfocus = FocusNode();
  FocusNode _form1mobilefocus = FocusNode();
  FocusNode _form1buildingnofocus = FocusNode();
  FocusNode _form1streetfocus = FocusNode();
  FocusNode _form1zonenofocus = FocusNode();
  FocusNode _form1cityfocus = FocusNode();
  FocusNode _form1countryfocus = FocusNode();
  FocusNode _form2addressfocus = FocusNode();
  FocusNode _form2namefocus = FocusNode();
  FocusNode _form2companyfocus = FocusNode();
  FocusNode _form2emailfocus = FocusNode();
  FocusNode _form2mobilefocus = FocusNode();
  FocusNode _form2buildingnofocus = FocusNode();
  FocusNode _form2streetfocus = FocusNode();
  FocusNode _form2zonenofocus = FocusNode();
  FocusNode _form2cityfocus = FocusNode();
  FocusNode _form2countryfocus = FocusNode();

  //variable
  bool addressType = true;
  //user profile details from api
  Map accountDetails;
  String countryCode = '+91';
  String userType;

  @override
  void initState() {
    super.initState();
    _form1addressfocus = FocusNode();
  }

  List<Map> _myJson = [
    {'id': 1, "image": "asset/image/afghanistan.png", 'name': 'Afghanistan'},
    {'id': 2, "image": "asset/image/australia.png", 'name': 'Australia'},
    {'id': 3, "image": "asset/image/canada.png", 'name': 'Canada'},
    {'id': 4, "image": "asset/image/india.png", 'name': 'India'},
    {'id': 5, "image": "asset/image/pakistan.png", 'name': 'Pakistan'},
  ];

  String _form1countryselection;
  String _form2countryselection;

  bool _isFavorited2 = false;
  bool billaddressdif = false;
  bool setdefault = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey2 = GlobalKey<FormState>();

  void _toggleFavorite() {
    setState(() {
      addressType = true;
    });
  }

  void _toggleFavorite1() {
    setState(() {
      addressType = false;
    });
  }

  void _toggleFavorite2() {
    setState(() {
      if (_isFavorited2) {
        _isFavorited2 = false;
      } else {
        _isFavorited2 = true;
      }
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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () {
              //  Navigator.pop(context);
            },
          ),
          title: Text('Add New Address'),
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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Visibility(
                  visible: billaddressdif == false ? true : false,
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Shipping Address',
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                                  borderRadius: BorderRadius.circular(40.0),
                                  side: BorderSide(
                                    color: setdefault == true
                                        ? Color(0xFFF78500)
                                        : Color(0xFF666666),
                                  ),
                                ),
                                child: Text(
                                  'Set as default',
                                ),
                                onPressed: () {
                                  setState(() {
                                    setdefault =
                                        setdefault == false ? true : false;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
                          child: Row(
                            children: [
                              ButtonTheme(
                                height: 20,
                                // ignore: deprecated_member_use
                                child: OutlineButton.icon(
                                  icon: Icon(
                                    Icons.location_on,
                                    size: 15,
                                  ),
                                  borderSide: BorderSide(color: Colors.black),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  onPressed: () async {},
                                  label: Text(
                                    'Locate Me',
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
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: TextFormField(
                                    controller: form1addressTitleTextField1,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        _form1address = true;
                                      }
                                      return null;
                                    },
                                    onEditingComplete: () => node.nextFocus(),
                                    onChanged: (value) {
                                      setState(() {
                                        _form1address = false;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF0D3451))),
                                      hintText: 'Address Title',
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                        visible: _form1address == true
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 40, 0),
                                          child: Text(
                                            'Please enter Address Title',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                  ],
                                ),
                                InkWell(
                                  radius: 25.0,
                                  onTap: () {
                                    setState(() {
                                      addressType = false;
                                    });
                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 15, 40, 0),
                                      child: Row(
                                        children: [
                                          Text('Address Type'),
                                          Flexible(
                                            flex: 1,
                                            child: IconButton(
                                              icon: (addressType
                                                  ? Icon(Icons
                                                      .check_circle_outline)
                                                  : Icon(
                                                      Icons.radio_button_off)),
                                              color: Colors.orange,
                                              onPressed: _toggleFavorite,
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Transform(
                                              transform:
                                                  Matrix4.translationValues(
                                                      -8, 0.0, 0.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    addressType = true;
                                                  });
                                                },
                                                child: Text(
                                                  'Home',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: IconButton(
                                              icon: (addressType
                                                  ? Icon(Icons.radio_button_off)
                                                  : Icon(Icons
                                                      .check_circle_outline)),
                                              color: Colors.orange,
                                              onPressed: _toggleFavorite1,
                                            ),
                                          ),
                                          Flexible(
                                              flex: 1,
                                              child: Transform(
                                                  transform:
                                                      Matrix4.translationValues(
                                                          -8, 0.0, 0.0),
                                                  child: Text('Work'))),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: TextFormField(
                                    controller: form1nameTextField1,
                                    onEditingComplete: () => node.nextFocus(),
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
                                      hintText: ' Name',
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                        visible:
                                            _form1name == true ? true : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 40, 0),
                                          child: Text(
                                            'Please enter Name',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: Visibility(
                                    visible: addressType == false,
                                    child: TextFormField(
                                      controller: form1companyNameTextField1,
                                      onEditingComplete: () => node.nextFocus(),
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
                                        hintText: 'Company Name',
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF0D3451))),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                        visible: _form1company == true &&
                                                addressType == false
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 40, 0),
                                          child: Text(
                                            'Please enter Company Name',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: TextFormField(
                                    controller: form1emailTextField1,
                                    onEditingComplete: () => node.nextFocus(),
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: 'Email',
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
                                        RegExp regex = new RegExp(pattern);
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                        visible:
                                            _form1email == true ? true : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 40, 0),
                                          child: Text(
                                            'Please enter Valid Email',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        flex: 1,
                                        child: ButtonTheme(
                                          child:
                                              DropdownButtonFormField<String>(
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
                                            value: countryCode,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                countryCode = newValue;
                                              });
                                            },
                                            onTap: () => _form1addressfocus
                                                .requestFocus(),
                                            items: [
                                              DropdownMenuItem(
                                                child: Text('+91'),
                                                value: '+91',
                                              ),
                                              DropdownMenuItem(
                                                child: Text('+61'),
                                                value: '+61',
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
                                              fontSize: 30, color: Colors.grey),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 3,
                                        child: TextFormField(
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10)
                                          ],
                                          controller:
                                              form1mobileNumberTextField1,
                                          focusNode: _form1mobilefocus,
                                          textInputAction: TextInputAction.next,
                                          onEditingComplete: () =>
                                              node.nextFocus(),
                                          keyboardType: TextInputType.number,
                                          validator: (String value) {
                                            String pattern =
                                                r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                            RegExp regex = new RegExp(pattern);

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
                                            hintText: 'Mobile Number',
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF0D3451))),
                                            contentPadding: EdgeInsets.only(
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                        visible:
                                            _form1mobile == true ? true : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 40, 0),
                                          child: Text(
                                            'Please enter Mobile No',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: TextFormField(
                                    controller: form1buildingNumberTextField1,
                                    onEditingComplete: () => node.nextFocus(),
                                    keyboardType: TextInputType.streetAddress,
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
                                      hintText: 'Building Name and Number',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF0D3451))),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                        visible: _form1buildingno == true
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 40, 0),
                                          child: Text(
                                            'Please enter Building Name and No',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                          child: TextFormField(
                                        controller: form1streetNumberTextField1,
                                        onEditingComplete: () =>
                                            node.nextFocus(),
                                        keyboardType: TextInputType.number,
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
                                          hintText: 'Street No',
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF0D3451))),
                                        ),
                                      )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                          child: TextFormField(
                                        controller: form1zoneNumberTextField1,
                                        onEditingComplete: () =>
                                            node.nextFocus(),
                                        keyboardType: TextInputType.number,
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
                                          hintText: 'Postcode',
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF0D3451))),
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
                                        visible:
                                            _form1street == true ? true : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              40, 10, 0, 0),
                                          child: Text(
                                            'Please enter Street No',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                    Visibility(
                                        visible:
                                            _form1zoneno == true ? true : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 40, 0),
                                          child: Text(
                                            'Please enter Zone No',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: TextFormField(
                                    controller: form1cityTextField1,
                                    onEditingComplete: () => node.nextFocus(),
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
                                      hintText: 'City',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF0D3451))),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                        visible:
                                            _form1city == true ? true : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 40, 0),
                                          child: Text(
                                            'Please enter City',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                  ],
                                ),
                                DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                    child: DropdownButtonFormField(
                                      hint: Text('Select Country'),
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF0D3451))),
                                      ),
                                      icon: Icon(
                                          Icons.keyboard_arrow_down_outlined),
                                      value: _form1countryselection,
                                      onChanged: (newValue) {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        setState(() {
                                          _form1countryselection = newValue;
                                          _form1country = false;
                                        });
                                      },
                                      validator: (String value) {
                                        if (value == null) {
                                          _form1country = true;
                                        }
                                        return null;
                                      },
                                      items: _myJson.map((item) {
                                        return DropdownMenuItem(
                                            value: item['id'].toString(),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Image.asset(item['image'],
                                                    width: 20),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text(item['name']),
                                                )
                                              ],
                                            ));
                                      }).toList(),
                                    ),
                                  ),
                                )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                        visible: _form1country == true
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 40, 0),
                                          child: Text(
                                            'Please Choose your Country',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10)
                                    ],
                                    focusNode: FocusNode(canRequestFocus: true),
                                    onEditingComplete: () => node.nextFocus(),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText:
                                          'Alternate Phone Number(Optional)',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF0D3451))),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 15, 40, 0),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: (_isFavorited2 == false
                                            ? Icon(Icons.radio_button_off)
                                            : Icon(Icons.check_circle_outline)),
                                        color: Colors.orange,
                                        onPressed: _toggleFavorite2,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _isFavorited2 =
                                                  _isFavorited2 == true
                                                      ? false
                                                      : true;
                                              billaddressdif =
                                                  billaddressdif == false
                                                      ? true
                                                      : false;
                                            });
                                          },
                                          child: Text(
                                              'Billing Address is Different')),
                                    ],
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
                Visibility(
                  visible: billaddressdif == true ? true : false,
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formkey2,
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  billaddressdif = false;
                                });
                              },
                              child: SizedBox(
                                //  height: 50,
                                width: width,
                                //color: Colors.orange,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 0, 10),
                                  child: Text(
                                    'Shipping Address',
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 2,
                              height: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text(
                                    'Address Title',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
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
                                        'Edit',
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
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: (billaddressdif == true
                                      ? Icon(Icons.check_circle_outline)
                                      : Icon(Icons.radio_button_off)),
                                  color: Colors.orange,
                                  onPressed: _toggleFavorite2,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isFavorited2 = _isFavorited2 == true
                                            ? false
                                            : true;
                                        billaddressdif = billaddressdif == true
                                            ? false
                                            : true;
                                      });
                                    },
                                    child: Text(
                                      'Billing Address is Different',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 10, 0),
                          child: Row(
                            children: [
                              ButtonTheme(
                                height: 20,
                                // ignore: deprecated_member_use
                                child: OutlineButton.icon(
                                  icon: Icon(
                                    Icons.location_on,
                                    size: 15,
                                  ),
                                  borderSide: BorderSide(color: Colors.black),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  onPressed: () async {},
                                  label: Text(
                                    'Locate Me',
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
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: TextFormField(
                                    controller: form2addressTitleTextField2,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        _form2address = true;
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _form2address = false;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF0D3451))),
                                      hintText: 'Address Title',
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                        visible: _form2address == true
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 40, 0),
                                          child: Text(
                                            'Please enter Address Title',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                  ],
                                ),
                                InkWell(
                                  radius: 25.0,
                                  onTap: () {
                                    setState(() {
                                      addressType = false;
                                    });
                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 15, 40, 0),
                                      child: Row(
                                        children: [
                                          Text('Address Type'),
                                          Flexible(
                                            flex: 1,
                                            child: IconButton(
                                              icon: (addressType
                                                  ? Icon(Icons
                                                      .check_circle_outline)
                                                  : Icon(
                                                      Icons.radio_button_off)),
                                              color: Colors.orange,
                                              onPressed: _toggleFavorite,
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Transform(
                                              transform:
                                                  Matrix4.translationValues(
                                                      -8, 0.0, 0.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    addressType = true;
                                                  });
                                                },
                                                child: Text(
                                                  'Home',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: IconButton(
                                              icon: (addressType
                                                  ? Icon(Icons.radio_button_off)
                                                  : Icon(Icons
                                                      .check_circle_outline)),
                                              color: Colors.orange,
                                              onPressed: _toggleFavorite1,
                                            ),
                                          ),
                                          Flexible(
                                              flex: 1,
                                              child: Transform(
                                                  transform:
                                                      Matrix4.translationValues(
                                                          -8, 0.0, 0.0),
                                                  child: Text('Work'))),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: TextFormField(
                                    controller: form2nameTextField2,
                                    onEditingComplete: () => node.nextFocus(),
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        _form2name = true;
                                        return;
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _form2name = false;
                                        // Resets the error
                                      });
                                    },
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF0D3451))),
                                      hintText: ' Name',
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                        visible:
                                            _form2name == true ? true : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 40, 0),
                                          child: Text(
                                            'Please enter Name',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: Visibility(
                                    visible: addressType == false,
                                    child: TextFormField(
                                      controller: form2companyNameTextField2,
                                      onEditingComplete: () => node.nextFocus(),
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          _form2company = true;
                                          return;
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          _form2company = false;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Company Name',
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF0D3451))),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                        visible: _form2company == true &&
                                                addressType == false
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 40, 0),
                                          child: Text(
                                            'Please enter Company Name',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: TextFormField(
                                    controller: form2emailTextField2,
                                    onEditingComplete: () => node.nextFocus(),
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF0D3451))),
                                    ),
                                    validator: (String value) {
                                      String pattern =
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp regex = new RegExp(pattern);
                                      if (value.isEmpty) {
                                        _form2email = true;
                                      } else if (!regex.hasMatch(value)) {
                                        _form2email = true;
                                      }

                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        String pattern =
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                        RegExp regex = new RegExp(pattern);
                                        if (!regex.hasMatch(value)) {
                                          _form2email = true;
                                        } else {
                                          _form2email = false;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                        visible:
                                            _form2email == true ? true : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 40, 0),
                                          child: Text(
                                            'Please enter Valid Email',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        flex: 1,
                                        child: ButtonTheme(
                                          child:
                                              DropdownButtonFormField<String>(
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
                                            value: countryCode,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                countryCode = newValue;
                                              });
                                            },
                                            onTap: () => _form1countryfocus
                                                .requestFocus(),
                                            items: [
                                              DropdownMenuItem(
                                                child: Text('+91'),
                                                value: '+91',
                                              ),
                                              DropdownMenuItem(
                                                child: Text('+61'),
                                                value: '+61',
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
                                              fontSize: 30, color: Colors.grey),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 3,
                                        child: TextFormField(
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10)
                                          ],
                                          controller:
                                              form2mobileNumberTextField2,
                                          focusNode: _form2mobilefocus,
                                          textInputAction: TextInputAction.next,
                                          onEditingComplete: () =>
                                              node.nextFocus(),
                                          keyboardType: TextInputType.number,
                                          validator: (String value) {
                                            String pattern =
                                                r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                            RegExp regex = new RegExp(pattern);

                                            if (value.isEmpty) {
                                              _form2mobile = true;
                                              return;
                                            } else if (!regex
                                                .hasMatch(value)) {}
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              _form2mobile = false;
                                              // Resets the error
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'Mobile Number',
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF0D3451))),
                                            contentPadding: EdgeInsets.only(
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                        visible:
                                            _form2mobile == true ? true : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 40, 0),
                                          child: Text(
                                            'Please enter Mobile No',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: TextFormField(
                                    controller: form2buildingNumberTextField2,
                                    onEditingComplete: () => node.nextFocus(),
                                    keyboardType: TextInputType.streetAddress,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        _form2buildingno = true;
                                        return;
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _form2buildingno = false;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Building Name and Number',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF0D3451))),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                        visible: _form2buildingno == true
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 40, 0),
                                          child: Text(
                                            'Please enter Building Name and No',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                          child: TextFormField(
                                        controller: form2streetNumberTextField2,
                                        onEditingComplete: () =>
                                            node.nextFocus(),
                                        keyboardType: TextInputType.number,
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            _form2street = true;
                                            return;
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _form2street = false;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Street No',
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF0D3451))),
                                        ),
                                      )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                          child: TextFormField(
                                        controller: form2zoneNumberTextField2,
                                        onEditingComplete: () =>
                                            node.nextFocus(),
                                        keyboardType: TextInputType.number,
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            _form2zoneno = true;
                                            return;
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _form2zoneno = false;
                                            // Resets the error
                                          });
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Postcode',
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF0D3451))),
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
                                        visible:
                                            _form2street == true ? true : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              40, 10, 0, 0),
                                          child: Text(
                                            'Please enter Street No',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                    Visibility(
                                        visible:
                                            _form2zoneno == true ? true : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 40, 0),
                                          child: Text(
                                            'Please enter Zone No',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: TextFormField(
                                    controller: form2cityTextField2,
                                    onEditingComplete: () => node.nextFocus(),
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        _form2city = true;
                                        return;
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _form2city = false;
                                        // Resets the error
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'City',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF0D3451))),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                        visible:
                                            _form2city == true ? true : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 40, 0),
                                          child: Text(
                                            'Please enter City',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                  ],
                                ),
                                DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                    child: DropdownButtonFormField(
                                      hint: Text('Select Country'),
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF0D3451))),
                                      ),
                                      icon: Icon(
                                          Icons.keyboard_arrow_down_outlined),
                                      value: _form2countryselection,
                                      onChanged: (newValue) {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        setState(() {
                                          _form2countryselection = newValue;
                                          _form2country = false;
                                        });
                                      },
                                      validator: (String value) {
                                        if (value == null) {
                                          _form2country = true;
                                        }
                                        return null;
                                      },
                                      items: _myJson.map((item) {
                                        return DropdownMenuItem(
                                            value: item['id'].toString(),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Image.asset(item['image'],
                                                    width: 20),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text(item['name']),
                                                )
                                              ],
                                            ));
                                      }).toList(),
                                    ),
                                  ),
                                )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                        visible: _form2country == true
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 40, 0),
                                          child: Text(
                                            'Please Choose your Country',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 5, 40, 0),
                                  child: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10)
                                    ],
                                    focusNode: FocusNode(canRequestFocus: true),
                                    onEditingComplete: () => node.nextFocus(),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText:
                                          'Alternate Phone Number(Optional)',
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF0D3451))),
                                    ),
                                  ),
                                ),
                                /*    Visibility(
                                          visible: billaddress == false ? true : false,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                30, 15, 40, 0),
                                            child: Row(
                                              children: [
                                                IconButton(
                                                  icon: (_isFavorited2
                                                      ? Icon(Icons.check_circle_outline)
                                                      : Icon(Icons.radio_button_off)),
                                                  color: Colors.orange,
                                                  onPressed: _toggleFavorite2,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        _isFavorited2 =
                                                        _isFavorited2 == true
                                                            ? false
                                                            : true;
                                                        billaddress =
                                                        billaddress == false
                                                            ? true
                                                            : false;
                                                      });
                                                    },
                                                    child: Text(
                                                        'Billing Address is Different')),
                                              ],
                                            ),
                                          ),
                                        ),*/
                                SizedBox(
                                  height: 50,
                                )
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
        ),
        persistentFooterButtons: <Widget>[
          Container(
            height: 50,
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ButtonTheme(
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    padding: EdgeInsets.zero,
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(colors: <Color>[
                            const Color(0xFF103D52),
                            const Color(0xFF304C58),
                            const Color(0xFF2C5466),
                            const Color(0xFF4F7180),
                          ])),
                      child: Text(
                        'CANCEL',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                ButtonTheme(
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    padding: EdgeInsets.zero,
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(colors: <Color>[
                            const Color(0xFFE07C24),
                            const Color(0xFFF69402),
                            const Color(0xFFF5BB2A),
                          ])),
                      child: Text(
                        'SAVE & DELIVER',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        print(form1nameTextField1.text);
                        print(form1addressTitleTextField1.text);
                        print(form1companyNameTextField1.text);
                        print(form1emailTextField1.text);
                        print(form1mobileNumberTextField1.text);

                        if (billaddressdif == false) {
                          form1addressTitleTextField1.text.isEmpty
                              ? _form1address = true
                              : _form1address = false;

                          form1nameTextField1.text.isEmpty
                              ? _form1name = true
                              : _form1name = false;

                          form1companyNameTextField1.text.isEmpty &&
                                  addressType == false
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

                          if (addressType == false) {
                            if (_form1company == true) {
                              print('Please enter Company name');
                            }
                          }

                          if (_form1address == true) {
                            print('Form Contains Error');
                          } else if (_form1name == true) {
                            print('Form Contains Error');
                          } else if (_form1email == true) {
                            print('Form Contains Error');
                          } else if (_form1mobile == true) {
                            print('Form Contains Error');
                          } else if (_form1buildingno == true) {
                            print('Form Contains Error');
                          } else if (_form1street == true) {
                            print('Form Contains Error');
                          } else if (_form1zoneno == true) {
                            print('Form Contains Error');
                          } else if (_form1city == true) {
                            print('Form Contains Error');
                          } else if (_form1country == true) {
                            print('Form Contains Error');
                          } else {
                            print('ok');
                          }
                        }
                        if (billaddressdif == true) {
                          if (_form2address == true) {
                            print('Form Contains Error');
                          } else if (_form2name == true) {
                            print('Form Contains Error');
                          } else if (_form2email == true) {
                            print('Form Contains Error');
                          } else if (_form2mobile == true) {
                            print('Form Contains Error');
                          } else if (_form2buildingno == true) {
                            print('Form Contains Error');
                          } else if (_form2street == true) {
                            print('Form Contains Error');
                          } else if (_form2zoneno == true) {
                            print('Form Contains Error');
                          } else if (_form2city == true) {
                            print('Form Contains Error');
                          } else if (_form2country == true) {
                            print('Form Contains Error');
                          } else {
                            print('ok');
                          }
                          form2addressTitleTextField2.text.isEmpty
                              ? _form2address = true
                              : _form2address = false;

                          form2nameTextField2.text.isEmpty
                              ? _form2name = true
                              : _form2name = false;

                          form2companyNameTextField2.text.isEmpty &&
                                  addressType == false
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
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
