import './SplashScreen.dart';
import './screen/History.dart';
import 'package:flutter/material.dart';
import 'screen/History.dart';
import 'screen/Recent.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dooraemi",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFFFB94E),
        iconTheme: IconThemeData(color: Colors.white)
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        "/a": (BuildContext context) => Recent(),
        "/b": (BuildContext context) => History()
      },
    );
  }
}