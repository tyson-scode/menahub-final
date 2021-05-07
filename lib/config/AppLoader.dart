import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menahub/Util/ConstantData.dart';
import 'package:menahub/config/CustomLoader.dart';

class LoadingOverlay {
  BuildContext _context;

  void hide() {
    Navigator.of(_context).pop();
  }

  void show() {
    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        this._context = context;
        return _FullScreenLoader();
      },
    );
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  LoadingOverlay._create(this._context);

  factory LoadingOverlay.of(BuildContext context) {
    return LoadingOverlay._create(context);
  }
}

class _FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        // decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0)),
        child: Center(
          child: CustomerLoader(
            dotType: DotType.circle,
            dotOneColor: secondaryColor,
            dotTwoColor: primaryColor,
            dotThreeColor: Colors.red,
            duration: Duration(milliseconds: 1000),
          ),
        ),
      ),
    );
  }
}
