import 'package:html/parser.dart';

bool emailvalidation({String email}) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return emailValid;
}

bool passwordvalidation({String password}) {
  bool passwordvalid =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
          .hasMatch(password);
  return passwordvalid;
}

// remove html tags
String removeHtmlFromString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body.text).documentElement.text;
  return parsedString;
}

bool isInteger(num value) => value is int || value == value.roundToDouble();

typedef AddToCartCallback = void Function(dynamic onstate, bool status);

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
