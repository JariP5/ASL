import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
class CameraViewUnused extends StatefulWidget {
  final CameraDescription camera;

  const CameraViewUnused({Key? key, required this.camera}) : super(key: key);

  @override
  CameraViewUnusedState createState() => CameraViewUnusedState();
}

class CameraViewUnusedState extends State<CameraViewUnused> {
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
        imageFormatGroup: ImageFormatGroup.bgra8888);

    _initializeControllerFuture = _cameraController.initialize();
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