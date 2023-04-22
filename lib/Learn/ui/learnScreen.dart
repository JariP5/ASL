import 'package:ASL/Learn/ui/camera/camera_view.dart';
import 'package:ASL/Learn/ui/progress_bar.dart';
import 'package:ASL/Learn/ui/result_page.dart';
import 'package:ASL/Style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// [LearnScreen] stacks [CameraView] and [BoxWidget]s with bottom sheet for stats
class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  double results = 0.0;
  String letter = 'A';
  int currentQuestion = 0;
  List<String> imagePaths = [
    'assets/images/a.png',
    'assets/images/b.png',
    'assets/images/c.png',
    'assets/images/d.png',
    'assets/images/e.png',
    'assets/images/f.png',
    'assets/images/g.png',
    'assets/images/h.png',
    'assets/images/i.png',
    'assets/images/k.png',
    'assets/images/l.png',
    'assets/images/m.png',
    'assets/images/n.png',
    'assets/images/o.png',
    'assets/images/p.png',
    'assets/images/q.png',
    'assets/images/r.png',
    'assets/images/s.png',
    'assets/images/t.png',
    'assets/images/u.png',
    'assets/images/v.png',
    'assets/images/w.png',
    'assets/images/x.png',
    'assets/images/y.png',
  ];

  // Move to the next question
  void _nextQuestion() {
    currentQuestion++;
  }

  // Move back to previous question
  void _previousQuestion() {
    currentQuestion--;
  }

  /// Scaffold Key
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  // Returns the square borded camera preview
  SizedBox buildCameraPreview(BuildContext context, int letter) {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                //borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 20.0, right: 30.0, left: 30.0, bottom: 30.0),
                  //margin: EdgeInsets.all(30.0),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(width: 6, color: kPrimaryColor)),
                  child: CameraView(resultsCallback, letter),
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  // Return to main menu
                  IconButton(
                    onPressed: () {
                      // If in the first question, pop back to main menu
                      if (currentQuestion == 0) {
                        Navigator.pop(context);
                      } else {
                        // otherwise, go back a question
                        setState(() {
                          _previousQuestion();
                        });
                      }
                    },
                    // Set return button styling
                    icon: const Icon(
                      CupertinoIcons.back,
                      size: 35,
                      color: kPrimaryColor,
                    ),
                  ),
                  // Call progress bar function
                  ProgressBar(
                    currentQuestion: currentQuestion,
                  ),
                  // Go to the next question
                  IconButton(
                    onPressed: () {
                      if (currentQuestion >= imagePaths.length - 1) {
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
                    // Set "next" button styling
                    icon: const Icon(
                      CupertinoIcons.forward,
                      size: 35,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
            //const SizedBox(height: 20.0),
            Center(
              child: Column(
                children: [
                  const Text(
                    // Prompt user to sign the letter to the camera
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
                    // Display the ASL letter to be handsigned by the user
                    // with the passed in imagePath
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
                  // Display the letter to be handsigned by using the first
                  // letter of the image from imagePath (i.e. "A" from "assets/images/A.png")
                  Text(
                    imagePaths[currentQuestion].substring(14, 15).toUpperCase(),
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: kSecondaryColor),
                  ),
                ],
              ),
            ),
            buildCameraPreview(context,
                currentQuestion > 8 ? currentQuestion + 1 : currentQuestion),

            AccuracyMeter(accuracy: results)
          ],
        ),
      ),
    );
  }

  /// Callback to get inference results from [CameraView]
  void resultsCallback(double results, String letter) {
    setState(() {
      this.results = results;
      this.letter = letter;
    });
    debugPrint(letter);
  }
}

class AccuracyMeter extends StatelessWidget {
  final double accuracy;
  final colors = [Colors.red, Colors.yellow, Colors.green];
  final accuracyTween = TweenSequence([
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.red, end: Colors.yellow), weight: 0.3),
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.yellow, end: Colors.green),
        weight: 0.5),
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.green, end: Colors.green), weight: 0.7),
  ]);
  AccuracyMeter({super.key, required this.accuracy});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(90.0)),
          width: MediaQuery.of(context).size.width / 1.3,
          height: 20,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                  child: LinearProgressIndicator(
                value: accuracy,
                valueColor: AlwaysStoppedAnimation(
                    accuracyTween.evaluate(AlwaysStoppedAnimation(accuracy))),
                backgroundColor: kSecondaryColor.withOpacity(0.5),
              ))
            ],
          )),
    );
  }
}
