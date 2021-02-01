import 'package:Crew/components/logo.dart';
import 'package:flutter/material.dart';

class HomeScreenBody extends StatefulWidget {
  HomeScreenBody({Key key}) : super(key: key);

  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Stack(
        children: [
          //* Top logo
          Positioned(
            height: 120,
            width: width,
            top: 0,
            left: 0,
            child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Positioned(
                    top: 30,
                    left: width / 2 - 90,
                    child: Logo(
                      logoSize: 60,
                      iconColor: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //* Scan Receipt card
          Positioned(
            top: 120,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Container(
                      width: width - 80,
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          Text(
                            'Earn a reward after every 7 stamps.\nOne stamp equals \$20',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 70),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
