import 'package:ASL/dict.dart';
import 'package:ASL/constants.dart';
import 'package:flutter/material.dart';
import './quizScreen.dart';
import './dict.dart';

class ASLDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
      decoration: new BoxDecoration(color: kPrimaryColor),
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        const SizedBox(height: 100),
        const Padding(padding: EdgeInsets.only(top: 5)),
        ElevatedButton(
          child: Text('Learn'),
          onPressed: () {},
          // on press go to new page or something
        ),
        SizedBox(
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
