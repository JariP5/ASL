//import 'package:ASL/camera_page.dart';
import 'package:ASL/quiz.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
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
  int currentQuestion = 0;
  late String selectedAnswer;
  List<String> imagePaths = [
    'images/a.png',
    'images/b.png',
    'images/c.png',
    'images/d.png',
    'images/e.png',
    'images/f.png',
    'images/g.png',
    'images/h.png',
    'images/i.png',
    'images/k.png',
    'images/l.png',
    'images/m.png',
    'images/n.png',
    'images/o.png',
    'images/p.png',
    'images/q.png',
    'images/r.png',
    'images/s.png',
    'images/t.png',
    'images/u.png',
    'images/v.png',
    'images/w.png',
    'images/x.png',
    'images/y.png',
  ];

  void _answerQuestion(String answer) {
    setState(() {
      selectedAnswer = answer;
    });
  }

  void _nextQuestion() {
    currentQuestion++;
    selectedAnswer = "";
  }

  SizedBox buildCameraPreview(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  margin: const EdgeInsets.all(30.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    border: Border.all(width: 7, color: kSecondaryColor),
                  ),
                  child: CameraComponent(camera: widget.frontCamera),
                ),
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                    size: 35,
                    color: kPrimaryColor,
                  ),
                ),
                ProgressBar(
                  currentQuestion: currentQuestion,
                ),
              ],
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
                        image: DecorationImage(
                          image: AssetImage(imagePaths[currentQuestion]),
                          fit: BoxFit.fill,
                        )),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    imagePaths[currentQuestion].substring(7, 8).toUpperCase(),
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: kSecondaryColor),
                  ),
                ],
              ),
            ),
            buildCameraPreview(context),
            Center(
              child: GestureDetector(
                // Next Question Button
                onTap: () {
                  if (currentQuestion >= questions.length - 1) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResultsPage()));
                  } else {
                    setState(() {
                      _nextQuestion();
                    });
                  }
                },
                child: const Text(
                  "Next",
                  style: TextStyle(
                      color: kPrimaryColor,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ResultsPage extends StatelessWidget {
  const ResultsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(color: kPrimaryColor),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //const SizedBox(height: 120),
              const Text(
                'You are done!',
                style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: 42,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => kSecondaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(33.0))),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 18)),
                    minimumSize:
                        MaterialStateProperty.all(const Size(280, 65))),
                child: const Text('Return'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ]),
      ),
    );
  }
}

// Progress bar
class ProgressBar extends StatelessWidget {
  final int currentQuestion;
  const ProgressBar({Key? key, required this.currentQuestion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      //margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90.0)),
      //width: double.infinity,
      width: MediaQuery.of(context).size.width / 1.3,
      height: 35,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned.fill(
            child: LinearProgressIndicator(
              //Here you pass the percentage
              value: currentQuestion / 24,
              color: kPrimaryColor,
              backgroundColor: kPrimaryColor.withOpacity(0.5),
            ),
          ),
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
