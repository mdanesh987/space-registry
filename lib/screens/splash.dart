import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:international_space_registry/screens/inputscreen.dart';
import 'package:video_player/video_player.dart';
import 'package:international_space_registry/constants.dart';
import 'package:page_transition/page_transition.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late VideoPlayerController _controller;


  @override
  void initState() {
    // TODO: implement initState
    //SystemChrome.setEnabledSystemUIOverlays([]);

    super.initState();
    Timer(
      Duration(seconds: 6),
          () async {
        //_controller.dispose();
        Navigator.pushReplacement(
          context,
          PageTransition(type: PageTransitionType.leftToRight, child: input_Screen(),),
        );
      },
    );
    _controller = VideoPlayerController.asset('video/back2.mp4')
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller.play();
        //_controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
    //_img = AssetImage('images/backgrnd.jpg');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
          //alignment: Alignment.topCenter,
          children: [
            //VideoPlayer(_controller),
            SizedBox.expand(
              child: FittedBox(
                // If your background video doesn't look right, try changing the BoxFit property.
                // BoxFit.fill created the look I was going for.
                fit: BoxFit.fill,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            Center(
              child: OpacityAnimatedWidget.tween(
                duration: Duration(milliseconds: 3500),
                opacityEnabled: 1,
//define start value
                opacityDisabled: 0,
//and end value
                enabled: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Container(
                        width: 120.0,
                        height: 120.0,
                        child: Image(
                          color: Colors.white,
                          image: AssetImage('images/logo_large.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Universe Star Finder 3D',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Agne',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
