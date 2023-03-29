import 'package:flutter/material.dart';

class Question {
  final String text;
  final List<Option> options;
  final String imagePath;
  bool isLocked;
  Option? selectedOption;

  Question({
    required this.text,
    required this.options,
    required this.imagePath,
    this.isLocked = false,
    this.selectedOption,
  });
}

class Option {
  final String text;
  final bool isCorrect;

  const Option({
    required this.text,
    required this.isCorrect,
  });
}

List<Question> questions = [
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'A', isCorrect: false),
      const Option(text: 'B', isCorrect: false),
      const Option(text: 'C', isCorrect: true),
      const Option(text: 'D', isCorrect: false),
    ],
    imagePath: 'images/c.png',
  ),
  Question(
    text: 'What is the letter for this signs?',
    options: [
      const Option(text: 'J', isCorrect: false),
      const Option(text: 'B', isCorrect: true),
      const Option(text: 'K', isCorrect: false),
      const Option(text: 'P', isCorrect: false),
    ],
    imagePath: 'images/b.png',
  ),
  Question(
    text: 'What is the letter for this signs?',
    options: [
      const Option(text: 'T', isCorrect: false),
      const Option(text: 'C', isCorrect: true),
      const Option(text: 'I', isCorrect: false),
      const Option(text: 'M', isCorrect: false),
    ],
    imagePath: 'images/c.png',
  ),
  Question(
    text: 'What is the letter for this signs?',
    options: [
      const Option(text: 'A', isCorrect: false),
      const Option(text: 'Q', isCorrect: true),
      const Option(text: 'Z', isCorrect: false),
      const Option(text: 'X', isCorrect: false),
    ],
    imagePath: 'images/q.png',
  ),
  Question(
    text: 'What is the letter for this signs?',
    options: [
      const Option(text: 'Q', isCorrect: false),
      const Option(text: 'W', isCorrect: true),
      const Option(text: 'E', isCorrect: false),
      const Option(text: 'R', isCorrect: false),
    ],
    imagePath: 'images/w.png',
  ),
  Question(
    text: 'What is the letter for this signs?',
    options: [
      const Option(text: 'T', isCorrect: false),
      const Option(text: 'Y', isCorrect: true),
      const Option(text: 'U', isCorrect: false),
      const Option(text: 'I', isCorrect: false),
    ],
    imagePath: 'images/y.png',
  ),
  Question(
    text: 'What is the letter for this signs?',
    options: [
      const Option(text: 'P', isCorrect: false),
      const Option(text: 'L', isCorrect: true),
      const Option(text: 'M', isCorrect: false),
      const Option(text: 'K', isCorrect: false),
    ],
    imagePath: 'images/l.png',
  ),
  Question(
    text: 'What is the letter for this signs?',
    options: [
      const Option(text: 'F', isCorrect: false),
      const Option(text: 'V', isCorrect: true),
      const Option(text: 'B', isCorrect: false),
      const Option(text: 'N', isCorrect: false),
    ],
    imagePath: 'images/v.png',
  ),
];
