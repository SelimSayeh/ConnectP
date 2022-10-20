import 'package:flutter/material.dart';
import 'package:omnichannelplus/src/views/login_page.dart';
import 'package:splash_screen_view/SplashScreenView.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget splashScreen = SplashScreenView(
      navigateRoute: LoginPage(),
      duration: 5000,
      imageSize: 450,
      imageSrc: "assets/images/logo.png",
      backgroundColor: Colors.white,
    );

    return MaterialApp(
      home: splashScreen,
    );
  }
}
