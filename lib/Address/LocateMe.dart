import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_map_location_picker/generated/l10n.dart'
    as location_picker;
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:menahub/config/i18n.dart';

class LocateMe extends StatefulWidget {
  @override
  _LocateMeState createState() => _LocateMeState();
}

class _LocateMeState extends State<LocateMe> {
  LocationResult _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        location_picker.S.delegate,
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en', ''),
        Locale('ar', ''),
      ],
      home: Scaffold(
        body: Builder(builder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () async {
                    LocationResult result = await showLocationPicker(
                      context,
                      "AIzaSyBfKeIAyqhi4J7PVR9Rua7XXLsYJKuyQyI",
                      automaticallyAnimateToCurrentLocation: true,
                      myLocationButtonEnabled: true,
                      requiredGPS: true,
                      layersButtonEnabled: true,
                      resultCardAlignment: Alignment.bottomCenter,
                      desiredAccuracy: LocationAccuracy.best,
                    );
                    print("result = $result");
                    setState(() => _pickedLocation = result);
                  },
                  child: Text('Pick location'),
                ),
                Text(_pickedLocation.toString()),
              ],
            ),
          );
        }),
      ),
    );
  }
}
