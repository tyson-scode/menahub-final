import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(home: new MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _text1 = TextEditingController();
  final _text2 = TextEditingController();
  final _text3 = TextEditingController();
  final _text4 = TextEditingController();
  final _text5 = TextEditingController();
  final _text6 = TextEditingController();
  final _text7 = TextEditingController();
  final _text8 = TextEditingController();
  final _text9 = TextEditingController();

  bool _validate1 = false;
  bool _validate2 = false;
  bool _validate3 = false;
  bool _validate4 = false;
  bool _validate5 = false;
  bool _validate6 = false;
  bool _validate7 = false;
  bool _validate8 = false;
  bool _validate9 = false;
  bool _validate10 = false;
  FocusNode myFocusNode;
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  List<Map> _myJson = [
    {'id': 1, "image": "asset/image/afghanistan.png", 'name': 'Afghanistan'},
    {'id': 2, "image": "asset/image/australia.png", 'name': 'Australia'},
    {'id': 3, "image": "asset/image/canada.png", 'name': 'Canada'},
    {'id': 4, "image": "asset/image/india.png", 'name': 'India'},
    {'id': 5, "image": "asset/image/pakistan.png", 'name': 'Pakistan'},
  ];
  String _myselection;
  bool _isFavorited = true;
  bool _isFavorited1 = true;
  bool _isFavorited2 = true;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void _toggleFavorite() {
    setState(() {
      _isFavorited = true;
      _isFavorited1 = false;
      // if (_isFavorited) {
      //   _isFavorited1 = false;
      // } else {
      //   _isFavorited = true;
      // }
    });
  }

  void _toggleFavorite1() {
    setState(() {
      _isFavorited1 = true;
      _isFavorited = false;
      // if (_isFavorited1) {
      //   _isFavorited = false;
      // } else {
      //   _isFavorited1 = true;
      // }
    });
  }

  void _toggleFavorite2() {
    setState(() {
      if (_isFavorited2) {
        _isFavorited2 = false;
      } else {
        _isFavorited2 = true;
      }
    });
  }

  String dropval = '';
  void dropChange(String val) {}

  @override
  Widget build(BuildContext context) {
    String dropdownValue = '+91';

    final node = FocusScope.of(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () {},
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
                      child: OutlineButton(
                        borderSide: BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: Text(
                          'Set as default',
                        ),
                        onPressed: () {},
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
                        child: OutlineButton.icon(
                          icon: Icon(
                            Icons.location_on,
                            size: 15,
                          ),
                          borderSide: BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          onPressed: () {},
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                          child: TextFormField(
                            controller: _text1,
                            validator: (String value) {
                              if (value.isEmpty) {
                                _validate1 = true;
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _validate1 = false;
                              });
                            },
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF0D3451))),
                              hintText: 'Address Title',
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                                visible: _validate1 == true ? true : false,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 40, 0),
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
                              _isFavorited = false;
                            });
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 15, 40, 0),
                              child: Row(
                                children: [
                                  Text('Address Type'),
                                  Flexible(
                                    flex: 1,
                                    child: IconButton(
                                      icon: (_isFavorited
                                          ? Icon(Icons.check_circle_outline)
                                          : Icon(Icons.radio_button_off)),
                                      color: Colors.orange,
                                      onPressed: _toggleFavorite,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Transform(
                                      transform: Matrix4.translationValues(
                                          -8, 0.0, 0.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _isFavorited = true;
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
                                      icon: (_isFavorited
                                          ? Icon(Icons.radio_button_off)
                                          : Icon(Icons.check_circle_outline)),
                                      color: Colors.orange,
                                      onPressed: _toggleFavorite1,
                                    ),
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: Transform(
                                          transform: Matrix4.translationValues(
                                              -8, 0.0, 0.0),
                                          child: Text('Work'))),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                          child: TextFormField(
                            controller: _text2,
                            onEditingComplete: () => node.nextFocus(),
                            validator: (String value) {
                              if (value.isEmpty) {
                                _validate2 = true;
                                return;
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _validate2 = false;
                                // Resets the error
                              });
                            },
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF0D3451))),
                              hintText: ' Name',
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                                visible: _validate2 == true ? true : false,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 40, 0),
                                  child: Text(
                                    'Please enter Name',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                          child: Visibility(
                            visible: _isFavorited == false,
                            child: TextFormField(
                              controller: _text3,
                              onEditingComplete: () => node.nextFocus(),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  _validate3 = true;
                                  return;
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _validate3 = false;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Company Name',
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF0D3451))),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                                visible:
                                    _validate3 == true && _isFavorited == false
                                        ? true
                                        : false,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 40, 0),
                                  child: Text(
                                    'Please enter Company Name',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                          child: TextFormField(
                            controller: _text4,
                            onEditingComplete: () => node.nextFocus(),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF0D3451))),
                            ),
                            validator: (String value) {
                              String pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = new RegExp(pattern);
                              if (value.isEmpty) {
                                _validate4 = true;
                              } else if (!regex.hasMatch(value)) {
                                _validate4 = true;
                              }

                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                String pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value)) {
                                  _validate4 = true;
                                } else {
                                  _validate4 = false;
                                }
                              });
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                                visible: _validate4 == true ? true : false,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 40, 0),
                                  child: Text(
                                    'Please enter Valid Email',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: ButtonTheme(
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF0D3451))),
                                    ),
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                    icon: Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                    value: dropdownValue,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dropdownValue = newValue;
                                      });
                                    },
                                    onTap: () => myFocusNode.requestFocus(),
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
                                  controller: _text5,
                                  focusNode: myFocusNode,
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: () => node.nextFocus(),
                                  keyboardType: TextInputType.number,
                                  validator: (String value) {
                                    String pattern =
                                        r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                    RegExp regex = new RegExp(pattern);

                                    if (value.isEmpty) {
                                      _validate5 = true;
                                      return;
                                    } else if (!regex.hasMatch(value)) {}
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _validate5 = false;
                                      // Resets the error
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Mobile Number',
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF0D3451))),
                                    contentPadding: EdgeInsets.only(
                                        left: 11, right: 3, top: 0, bottom: 0),
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
                                visible: _validate5 == true ? true : false,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 40, 0),
                                  child: Text(
                                    'Please enter Mobile No',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                          child: TextFormField(
                            controller: _text6,
                            onEditingComplete: () => node.nextFocus(),
                            keyboardType: TextInputType.streetAddress,
                            validator: (String value) {
                              if (value.isEmpty) {
                                _validate6 = true;
                                return;
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _validate6 = false;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Building Name and Number',
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF0D3451))),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                                visible: _validate6 == true ? true : false,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 40, 0),
                                  child: Text(
                                    'Please enter Building Name and No',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                  child: TextFormField(
                                controller: _text7,
                                onEditingComplete: () => node.nextFocus(),
                                keyboardType: TextInputType.number,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    _validate7 = true;
                                    return;
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _validate7 = false;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'Street No',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF0D3451))),
                                ),
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                  child: TextFormField(
                                controller: _text8,
                                onEditingComplete: () => node.nextFocus(),
                                keyboardType: TextInputType.number,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    _validate8 = true;
                                    return;
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _validate8 = false;
                                    // Resets the error
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'Zone No',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF0D3451))),
                                ),
                              ))
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Visibility(
                                visible: _validate7 == true ? true : false,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 0, 0),
                                  child: Text(
                                    'Please enter Street No',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )),
                            Visibility(
                                visible: _validate8 == true ? true : false,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 40, 0),
                                  child: Text(
                                    'Please enter Zone No',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                          child: TextFormField(
                            controller: _text9,
                            onEditingComplete: () => node.nextFocus(),
                            validator: (String value) {
                              if (value.isEmpty) {
                                _validate9 = true;
                                return;
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _validate9 = false;
                                // Resets the error
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'City',
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF0D3451))),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                                visible: _validate9 == true ? true : false,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 40, 0),
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
                            padding: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                            child: DropdownButtonFormField(
                              hint: Text('Select Country'),
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF0D3451))),
                              ),
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              value: _myselection,
                              onChanged: (newValue) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                setState(() {
                                  _myselection = newValue;
                                  _validate10 = false;
                                });
                              },
                              validator: (String value) {
                                if (value == null) {
                                  _validate10 = true;
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
                                          margin: EdgeInsets.only(left: 10),
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
                                visible: _validate10 == true ? true : false,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 40, 0),
                                  child: Text(
                                    'Please Choose your Country',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10)
                            ],
                            focusNode: FocusNode(canRequestFocus: true),
                            onEditingComplete: () => node.nextFocus(),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Alternate Phone Number(Optional)',
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF0D3451))),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 15, 40, 0),
                          child: Row(
                            children: [
                              IconButton(
                                icon: (_isFavorited2
                                    ? Icon(Icons.radio_button_off)
                                    : Icon(Icons.check_circle_outline)),
                                color: Colors.orange,
                                onPressed: _toggleFavorite2,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isFavorited2 =
                                          _isFavorited2 == false ? true : false;
                                    });
                                  },
                                  child: Text('Billing Address is Different')),
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
      ),
      persistentFooterButtons: <Widget>[
        Container(
          height: height * 0.08,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonTheme(
                child: RaisedButton(
                  padding: EdgeInsets.zero,
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
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
                    print('hi');
                  },
                ),
              ),
              ButtonTheme(
                child: RaisedButton(
                  padding: EdgeInsets.zero,
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                      _text1.text.isEmpty
                          ? _validate1 = true
                          : _validate1 = false;

                      _text2.text.isEmpty
                          ? _validate2 = true
                          : _validate2 = false;

                      _text3.text.isEmpty && _isFavorited == false
                          ? _validate3 = true
                          : _validate3 = false;

                      _text4.text.isEmpty
                          ? _validate4 = true
                          : _validate4 = false;

                      _text5.text.isEmpty
                          ? _validate5 = true
                          : _validate5 = false;

                      _text6.text.isEmpty
                          ? _validate6 = true
                          : _validate6 = false;

                      _text7.text.isEmpty
                          ? _validate7 = true
                          : _validate7 = false;

                      _text8.text.isEmpty
                          ? _validate8 = true
                          : _validate8 = false;

                      _text9.text.isEmpty
                          ? _validate9 = true
                          : _validate9 = false;

                      _myselection == null
                          ? _validate10 = true
                          : _validate10 = false;

                      if (_validate1 == true) {
                        print('Form Contains Error');
                      } else if (_validate2 == true) {
                        print('Form Contains Error');
                      } else if (_validate4 == true) {
                        print('Form Contains Error');
                      } else if (_validate5 == true) {
                        print('Form Contains Error');
                      } else if (_validate6 == true) {
                        print('Form Contains Error');
                      } else if (_validate7 == true) {
                        print('Form Contains Error');
                      } else if (_validate8 == true) {
                        print('Form Contains Error');
                      } else if (_validate9 == true) {
                        print('Form Contains Error');
                      } else if (_validate10 == true) {
                        print('Form Contains Error');
                      } else {
                        print('ok');
                      }
                    });
                    if (_isFavorited == false) {
                      if (_validate3 == true) {
                        print('Please enter Company name');
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
