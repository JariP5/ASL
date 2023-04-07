import 'package:ASL/dict.dart';
import 'package:ASL/home_page.dart';
import 'package:ASL/learning/components/body.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import './quizScreen.dart';

class ASLDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        const SizedBox(height: 100),
        const Padding(padding: EdgeInsets.only(top: 5)),
        ElevatedButton(
          child: Text('Learn'),
          onPressed: () async {
            await availableCameras().then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => LearningScreen(cameras: value))));
          },
          // on press go to new page or something
        ),
        const SizedBox(
          height: 50,
        ),
        ElevatedButton(
          child: Text('Quiz'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QuizApp()),
            );
          },
          // on press go to new page or something
        ),
        SizedBox(
          height: 50,
        ),
        ElevatedButton(
          child: Text('Dictionary'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ASLDictionaryScreen()),
            );
          },
          // on press go to new page or something
        ),
      ]));
}
