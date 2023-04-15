import 'package:ASL/Learn/ui/camera_view.dart';
import 'package:ASL/Learn/ui/progress_bar.dart';
import 'package:ASL/Learn/ui/result_page.dart';
import 'package:ASL/Quiz/quiz.dart';
import 'package:ASL/Style/colors.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LearnView extends StatefulWidget {
  const LearnView({Key? key, required this.frontCamera}) : super(key: key);
  final CameraDescription frontCamera;

  @override
  // ignore: no_logic_in_create_state
  State<LearnView> createState() => _LearnViewState();
}

class _LearnViewState extends State<LearnView> {
  int currentQuestion = 0;
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

  void _nextQuestion() {
    currentQuestion++;
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
                  child: CameraView(camera: widget.frontCamera),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
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
