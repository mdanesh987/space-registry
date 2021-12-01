import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/foundation.dart';

class MainView extends StatefulWidget {
  //static SurfaceAndroidWebView platform;
  final id;
  const MainView({Key? key,this.id}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int indx=0;
  String url='https://software.space-registry.org/app-view/de/';
  final GlobalKey webViewKey = GlobalKey();
  late InAppWebView _webView;
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      //disableHorizontalScroll: true,
      cacheEnabled: true,
      //disableVerticalScroll: true,
      useShouldOverrideUrlLoading: true,
      javaScriptEnabled: true,
      mediaPlaybackRequiresUserGesture: true,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
      clearSessionCache: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
      //isPagingEnabled: true,
    ),
  );




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    indx=0;
    String id=widget.id;
    _webView=InAppWebView(
      key: webViewKey,
      initialUrlRequest: URLRequest(
        url: id!=''
            ? Uri.parse(
            'https://software.space-registry.org/app-view/de/registry/$id/')
            : Uri.parse(url),
        //url:Uri.parse(url),
      ),
      initialOptions: options,

      // ignore: non_constant_identifier_names
      onLoadStop: (InAppWebViewController,Uri){
        setState(() {
          indx=0;
        });
      },
      onLoadStart: (InAppWebViewController,Uri){
        setState(() {
          indx=1;
        });
      },
      onWebViewCreated: (controller) {
        webViewController = controller;
      },


    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    // webViewController?.stopLoading();
    //options.crossPlatform.cacheEnabled=false;
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: IndexedStack(
        index: indx,
        children: [
          Container(
            child: _webView,
          ),
          Container(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.transparent,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
