import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:menahub/SplashScreen/SplashScreen.dart';
import 'package:menahub/translation/codegen_loader.g.dart';
import 'package:menahub/translation/locale_keys.g.dart';
import 'package:http/http.dart' as http;
import 'package:menahub/Util/Api/ApiCalls.dart';
import 'package:menahub/Util/Api/ApiUrls.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("FirebaseMessaging Handling a background message ${message.data}");
  print("FirebaseMessaging Handling a background message ${message.messageId}");

  log('FirebaseMessaging FirebaseMessaging: ${jsonEncode(message.notification)}');
}

Future<void> _createNotificationChannel(
    String id, String name, String description) async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var androidNotificationChannel = AndroidNotificationChannel(
    id,
    name,
    description,
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidNotificationChannel);
}
AndroidNotificationChannel channel;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  _createNotificationChannel('Test1', 'SamPle', 'MENHUB');

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  ///

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // await Permission.camera.request();
  // await Permission.microphone.request();
  // await Permission.storage.request();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);
    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();
      serviceWorkerController.serviceWorkerClient = AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      );
    }
  }
  runApp(
    EasyLocalization(
      // saveLocale: true,
      child: MyApp(),
      supportedLocales: [Locale('en'), Locale('ar')],
      fallbackLocale: Locale('en'),
      path: 'assets/language',
      assetLoader: CodegenLoader(),
    ),
  );
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

/*
return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
*/
class OrderStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              fit: StackFit.loose,
              children: <Widget>[
                Container(
                  height: height / 2.5,
                  width: width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                        const Color(0xFFE28542),
                        const Color(0xFFE7852F),
                        const Color(0xFFF69402),
                      ]),
                      border: Border(),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(height / 2),
                          bottomRight: Radius.circular(height / 2))),
                ),
                Container(
                  height: height / 4,
                  margin: EdgeInsets.all(30),
                  child: Image(
                    image: AssetImage('assets/order/orderStatus.png'),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  child: Container(
                    height: height / 5,
                    child: Image(
                      image: AssetImage('assets/order/delivery.png'),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Text(
                          'Order Request Successful',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Text(
                          'Thanks for your Order Request',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: height * 0.04,
                width: width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Order Request Summary',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(
                thickness: 2,
              ),
            ),
            Container(
              height: height * 0.04,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Request ID :',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' #MH3687',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(
                thickness: 2,
              ),
            ),
            Container(
              height: height * 0.04,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Order Date:',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' 12/01/2021',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(
                thickness: 2,
              ),
            ),
            Container(
              height: height * 0.04,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Store:',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Qatar',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(
                thickness: 2,
              ),
            ),
            Container(
              height: height * 0.04,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Order Request:',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Pending',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(
                thickness: 2,
              ),
            ),
            Container(
              height: height * 0.04,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          'Ship To:',
                          style: TextStyle(fontSize: 12),
                        ),
                      )),
                  Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Text(
                          ' Alwab Area,Khaliji 11 Street,Doha 12962, Qatar',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(
                thickness: 2,
              ),
            ),
            Container(
              height: height * 0.04,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          'Billing To:',
                          style: TextStyle(fontSize: 12),
                        ),
                      )),
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Text(
                        ' Alwab Area,Khaliji 11 Street,Doha 12962, Qatar',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(
                thickness: 2,
              ),
            ),
            Container(
              height: height / 4,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonTheme(
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      padding: EdgeInsets.zero,
                      color: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            gradient: LinearGradient(colors: <Color>[
                              const Color(0xFFE07C24),
                              const Color(0xFFF69402),
                              const Color(0xFFF5BB2A),
                            ])),
                        child: Text(
                          'View More Order Details',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  ButtonTheme(
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      padding: EdgeInsets.zero,
                      color: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            gradient: LinearGradient(colors: <Color>[
                              const Color(0xFF103D52),
                              const Color(0xFF304C58),
                              const Color(0xFF2C5466),
                              const Color(0xFF4F7180),
                            ])),
                        child: Text(
                          'Back To Shopping',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
    getuserToken();
    _messaging.getInitialMessage().then((RemoteMessage message) {
      print('FirebaseMessaging getInitialMessage listen ${message}');

      if (message != null) {
        log('FirebaseMessaging getInitialMessage: ${jsonEncode(message.senderId)}');
        print(
            'FirebaseMessaging getInitialMessage: ${jsonEncode(message.data)}');
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('FirebaseMessaging new onMessage listen${message.messageType}');

      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      print('FirebaseMessaging new onMessage listen${message.senderId}');
      if (notification != null && android != null) {
        if (message.data != null) {
          log('FirebaseMessaging onMessage: ${jsonEncode(message.data)}');
        }
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //FCM Handling
      if (message.data != null) {
        log('FirebaseMessaging onMessageOpenedApp: ${jsonEncode(message.data)}');
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(message.notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(message.notification.body)],
                  ),
                ),
              );
            });
      }
    });
    // ignore: missing_return
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) {
      print('FirebaseMessaging new onMessage listen${message.messageType}');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      print('FirebaseMessaging new onMessage listen${message.senderId}');
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(message.notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(message.notification.body)],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: Locale(context.locale.languageCode),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }

  void getuserToken() async {
    _messaging.getToken().then((token) async {
      SharedPreferences preference = await SharedPreferences.getInstance();
      await preference.setString("firebasetoken", token.toString());
      print(preference.getString("firebasetoken"));
      print('Token: $token');
      log('Token: $token');
    }).catchError((e) {
      print(e);
    });
  }
}
