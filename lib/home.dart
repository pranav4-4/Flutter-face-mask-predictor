import 'package:flutter/material.dart';
import 'package:puton_your_facemask/pagehome.dart';
import 'package:splashscreen/splashscreen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 16,
      navigateAfterSeconds: hihome(),
      title: Text(
        "Face Mask Detector",
            style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 21,
              color: Colors.black,
      ),
      ),
      image: Image.asset("assets/splash.png"),
      photoSize: 130,
      backgroundColor: Colors.white,
      loaderColor: Colors.black,
      loadingText: Text(
        "From Pranav",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
