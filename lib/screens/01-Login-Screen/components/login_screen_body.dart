import 'dart:ffi';

import 'package:Crew/components/crew_alert_dialog.dart';
import 'package:Crew/components/logo.dart';
import 'package:Crew/screens/02-Home-Screen/home_screen.dart';
import 'package:Crew/theme/icons/crew_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreenBody extends StatelessWidget {
  LoginScreenBody({Key key}) : super(key: key);

  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.clip,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(32),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Enter your mobile phone for verification",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(color: Colors.grey.shade300)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[300])),
                        filled: false,
                        hintText: "Phone Number",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade300),
                      ),
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: double.infinity,
                      child: FlatButton(
                        child: Text(
                          "PROCEED",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        onPressed: () {
                          //TODO: replace with code for sign in
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));

                          /** Welcome dialog  */
                          _showWelcomeDialog(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        Positioned(
          bottom: 60,
          left: MediaQuery.of(context).size.width - 200,
          child: Logo(
            logoSize: 60,
            textColor: Theme.of(context).primaryColor,
            iconColor: Theme.of(context).accentColor,
          ),
        )
      ],
    );
  }

  void _showWelcomeDialog(BuildContext context) {
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
