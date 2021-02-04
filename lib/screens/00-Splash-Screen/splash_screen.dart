import 'dart:async';

import 'package:Crew/components/logo.dart';
import 'package:Crew/screens/01-Login-Screen/login_screen.dart';
import 'package:Crew/screens/02-Home-Screen/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomeScreen() //TODO: Replace with login screen after implementing camera screen
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned(
                bottom: 70,
                left: constraints.maxWidth - 200,
                child: Logo(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  logoSize: 60,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
