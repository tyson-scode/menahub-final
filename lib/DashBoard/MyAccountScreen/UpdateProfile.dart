import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:menahub/CustomAlertBox/CustomAlertBox.dart';
import 'package:menahub/CustomWidget/CustomButton.dart';
import 'package:menahub/CustomWidget/CustomTextBox.dart';
import 'package:menahub/DashBoard/MyAccountScreen/MyAccountScreen.dart';
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiResponseModel.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:menahub/config/AppLoader.dart';
import 'package:menahub/config/CustomLoader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({this.userProfile});
  final Map userProfile;
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final formKey = new GlobalKey<FormState>();
  TextEditingController firstNameTextfield = TextEditingController();
  TextEditingController lastNameTextfield = TextEditingController();
  TextEditingController emailTextfield = TextEditingController();
  TextEditingController passwordTextfield = TextEditingController();
  TextEditingController mobileTextfield = TextEditingController();
  bool _autoValidate = false;
  String countryCode = "+91";
  String gender;
  int genderID;

  String userType;

  updateProfile() async {
    final overlay = LoadingOverlay.of(context);
    overlay.show();
    var body = jsonEncode({
      "customer": {
        "id": widget.userProfile["id"],
        "group_id": widget.userProfile["group_id"],
        "default_billing": widget.userProfile["default_billing"],
        "default_shipping": widget.userProfile["default_shipping"],
        "created_in": "Default Store View",
        "email": emailTextfield.text,
        "firstname": firstNameTextfield.text,
        "lastname": lastNameTextfield.text,
        "gender": genderID,
        "store_id": widget.userProfile["store_id"],
        "website_id": widget.userProfile["website_id"],
        "addresses": widget.userProfile["addresses"],
        "disable_auto_group_change": 0,
        "extension_attributes": widget.userProfile["extension_attributes"],
        "custom_attributes": [
          {"attribute_code": "profile_picture", "value": null},
          {"attribute_code": "app_id", "value": null},
          {"attribute_code": "fcm_token", "value": null},
          {"attribute_code": "device_type", "value": null},
          {"attribute_code": "push_status", "value": null},
          {"attribute_code": "rewards_subscription", "value": "1"},
          {"attribute_code": "mst_rewards_tier_id", "value": "1"},
          {"attribute_code": "mobilenumber", "value": mobileTextfield.text},
          {"attribute_code": "mobilenumber_code", "value": countryCode}
        ]
      }
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token",
    };
    ApiResponseModel responseData = await putApiCall(
        postUrl: updateProfileApi,
        body: body,
        headers: headers,
        context: context);
    Navigator.of(context).pop();
    Map data = responseData.responseValue;
    List customAttributes = data["custom_attributes"];
    Map extensionAttributes = data["extension_attributes"];
    if (responseData.statusCode == 200) {
      // print(responseData.responseValue);

      overlay.hide();
      print("Update Profile");
      print("Account Details = $data");
      print("extensionAttributes Details = $extensionAttributes");

      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => MyAccountScreen(),
      //   ),
      // );

      Navigator.of(context).maybePop();
    } else {
      overlay.hide();
      Navigator.of(context).pop();
      Map response = responseData.responseValue;
      String errorMessage = response["message"];
      errorAlert(context: context, errorMessage: errorMessage);
      print(errorMessage);
    }
  }

  @override
  void initState() {
    super.initState();
    genderID = widget.userProfile["gender"];
    // print("genderID: $genderID");
    if (genderID == 1) {
      gender = 'Female';
    } else {
      gender = 'Male';
    }
    List customAttributes = widget.userProfile["custom_attributes"];
    Map extensionAttributes = widget.userProfile["extension_attributes"];

    int mobilenumberIndex = customAttributes
        .indexWhere((f) => f['attribute_code'] == "mobilenumber");
    int mobilenumberCodeIndex = customAttributes
        .indexWhere((f) => f['attribute_code'] == "mobilenumber_code");
    Map mobilenumberIndexMap = customAttributes[mobilenumberIndex];
    Map mobilenumberCodeIndexMap = customAttributes[mobilenumberCodeIndex];
    String mobileNumber = mobilenumberIndexMap["value"];
    firstNameTextfield.text = widget.userProfile["firstname"].toString();
    lastNameTextfield.text = widget.userProfile["lastname"].toString();
    emailTextfield.text = widget.userProfile["email"].toString();
    mobileTextfield.text = mobileNumber;
    countryCode = mobilenumberCodeIndexMap["value"];
    print("init = $extensionAttributes");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: Locale(context.locale.languageCode),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          title: Image.asset(
            "assets/icon/appTopLogo.png",
            height: 30,
          ),
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: blackColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
        ),
        body:
            // widget.userProfile == null
            //     ? Center(
            //         child: CustomerLoader(
            //           dotType: DotType.circle,
            //           dotOneColor: secondaryColor,
            //           dotTwoColor: primaryColor,
            //           dotThreeColor: Colors.red,
            //           duration: Duration(milliseconds: 1000),
            //         ),
            //       )
            //     :
            Container(
          color: backGroudColor,
          height: double.infinity,
          width: double.infinity,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                // ignore: deprecated_member_use
                autovalidate: _autoValidate,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Update Account",
                            style: TextStyle(
                                fontSize: 20,
                                color: lightGreyColor,
                                fontWeight: FontWeight.w500),
                          ),
                          sizedBoxheight20,
                          customTextBox(
                            icons: "assets/icon/profileIcon.png",
                            hintText: "Full Name",
                            controller: firstNameTextfield,
                          ),
                          sizedBoxheight10,
                          customTextBox(
                            icons: "assets/icon/profileIcon.png",
                            hintText: "Last Name",
                            controller: lastNameTextfield,
                          ),
                          sizedBoxheight10,
                          customTextBox(
                            enabled: false,
                            icons: "assets/icon/emailIcon.png",
                            hintText: "Email",
                            controller: emailTextfield,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          sizedBoxheight10,
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            elevation: 2,
                            child: Container(
                              height: 60,
                              margin: EdgeInsets.only(left: 20, right: 10),
                              child: DropdownButtonFormField<String>(
                                validator: (value) =>
                                    value == null ? 'Select Gender' : null,
                                hint: Text(
                                  'Select Gender',
                                  style: TextStyle(fontSize: 16),
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                ),
                                style: Theme.of(context).textTheme.subtitle1,
                                value: gender,
                                onChanged: (String newValue) {
                                  setState(() {
                                    gender = newValue;
                                    //print(" GENDER = $gender");
                                    int genid = gender == "Male" ? 0 : 1;

                                    genderID = genid;
                                  });
                                },
                                items: [
                                  DropdownMenuItem(
                                    child: Text('Male'),
                                    value: 'Male',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Female'),
                                    value: 'Female',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          sizedBoxheight10,
                          Card(
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
                                      "assets/icon/phoneIcon.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    sizedBoxwidth10,
                                    DropdownButton<String>(
                                      underline: Container(),
                                      value: countryCode,
                                      items: <String>['+91', '+974']
                                          .map((String value) {
                                        return new DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(
                                            value,
                                            style: TextStyle(),
                                          ),
                                        );
                                      }).toList(),
                                      // onChanged: (value) {
                                      //   setState(() {
                                      //     countryCode = value;
                                      //   });
                                      // },
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        enabled: false,
                                        controller: mobileTextfield,
                                        keyboardType: TextInputType.phone,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          hintText: "Mobile Number",
                                          hintStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: greyColor,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter Mobile Number';
                                          }
                                          return null;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          sizedBoxheight20,
                          // customTextBox(
                          //     icons: "assets/icon/otpIcon.png",
                          //     hintText: "OTP"),
                          // sizedBoxheight20,
                          InkWell(
                            onTap: () {
                              if (formKey.currentState.validate()) {
                                updateProfile();
                              } else {
                                setState(() {
                                  _autoValidate = true;
                                });
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: customButton(
                                  title: "UPDATE",
                                  backgroundColor: primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    sizedBoxheight20,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
