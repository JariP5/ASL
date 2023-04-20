import 'package:ASL/Learn/classifier/classifier.dart';
import 'package:ASL/Learn/utils/image_utils.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

const _labelsFileName = 'assets/70.txt';
const _modelFileName = '70.tflite';

/// [CameraView] sends each frame for inference
class CameraView extends StatefulWidget {

  /// Constructor
  const CameraView({super.key});
  @override
  _CameraViewState createState() => _CameraViewState();
}

enum _ResultStatus {
  notStarted,
  notFound,
  found,
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  /// List of available cameras
  List<CameraDescription>? cameras;
  /// Controller
  CameraController? cameraController;
  /// true when inference is ongoing
  bool predicting = true;

  // Result
  _ResultStatus _resultStatus = _ResultStatus.notStarted;
  String _plantLabel = ''; // Name of Error Message
  double _accuracy = 0.0;

  late Classifier _classifier;

  @override
  void initState() {
    super.initState();
    initStateAsync();
  }

  void initStateAsync() async {
    // Camera initialization
    initializeCamera();
    _loadClassifier();
  }

  Future<void> _loadClassifier() async {
    debugPrint(
      'Start loading of Classifier with '
      'labels at $_labelsFileName, '
      'model at $_modelFileName',
    );

    final classifier = await Classifier.loadWith(
      labelsFileName: _labelsFileName,
      modelFileName: _modelFileName,
    );
    _classifier = classifier!;
  }

  /// Initializes the camera by setting [cameraController]
  void initializeCamera() async {
    cameras = await availableCameras();

    // cameras[0] for rear-camera
    cameraController =
        CameraController(cameras![1], ResolutionPreset.low, imageFormatGroup: ImageFormatGroup.bgra8888, enableAudio: false);
        
    cameraController?.initialize().then((_) async {
      print("Here");
      // Stream of image passed to [onLatestImageAvailable] callback
      await cameraController?.startImageStream(onLatestImageAvailable);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Return empty container while the camera is not initialized
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return Container();
    }

    return CameraPreview(cameraController!);
  }

  /// Callback to receive each frame [CameraImage] perform inference on it
  onLatestImageAvailable(CameraImage cameraImage) async {
    if (true) {
            debugPrint("He");

      // If previous inference has not completed then return
      if (predicting) {
        return;
      }
      debugPrint("Here");

      setState(() {
        predicting = true;
      });
      
      _analyzeImage(cameraImage);

      // set predicting to false to allow new frames
      setState(() {
        predicting = false;
      });
    }
  }

  void _analyzeImage(CameraImage cameraImage) {

    img.Image? image = ImageUtils.convertCameraImage(cameraImage);
    
    final resultCategory = _classifier.predict(image!);

    final result = resultCategory.score >= 0.8
        ? _ResultStatus.found
        : _ResultStatus.notFound;
    final plantLabel = resultCategory.label;
    final accuracy = resultCategory.score;


    setState(() {
      _resultStatus = result;
      _plantLabel = plantLabel;
      _accuracy = accuracy;
    });
  }

  Widget _buildResultView() {
    var title = '';

    if (_resultStatus == _ResultStatus.notFound) {
      title = 'Fail to recognise';
    } else if (_resultStatus == _ResultStatus.found) {
      title = _plantLabel;
    } else {
      title = '';
    }

    //
    var accuracyLabel = '';
    if (_resultStatus == _ResultStatus.found) {
      accuracyLabel = 'Accuracy: ${(_accuracy * 100).toStringAsFixed(2)}%';
    }

    return Column(
      children: [
        Text(title),
        const SizedBox(height: 10),
        Text(accuracyLabel)
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        cameraController?.stopImageStream();
        break;
      case AppLifecycleState.resumed:
        if (!cameraController!.value.isStreamingImages) {
          await cameraController?.startImageStream(onLatestImageAvailable);
        }
        break;
      default:
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }
}
