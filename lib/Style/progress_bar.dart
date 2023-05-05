// Progress bar
import 'package:flutter/material.dart';
import '../../Style/colors.dart';

class ProgressBar extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;
  const ProgressBar(
      {Key? key, required this.currentQuestion, required this.totalQuestions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90.0)),
      width: MediaQuery.of(context).size.width / 1.3,
      height: 35,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned.fill(
            child: LinearProgressIndicator(
              // Here you pass the percentage that reflects how much the
              // the progress bar should be filled.
              value: currentQuestion / totalQuestions,
              color: kPrimaryColor,
              backgroundColor: kPrimaryColor.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
