import 'dart:async';

import 'package:Crew/components/crew_alert_dialog.dart';
import 'package:Crew/screens/02-Home-Screen/home_screen.dart';
import 'package:Crew/services/google_vision.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TakePhotoScreen extends StatefulWidget {
  TakePhotoScreen({Key key, @required this.camera}) : super(key: key);

  final camera;

  @override
  _TakePhotoScreenState createState() => _TakePhotoScreenState();
}

class _TakePhotoScreenState extends State<TakePhotoScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _detectReceipt();
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  Container(
                    child: CameraPreview(_controller),
                    height: size.height,
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        width: size.width,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 30, left: 30, top: 40),
                              child: Text(
                                'Position your receipt to scan it',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              width: double.maxFinite,
                              child: FlatButton(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                textColor: Theme.of(context).primaryColor,
                                color: Colors.transparent,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.camera_alt),
          onPressed: () async {
            try {
              await _initializeControllerFuture;

              var path = await _controller.takePicture();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
              _showUploadReceipeDialog(context, path.path);
            } catch (e) {
              print(e);
            }
          },
        ),
      ),
    );
  }

  void _showUploadReceipeDialog(BuildContext context, imagePath) {
    showDialog(
        context: context,
        child: CrewAlertDialog(
          heightRegulation: -40,
          title: Text(
            'Upload Receipt',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Theme.of(context).primaryColor,
              fontFamily: GoogleFonts.roboto().fontFamily,
              fontSize: 28,
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              'Your receipe will upload in background. We\'ll notify you when it\'s done.',
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Theme.of(context).primaryColor,
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          actions: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: double.maxFinite,
                child: FlatButton(
                  child: Text(
                    "OKAY",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onPressed: () {
                    //TODO: Upload the photo on Google API
                    Navigator.pop(context);
                    AnalyzePhoto().getResponse(imagePath);
                  },
                ),
              ),
              Container(
                width: double.maxFinite,
                child: FlatButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  textColor: Theme.of(context).primaryColor,
                  color: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
