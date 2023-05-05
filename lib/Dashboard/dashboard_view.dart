import 'package:ASL/Dictionary/dictionary_view.dart';
import 'package:ASL/Flashcards/cards_view.dart';
import 'package:ASL/Learn/ui/learn_view.dart';
import 'package:ASL/Style/colors.dart';
import 'package:flutter/material.dart';

import '../Quiz/quiz_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  // builds screen and adds buttons
  @override
  Widget build(BuildContext context) => Container(
      decoration: const BoxDecoration(color: kPrimaryColor),
      child: Align(
        // aligns buttons to the center
        alignment: Alignment.center,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          // Learn Screen
          ElevatedButton(
            style: addButtonStyle(),
            child: const Text(
              'LEARN',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LearnView()),
              );
            },
          ),
          const SizedBox(
            height: 50,
          ),
          // Quiz screen
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
                MaterialPageRoute(builder: (context) => const QuizView()),
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
              'FLASHCARDS',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FlashcardsView()),
              );
            },
          ),
          const SizedBox(
            height: 50,
          ),
          // Dictionary screen
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
                MaterialPageRoute(builder: (context) => const DictionaryView()),
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
