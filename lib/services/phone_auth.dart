import 'package:Crew/components/crew_alert_dialog.dart';
import 'package:Crew/theme/icons/crew_icons_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Crew/screens/02-Home-Screen/home_screen.dart';

class PhoneAuth {
  static Future registerUser(String mobile, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 120),
        verificationCompleted: (AuthCredential authCredential) {
          _auth.signInWithCredential(authCredential).then((result) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
            _showWelcomeDialog(context);
            print('Auth succeed!');
          }).catchError((e) {
            print(e);
          });
        },
        verificationFailed: (FirebaseAuthException authException) {
          print(authException.message);
          final snackBar =
              SnackBar(content: Text('The phone number is incorrect!'));
          Scaffold.of(context).showSnackBar(snackBar);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          final _codeController = TextEditingController();
          showDialog(
            context: context,
            child: CrewAlertDialog(
              heightRegulation: -50,
              title: Text(
                'Provide the code you received by SMS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Theme.of(context).primaryColor,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  fontSize: 25,
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Material(
                  child: TextFormField(
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[300])),
                      filled: false,
                      hintText: "Code from SMS",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade300),
                    ),
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              actions: Container(
                width: double.infinity,
                child: FlatButton(
                  child: Text(
                    "VERIFY",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onPressed: () {
                    FirebaseAuth auth = FirebaseAuth.instance;

                    var smsCode = _codeController.text.trim();

                    var _credential = PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: smsCode,
                    );
                    auth.signInWithCredential(_credential).then((result) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                      _showWelcomeDialog(context);
                      print('Auth Succeed!');
                    }).catchError((e) {
                      print(e);
                    });
                  },
                ),
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        });
  }

  static void _showWelcomeDialog(BuildContext context) {
    showDialog(
        context: context,
        child: CrewAlertDialog(
          heightRegulation: 60,
          title: Text(
            'Welcome!',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Theme.of(context).primaryColor,
              fontFamily: GoogleFonts.roboto().fontFamily,
              fontSize: 45,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              'How it works',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Theme.of(context).disabledColor,
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontSize: 25,
              ),
            ),
          ),
          content: Material(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: Icon(
                    CrewIcons.shopping_basket,
                    color: Theme.of(context).accentColor,
                    size: 30,
                  ),
                  title: Text(
                    'Make a purchase',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Theme.of(context).primaryColor,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: Icon(
                    CrewIcons.receipt,
                    color: Theme.of(context).accentColor,
                    size: 30,
                  ),
                  title: Text(
                    'Upload a receipt',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Theme.of(context).primaryColor,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: Icon(
                    CrewIcons.gift,
                    color: Theme.of(context).accentColor,
                    size: 30,
                  ),
                  title: Text(
                    'Earn rewards',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Theme.of(context).primaryColor,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: Container(
            width: double.maxFinite,
            child: FlatButton(
              child: Text(
                "GOT IT",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ));
  }
}
