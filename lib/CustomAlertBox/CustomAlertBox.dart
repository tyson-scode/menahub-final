import 'package:flutter/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

errorAlert({BuildContext context, String errorMessage}) {
  Alert(
    context: context,
    title: "",
    desc: errorMessage,
  ).show();
}
