import 'package:ASL/Learn/classifier/classifier.dart';
import 'package:ASL/Learn/utils/image_utils.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

const _labelsFileName = 'assets/labels.txt';
const _modelFileName = 'model.tflite';

/// [CameraView] sends each frame for inference
class CameraView extends StatefulWidget {
  /// Callback to pass results after inference to [LearnView]
  final Function(double results, String letter) resultsCallback;
  final int letterValue;

  /// Constructor
  const CameraView(this.resultsCallback, this.letterValue, {super.key});
  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  /// List of available cameras
  List<CameraDescription>? cameras;

  /// Controller
  CameraController? cameraController;

  /// true when inference is ongoing
  bool predicting = false;

  // Result
  String _signLabel = '';
  double _accuracy = 0.0;

  late Classifier _classifier;

  @override
  void initState() {
    super.initState();
    initStateAsync();
  }

  void initStateAsync() async {
    initializeCamera();
    _loadClassifier();
  }

  Future<void> _loadClassifier() async {
    final classifier = await Classifier.loadWith(
      labelsFileName: _labelsFileName,
      modelFileName: _modelFileName,
    );
    _classifier = classifier!;
  }

  /// Initializes the camera by setting [cameraController]
  void initializeCamera() async {
    cameras = await availableCameras();

    // cameras[1] for front-camera
    cameraController = CameraController(cameras![1], ResolutionPreset.low,
        imageFormatGroup: ImageFormatGroup.bgra8888, enableAudio: false);

    cameraController?.initialize().then((_) async {
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
    // If previous inference has not completed then return
    if (predicting) {
      return;
    }
    if (mounted) {
      setState(() {
        predicting = true;
      });
    }

    _analyzeImage(cameraImage);

    if (mounted) {
      // set predicting to false to allow new frames
      setState(() {
        predicting = false;
      });
    }
  }

  void _analyzeImage(CameraImage cameraImage) {
    img.Image? image = ImageUtils.convertCameraImage(cameraImage);
    final resultCategory = _classifier.predict(image!, widget.letterValue);
    final signLabel = resultCategory.label;
    final accuracy = resultCategory.score;

    if (mounted) {
      setState(() {
        _signLabel = signLabel;
        _accuracy = accuracy;
      });
    }

    // pass results to Learn Screen
    widget.resultsCallback(_accuracy, _signLabel);
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
