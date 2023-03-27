import 'package:flutter/material.dart';
import './quizScreen.dart';

class ASLDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        const SizedBox(height: 700),
        Padding(padding: EdgeInsets.only(top: 5)),
        ElevatedButton(
          child: Text('Learn'),
          onPressed: () {},
          // on press go to new page or something
        ),
        ElevatedButton(
          child: Text('Quiz'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuestionWidget()),
            );
          },
          // on press go to new page or something
        ),
        ElevatedButton(
          child: Text('Dictionary'),
          onPressed: () {},
          // on press go to new page or something
        ),
      ]));
}
