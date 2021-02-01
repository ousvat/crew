import 'package:Crew/screens/00-Splash-Screen/splash_screen.dart';
import 'package:Crew/theme/default_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: defaultTheme,
      home: SplashScreen(),
    );
  }
}
