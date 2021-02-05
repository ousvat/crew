import 'package:Crew/components/crew_alert_dialog.dart';
import 'package:Crew/components/logo.dart';
import 'package:Crew/services/phone_auth.dart';
import 'package:Crew/theme/icons/crew_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreenBody extends StatelessWidget {
  LoginScreenBody({Key key}) : super(key: key);

  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey[300])),
                          filled: false,
                          hintText: "Phone Number",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade300),
                        ),
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Number can\'t be empty';
                          else
                            return null;
                        },
                      ),
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
                          final mobile = _phoneController.text.trim();
                          print(_formKey.currentState.validate());
                          if (_formKey.currentState.validate())
                            PhoneAuth.registerUser(mobile, context);
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

  // TODO: Move this method in it's place after backend implemented
  
  // TODO: Move this method in it's place after backend implemented
  
}
