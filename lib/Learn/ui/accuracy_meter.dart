import 'package:ASL/Style/colors.dart';
import 'package:flutter/material.dart';

class AccuracyMeter extends StatelessWidget {
  final double accuracy;
  final colors = [Colors.red, Colors.yellow, Colors.green];
  final accuracyTween = TweenSequence([
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.red, end: Colors.yellow), weight: 0.3),
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.yellow, end: Colors.green),
        weight: 0.5),
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.green, end: Colors.green), weight: 0.7),
  ]);
  AccuracyMeter({super.key, required this.accuracy});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(90.0)),
          width: MediaQuery.of(context).size.width / 1.3,
          height: 20,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                  child: LinearProgressIndicator(
                value: accuracy,
                valueColor: AlwaysStoppedAnimation(
                    accuracyTween.evaluate(AlwaysStoppedAnimation(accuracy))),
                backgroundColor: kSecondaryColor.withOpacity(0.5),
              ))
            ],
          )),
    );
  }
}