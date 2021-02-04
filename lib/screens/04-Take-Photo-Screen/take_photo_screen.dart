import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
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
                        // color: Colors.red,
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
              // Otherwise, display a loading indicator.
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.camera_alt),
        //   // Provide an onPressed callback.
        //   onPressed: () async {
        //     // Take the Picture in a try / catch block. If anything goes wrong,
        //     // catch the error.
        //     try {
        //       // Ensure that the camera is initialized.
        //       await _initializeControllerFuture;

        //       // Construct the path where the image should be saved using the
        //       // pattern package.
        //       // final path = join(
        //       //   // Store the picture in the temp directory.
        //       //   // Find the temp directory using the `path_provider` plugin.
        //       //   (await getTemporaryDirectory()).path,
        //       //   '${DateTime.now()}.png',
        //       // );

        //       // Attempt to take a picture and log where it's been saved.
        //       var path = await _controller.takePicture();

        //       // If the picture was taken, display it on a new screen.
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) =>
        //               DisplayPictureScreen(imagePath: path.path),
        //         ),
        //       );
        //     } catch (e) {
        //       // If an error occurs, log the error to the console.
        //       print(e);
        //     }
        //   },
        // ),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(imagePath);
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
