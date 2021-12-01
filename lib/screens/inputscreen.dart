import 'dart:io';

import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:international_space_registry/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:async';
import 'package:international_space_registry/screens/mainview.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_settings/system_settings.dart';
import 'package:video_player/video_player.dart';
import 'package:location/location.dart';

final String TERMS_CONDITIONS="terms";
class input_Screen extends StatefulWidget {
  const input_Screen({Key? key}) : super(key: key);

  //final InAppBrowser browser = new MyInAppBrowser();
  @override
  _input_ScreenState createState() => _input_ScreenState();
}

class _input_ScreenState extends State<input_Screen> {

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var options = InAppBrowserClassOptions(
    crossPlatform: InAppBrowserOptions(hideUrlBar: true),
    inAppWebViewGroupOptions: InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(javaScriptEnabled: true),
    ),
  );
  //String _authStatus = 'Unknown';
  String searchid = '';
  String url = "";
  late InAppBrowser browser = new InAppBrowser();

  /*Future<void> initPlugin() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      TrackingStatus status =
      await AppTrackingTransparency.trackingAuthorizationStatus;
      setState(() => _authStatus = '$status');
      // If the system can show an authorization request dialog
      if (status == TrackingStatus.notDetermined||status == TrackingStatus.denied) {
        await Future.delayed(const Duration(milliseconds: 200));
        await _checkLocation();
        if (await showCustomTrackingDialog(context)) {
          await Future.delayed(const Duration(milliseconds: 200));
          TrackingStatus status=
          await AppTrackingTransparency.requestTrackingAuthorization();
          setState(() => _authStatus = '$status');
        }
      }else{
        _checkLocation();
      }
    } on PlatformException {
      setState(() => _authStatus = 'PlatformException was thrown');
    }
    print(_authStatus);
  }*/


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLocation();
    // WidgetsBinding.instance!.addPostFrameCallback((_) => initPlugin());
    /*Timer(
      Duration(seconds: 1),
          () async {
        _chcekShared();
      },
    );*/
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    double component_height = height / 18;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("images/Background.png"),
              ),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 100,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Container(
                        margin: EdgeInsets.only(left: 8),
                        height: height / 10.5,
                        width: height / 10.5,
                        child: Image(
                          image: AssetImage(
                            'images/logo_large.png',
                          ),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    OpacityAnimatedWidget.tween(
                      opacityEnabled: 1,
//define start value
                      opacityDisabled: 0,
//and end value
                      enabled: true,
//bind with the boolean
                      duration: Duration(milliseconds: 1500),
                      child: Text(
                        'Universe Star Finder 3D',
                        style: TextStyle(
                          fontSize: width / 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Agne',
                        ),
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: OpacityAnimatedWidget.tween(
                    opacityEnabled: 1,
//define start value
                    opacityDisabled: 0,
//and end value
                    enabled: true,
//bind with the boolean
                    duration: Duration(milliseconds: 1500),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10.0, right: 10),
                              width: width / 1.4,
                              height: component_height,
                              child: TextField(
                                //textAlign: TextAlign.center,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(color: Colors.black),
                                onChanged: (value) {
                                  searchid = value;
                                },
                                decoration: KInputDecoratioon,
                              ),
                            ),
                            Container(
                              height: component_height,
                              margin: EdgeInsets.only(right: 10),
                              child: Material(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20.0),
                                elevation: 5.0,
                                child: MaterialButton(
                                  minWidth: width / 5,
                                  height: component_height,
                                  onPressed: () => _checkConnectivity(context),
                                  child: Text(
                                    'Suche!',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: component_height,
                          child: Material(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20.0),
                            elevation: 5.0,
                            child: MaterialButton(
                              minWidth: width / 2,
                              height: component_height,
                              onPressed: () => _checkConnectivity(context),
                              child: Text(
                                'Überspringen>>',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
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
        ],
      ),
    );
  }

  /* _checkTracking()async{
    TrackingStatus status=await AppTrackingTransparency.trackingAuthorizationStatus;
    if(Platform.isAndroid)
      await _checkConnectivity(context);
    else{
    if(status==TrackingStatus.authorized) await _checkConnectivity(context);
      else _showDialogue(context,DialogType.INFO,'Um effiziente und genaue Ergebnisse zu erzielen und alle Funktionen der App nutzen zu können, müssen Sie das Tracking zulassen.\nGehen Sie zu Einstellungen und erlauben Sie Tracking!','Sie Tracking');
    }
}*/

  Future<dynamic> _checkConnectivity(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _showDialogue(context, DialogType.WARNING,
          'Überprüfen Sie Ihre Geräteverbindung und versuchen Sie es erneut!',
          'Kein Internet!');
    } else {
      return Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.leftToRight,
            child: searchid.isEmpty
                ? MainView(id: '')
                : MainView(
              id: searchid,
            )),
      );
    }
  }

  _showDialogue(BuildContext context, DialogType type, String desc,
      String title) {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: type,
      btnOkText: 'Einstellungen öffnen',
      dismissOnTouchOutside: false,
      title: title,
      desc: desc,
      btnOkOnPress: () {
        SystemSettings.system();
      },
    )
      ..show();
  }

/* Future<bool> showCustomTrackingDialog(BuildContext context) async =>
      await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('DATENSCHUTZ-BESTIMMUNGEN'),
          content: const Text(
            'Durch die Verwendung von Universe Star Finder 3D stimmen Sie unserer Datenschutzrichtlinie zu.\nSie müssen unsere Richtlinien akzeptieren, um die App zu verwenden.\nSie können Ihre Auswahl jederzeit in den App-Einstellungen ändern.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                browser.openUrlRequest(
                    urlRequest: URLRequest(url: Uri.parse("https://space-registry.org/de/app-privacy-policy")),
                    options: options);
              },
              child: const Text("POLITIK",style: TextStyle(color: Colors.blue),),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context, true);
                //_checkLocation();
              },
              child: const Text('ANNEHMEN'),
            ),
          ],
        ),
      ) ??
          false;
*/
}
    _checkLocation()async{
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  _locationData = await location.getLocation();
}
