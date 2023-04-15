// Progress bar
import 'package:flutter/material.dart';

import '../../Style/colors.dart';

class ProgressBar extends StatelessWidget {
  final int currentQuestion;
  const ProgressBar({Key? key, required this.currentQuestion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      //margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90.0)),
      //width: double.infinity,
      width: MediaQuery.of(context).size.width / 1.3,
      height: 35,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned.fill(
            child: LinearProgressIndicator(
              //Here you pass the percentage
              value: currentQuestion / 24,
              color: kPrimaryColor,
              backgroundColor: kPrimaryColor.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}