import 'package:flutter/material.dart';
import 'package:ASL/constants.dart';
import 'dart:math';
import './quiz.dart';

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  Widget build(BuildContext context) {
    return const Scaffold(
      body: QuestionWidget(),
    );
  }
}

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  late PageController _controller;
  Random rnd = Random();
  int _score = 0;
  bool _isLocked = false;
  int _questionNumber = 1;

  @override
  void initState() {
    super.initState();
    for (Question questionStor in questions) {
      questionStor.isLocked = false;
      questionStor.selectedOption = null;
    }
    int startingQuestion = 1 + rnd.nextInt(19);
    _controller = PageController(initialPage: startingQuestion);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 32),
            Text('Question $_questionNumber/5'),
            const Divider(thickness: 1, color: Colors.grey),
            Expanded(
              child: PageView.builder(
                  itemCount: questions.length,
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final _question = questions[index];
                    return buildQuestion(_question);
                  }),
            ),
            _isLocked ? buildElevatedButton() : const SizedBox.shrink(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Column buildQuestion(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(
          question.text,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Image.asset(question.imagePath, height: 150, width: 150),
        const SizedBox(height: 32),
        Expanded(
          child: OptionsWidget(
            question: question,
            onClickedOption: (option) {
              if (question.isLocked) {
                return;
              } else {
                setState(() {
                  question.isLocked = true;
                  question.selectedOption = option;
                });
                _isLocked = question.isLocked;
                if (question.selectedOption!.isCorrect) {
                  _score++;
                }
              }
            },
          ),
        ),
      ],
    );
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => kSecondaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(33.0))),
            textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 18)),
            minimumSize: MaterialStateProperty.all(const Size(150, 45))),
        onPressed: () {
          if (_questionNumber < 5) {
            _controller.nextPage(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInExpo,
            );

            setState(() {
              _questionNumber++;
              _isLocked = false;
            });
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResultPage(score: _score),
              ),
            );
          }
        },
        child: Text(_questionNumber < 5 ? 'NEXT' : 'See Results',
            style: const TextStyle(fontWeight: FontWeight.bold)));
  }
}

class OptionsWidget extends StatelessWidget {
  final Question question;
  final ValueChanged<Option> onClickedOption;

  const OptionsWidget({
    Key? key,
    required this.question,
    required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: question.options
              .map((option) => buildOption(context, option))
              .toList(),
        ),
      );

  Widget buildOption(BuildContext context, Option option) {
    final color = getColorForOption(option, question);
    return GestureDetector(
      onTap: () => onClickedOption(option),
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(33),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              option.text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            getIconForOption(option, question),
          ],
        ),
      ),
    );
  }

  Color getColorForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;
    if (question.isLocked) {
      if (isSelected) {
        return option.isCorrect ? Colors.green : Colors.red;
      } else if (option.isCorrect) {
        return Colors.green;
      }
    }
    return Colors.grey;
  }

  Widget getIconForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;
    if (question.isLocked) {
      if (isSelected) {
        return option.isCorrect
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.cancel, color: Colors.red);
      } else if (option.isCorrect) {
        return const Icon(Icons.check_circle, color: Colors.green);
      }
    }
    return const SizedBox.shrink();
  }
}

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, required this.score}) : super(key: key);

  final int score;
  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(color: kPrimaryColor),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //const SizedBox(height: 120),
              Text(
                'You got $score/5',
                style: const TextStyle(color: kSecondaryColor),
              ),
              const SizedBox(
                height: 100,
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
      );
}
