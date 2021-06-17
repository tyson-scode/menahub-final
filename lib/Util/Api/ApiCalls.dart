import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:menahub/SignIn_SignUp_Flow/SignInScreen/SignInScreen.dart';
import 'ApiResponseModel.dart';

Future<ApiResponseModel> getApiCall({
  String getUrl,
  Map<String, String> headers,
  BuildContext context,
}) async {
  //print("getApiCall: " + getUrl);
  //print("Headers: " + headers.toString());
  http.Response response = await http.get(
    Uri.parse(getUrl),
    headers: headers,
  );
  var jsonResponse = json.decode(response.body);
  if (response.statusCode == 401) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => SignIn(),
      ),
    );
  } else if (response.statusCode == 200) {
    return ApiResponseModel(responseValue: jsonResponse, statusCode: 200);
  } else {
    //print('Response status: ${response.body}');
    //return ApiResponseModel(responseValue: jsonResponse, statusCode: 400);
  }
}

Future<ApiResponseModel> postApiCall({
  String postUrl,
  body,
  Map<String, String> headers,
  BuildContext context,
}) async {
 print("PostApiCall: " + postUrl);
  print('body');
  print(body);
  http.Response response = await http.post(
    Uri.parse(postUrl),
    body: body,
    headers: headers,
  );

  var jsonResponse = json.decode(response.body);
  if (response.statusCode == 401) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => SignIn(),
      ),
    );
  } else if (response.statusCode == 200) {
    return ApiResponseModel(statusCode: 200, responseValue: jsonResponse);
  } else {
    return ApiResponseModel(statusCode: 400, responseValue: jsonResponse);
  }
}

Future<ApiResponseModel> putApiCall({
  String postUrl,
  body,
  Map<String, String> headers,
  BuildContext context,
}) async {
  //print("PutApiCall: " + postUrl);
  // print("Headers: " + headers.toString());
  //print("body: " + body);
  http.Response response = await http.put(
    Uri.parse(postUrl),
    body: body,
    headers: headers,
  );
  var jsonResponse = json.decode(response.body);
  if (response.statusCode == 401) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => SignIn(),
      ),
    );
  } else if (response.statusCode == 200) {
    return ApiResponseModel(statusCode: 200, responseValue: jsonResponse);
  } else {
    return ApiResponseModel(statusCode: 400, responseValue: jsonResponse);
  }
}

Future<ApiResponseModel> deleteApiCall({
  String postUrl,
  body,
  Map<String, String> headers,
  BuildContext context,
}) async {
  // print("DeleteApiCall: " + postUrl);
  // print("Headers: " + headers.toString());
  // print("body: " + body);
  http.Response response = await http.delete(
    Uri.parse(postUrl),
    body: body,
    headers: headers,
  );
  var jsonResponse = json.decode(response.body);
  if (response.statusCode == 401) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => SignIn(),
      ),
    );
  } else if (response.statusCode == 200) {
    return ApiResponseModel(statusCode: 200, responseValue: jsonResponse);
  } else {
    return ApiResponseModel(statusCode: 400, responseValue: jsonResponse);
  }
}
