import 'package:flutter/material.dart';
import 'package:polyglapp/main.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(
        seconds: 5,
        image: Image.network('https://www.pngkit.com/png/full/34-344102_world-icon-png.png'),
        photoSize: 100.0,
        title: Text("Polyglapp", style: TextStyle(color: Colors.grey, fontSize: 30)),
        navigateAfterSeconds: MainPage()
      ),
    );
  }
}