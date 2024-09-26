import 'package:clean_app/MainMenu.dart';
import "package:flutter/material.dart";
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() => runApp(MyApp());

//checking git push
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AnimatedSplashScreen(
          duration: 2500,
          splash: Image.asset('splash.png'),
          splashIconSize: 210,
          nextScreen: MainMenu(),
          splashTransition: SplashTransition.fadeTransition,
          // pageTransitionType: PageTransitionType.scale,
          backgroundColor: Colors.amber),
    );
  }
}
