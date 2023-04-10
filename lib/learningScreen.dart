//import 'package:ASL/camera_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ASL/constants.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({Key? key, required this.frontCamera}) : super(key: key);
  final CameraDescription frontCamera;

  @override
  // ignore: no_logic_in_create_state
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ProgressBar(),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Column(
                children: [
                  const Text(
                    "Your Turn",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Sign it to the camera",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 25.0),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: kPrimaryColor, width: 5),
                        borderRadius: BorderRadius.circular(25),
                        image: const DecorationImage(
                          image: AssetImage('images/k.png'),
                          fit: BoxFit.fill,
                        )),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    "K",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: kSecondaryColor),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              //child: ,
            ),
            const SizedBox(height: 20.0),
            SizedBox(
                //color: kPrimaryColor,
                //margin: const EdgeInsets.only(bottom: 20),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipRRect(
                        //borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Container(
                          width: 350,
                          height: 750,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 7, color: kSecondaryColor),
                          ),
                          child: CameraComponent(camera: widget.frontCamera),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

// Progress bar
class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90.0)),
      width: double.infinity,
      height: 35,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned.fill(
            child: LinearProgressIndicator(
              //Here you pass the percentage
              value: 0.6,
              color: kPrimaryColor,
              backgroundColor: kPrimaryColor.withOpacity(0.5),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: Text('Hello world'),
          )
        ],
      ),
    );
  }
}

class CameraComponent extends StatefulWidget {
  final CameraDescription camera;

  const CameraComponent({Key? key, required this.camera}) : super(key: key);

  @override
  CameraComponentState createState() => CameraComponentState();
}

class CameraComponentState extends State<CameraComponent> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCamera(widget.camera);
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController = CameraController(
        cameraDescription, ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.yuv420);

    _initializeControllerFuture = _cameraController.initialize();
    _initializeControllerFuture = _cameraController.lockCaptureOrientation();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
                aspectRatio: _cameraController.value.aspectRatio,
                child: CameraPreview(_cameraController));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
}
