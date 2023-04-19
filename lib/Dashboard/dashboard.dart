import 'package:ASL/Dictionary/dictScreen.dart';
import 'package:ASL/Learn/ui/learnScreen.dart';
import 'package:ASL/Style/colors.dart';
import 'package:flutter/material.dart';

import '../Quiz/quizScreen.dart';

class ASLDashboard extends StatelessWidget {
  const ASLDashboard({super.key});

  // builds screen and adds buttons
  @override
  Widget build(BuildContext context) => Container(
      decoration: const BoxDecoration(color: kPrimaryColor),
      child: Align(
        // aligns buttons to the center
        alignment: Alignment.center,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          //const SizedBox(height: 220),
          //const Padding(padding: EdgeInsets.only(top: 5)),
          // learn button
          ElevatedButton(
            style: addButtonStyle(),
            child: const Text(
              'LEARN',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              // redirect to learn screen
              // await availableCameras().then((value) => Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) => LearnView(frontCamera: value[1]))));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LearnScreen()),
              );
            },
          ),
          const SizedBox(
            height: 50,
          ),
          // quiz screen
          ElevatedButton(
            style: addButtonStyle(),
            child: const Text(
              'QUIZ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              // redirect to quiz screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QuizApp()),
              );
            },
          ),
          const SizedBox(
            height: 50,
          ),
          // dictionary screen
          ElevatedButton(
            style: addButtonStyle(),
            child: const Text(
              'DICTIONARY',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              // redirect to dictionary screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ASLDictionaryScreen()),
              );
            },
          ),
        ]),
      ));

  // sets style (color and size) of buttons
  ButtonStyle addButtonStyle() {
    return ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => kSecondaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(33.0))),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 18)),
        minimumSize: MaterialStateProperty.all(const Size(280, 65)));
  }
}
