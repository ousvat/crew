import 'package:Crew/components/circle_with_stamp.dart';
import 'package:Crew/components/logo.dart';
import 'package:Crew/screens/04-Take-Photo-Screen/take_photo_screen.dart';
import 'package:Crew/theme/icons/crew_icons_icons.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

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
          Stack(
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
                top: 140,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Container(
                          width: width - 80,
                          child: Column(
                            children: [
                              SizedBox(height: 50),
                              Text(
                                'Earn a reward after every 7 stamps.\nOne stamp equals \$20',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 50),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleWithStamp(
                                    haveStamp: true,
                                  ),
                                  CircleWithStamp(
                                    haveStamp: true,
                                  ),
                                  CircleWithStamp(
                                    haveStamp: true,
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleWithStamp(
                                    haveStamp: true,
                                  ),
                                  CircleWithStamp(
                                    haveStamp: true,
                                  ),
                                  CircleWithStamp(
                                    haveStamp: true,
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
                              Container(
                                width: width / 5,
                                height: width / 5,
                                margin: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    CrewIcons.gift,
                                    color: Theme.of(context).accentColor,
                                    size: width / 8,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: width / 2,
                                child: FlatButton(
                                  child: Text(
                                    "SCAN RECEIPT",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  textColor: Colors.white,
                                  color: Theme.of(context).primaryColor,
                                  padding: EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8)),
                                  ),
                                  onPressed: () async {
                                    // //TODO: replace with navigation to scanning reipt screen

                                    WidgetsFlutterBinding.ensureInitialized();
                                    final cameras = await availableCameras();
                                    final firstCamera = cameras.first;

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TakePhotoScreen(
                                                    camera: firstCamera)));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          FAProgressBar(
            progressColor: Theme.of(context).primaryColor,
            borderRadius: 10,
            animatedDuration: Duration(seconds: 1),
            size: 10,
            currentValue: 75,
            maxValue: 100,
          ),
          FAProgressBar(
            progressColor: Theme.of(context).primaryColor,
            borderRadius: 0,
            size: 10,
            currentValue: 3,
            maxValue: 100,
          ),
        ],
      ),
    );
  }
}
