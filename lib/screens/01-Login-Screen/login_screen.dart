import 'package:Crew/screens/01-Login-Screen/components/login_screen_body.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: LoginScreenBody(),
    );
  }
}
