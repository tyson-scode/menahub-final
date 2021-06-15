import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:menahub/DashBoard/DashBoard.dart';
import 'package:menahub/OrdersInfo/OrderSuccessScreen.dart';
import 'package:easy_localization/easy_localization.dart';

class MyInAppBrowser extends InAppBrowser {
  @override
  Future onBrowserCreated() async {
    print("Browser Created!");
  }

  @override
  Future onLoadStart(url) async {
    print("Browser Started $url");
  }

  @override
  Future onLoadStop(url) async {
    print("Browser Stopped $url");
  }

  @override
  void onLoadError(url, code, message) {
    print("Browser Can't load $url.. Error: $message");
  }

  @override
  void onProgressChanged(progress) {
    print("Browser Progress: $progress");
  }

  @override
  void onExit() {
    print("Browser closed!");
  }
}

class PaymentPage extends StatefulWidget {
  final MyInAppBrowser browser = new MyInAppBrowser();

  final String url;

  PaymentPage({this.url});

  @override
  _PaymentState createState() => new _PaymentState();
}

class _PaymentState extends State<PaymentPage> {
  // InAppWebViewController webViewController;
  InAppWebViewController webViewController;
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));
  double progress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('_PaymentState ${widget.url}');
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: Locale(context.locale.languageCode),
      home: Scaffold(
          body: SafeArea(
              child: Column(children: <Widget>[
        Expanded(
          child: Stack(
            children: [
              InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                initialOptions: options,
                // pullToRefreshController: pullToRefreshController,
//                onWebViewCreated: (controller) {
//                  webViewController = controller;
//                },
                onLoadStart: (controller, url) {
                  print("onLoadStart ${controller.webStorage}");
                  print("onLoadStart url${url}");
                },
                androidOnPermissionRequest:
                    (controller, origin, resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  var uri = navigationAction.request.url;

                  return NavigationActionPolicy.ALLOW;
                },
                onLoadStop: (controller, url) async {
                  // pullToRefreshController.endRefreshing();
                  print("onLoadStop ${controller.webStorage}");
                  print("onLoadStop url${url}");
                },
                onLoadError: (controller, url, code, message) {
                  print("onLoadError ${controller.webStorage}");
                  print("onLoadError url${url}");
                  print("onLoadError message${message}");
                  print("onLoadError code${code}");

                  // pullToRefreshController.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    // pullToRefreshController.endRefreshing();
                  }
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
                onUpdateVisitedHistory: (controller, url, androidIsReload) {
                  print("onUpdateVisitedHistory ${controller.webStorage}");
                },
                onConsoleMessage: (controller, consoleMessage) {
                  print('onLoadConsoleMessage ${consoleMessage.message}');

                  try {
                    dynamic msg = json.decode(consoleMessage.message);

                    if (msg['status'] != null && msg['status']) {
//                      {"msg":"Payment Failed","status":true,"payment":false,"order_inc_id":"000445","orderid":"439"}

                      if (msg['payment']) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                OrderSuccessScreen(msg['orderid']),
                          ),
                        );
                      } else if (!msg['payment']) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                OrderSuccessScreen(msg['orderid']),
                          ),
                        );
                      } else {}
                      // Navigator.of(context).pop();
                      //  webViewController.webStorage.localStorage.webStorageType.toString();
//                      Navigator.of(context).pushReplacement(
//                        MaterialPageRoute(
//                          builder: (BuildContext context) => DashBoard(
//                            initialIndex: 0,
//                          ),
//                        ),
//                      );
                    }
                  } catch (e) {
                    //Handle all other exceptions
                  }
                },
              ),
              progress < 1.0
                  ? LinearProgressIndicator(value: progress)
                  : Container(),
            ],
          ),
        ),
      ]))),
    );
  }
}
