import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:international_space_registry/screens/Splash.dart';

void main() async{
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
    );
  }
}
