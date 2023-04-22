import 'package:ASL/Learn/classifier/classifier.dart';
import 'package:ASL/Learn/utils/image_utils.dart';
import 'package:ASL/Style/colors.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

const _labelsFileName = 'assets/sayan.txt';
const _modelFileName = 'sayan.tflite';

/// [CameraView] sends each frame for inference
class CameraView extends StatefulWidget {
  /// Callback to pass results after inference to [LearnScreen]
  final Function(double results) resultsCallback;
  final int letter;
  /// Constructor
  const CameraView(this.resultsCallback, this.letter, {super.key});
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
  bool predicting = false;

  // Result
  _ResultStatus _resultStatus = _ResultStatus.notStarted;
  String _signLabel = ''; // Name of Error Message
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
    // debugPrint(
    //   'Start loading of Classifier with '
    //   'labels at $_labelsFileName, '
    //   'model at $_modelFileName',
    // );

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
    // return Stack(
    //     //crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [CameraPreview(cameraController!), _buildResultView()]);
  }

  /// Callback to receive each frame [CameraImage] perform inference on it
  onLatestImageAvailable(CameraImage cameraImage) async {
    // If previous inference has not completed then return
    if (predicting) {
      return;
    }

    setState(() {
      predicting = true;
    });

    _analyzeImage(cameraImage);

    // set predicting to false to allow new frames
    setState(() {
      predicting = false;
    });
  }

  void _analyzeImage(CameraImage cameraImage) {
    img.Image? image = ImageUtils.convertCameraImage(cameraImage);
    final resultCategory = _classifier.predict(image!, widget.letter);
    final result = resultCategory.score >= 0.0
        ? _ResultStatus.found
        : _ResultStatus.notFound;
    final signLabel = resultCategory.label;
    final accuracy = resultCategory.score;

    setState(() {
      _resultStatus = result;
      _signLabel = signLabel;
      _accuracy = accuracy;
    });

    // pass results to Learn Screen
    widget.resultsCallback(_accuracy);
  }

  Widget _buildResultView() {
    var title = '';

    if (_resultStatus == _ResultStatus.notFound) {
      title = 'Fail to recognise';
    } else if (_resultStatus == _ResultStatus.found) {
      title = _signLabel;
    } else {
      title = '';
    }

    var accuracyLabel = '';
    if (_resultStatus == _ResultStatus.found) {
      accuracyLabel = 'Accuracy: ${(_accuracy * 100).toStringAsFixed(2)}%';
    }

    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: kPrimaryColor),
            child: CircleAvatar(
                backgroundColor: kPrimaryColor,
                child: Text(
                  title + " " + accuracyLabel.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: kSecondaryColor),
                )))
        //child: Row(
        //children: [Text(title.toUpperCase() + " "), Text(accuracyLabel)],
        //),
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
