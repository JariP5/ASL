import 'dart:async';
import 'package:ASL/Style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart';

class AccuracyMeter extends StatefulWidget {
  /// Callback to pass result (of whether user got the question right) back to [LearnView]
  final Function(bool _correctSign) correctCallback;
  final double accuracy;
  const AccuracyMeter(this.correctCallback, this.accuracy, {super.key});

  @override
  AccuracyMeterState createState() => AccuracyMeterState();
}

class AccuracyMeterState extends State<AccuracyMeter> {
  Timer? _timer;
  int timeHoldingSignCorrectly = 0;
  bool isBusy = false;
  bool _correctSign = false;
  final colors = [Colors.red, Colors.yellow, Colors.green];
  final accuracyTween = TweenSequence([
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.red, end: Colors.yellow), weight: 0.3),
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.yellow, end: Colors.green),
        weight: 0.3),
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.green, end: Colors.green), weight: 0.4),
  ]);

  @override
  Widget build(BuildContext context) {
    // Since the model checks for accuracy whenever the screen renders,
    // it makes sense to start checking whether the user has been signaling
    // correctly at the start of every frame, but only once/one sign at a time.
    if (widget.accuracy >= 0.6 && !isBusy) {
      isBusy = true;
      startTimer();
    }
    return Center(
      child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(90.0)),
          width: MediaQuery.of(context).size.width / 1.3,
          height: 20,
          child: Stack(alignment: Alignment.center, children: [
            Positioned.fill(
              child: LinearProgressIndicator(
                value: _correctSign ? 100.0 : widget.accuracy,
                valueColor: _correctSign
                    ? const AlwaysStoppedAnimation(Colors.green)
                    : AlwaysStoppedAnimation(accuracyTween
                        .evaluate(AlwaysStoppedAnimation(widget.accuracy))),
                backgroundColor: kSecondaryColor.withOpacity(0.5),
              ),
            ),
          ])),
    );
  }

// Every 500 ms, it checks to see if the user handsignaled the
// letter with an accuracy higher (or equal) than 60%. If user
// holds this accuracy for a period of 2 seconds, he succeeded.
// Otherwise, timer is restarted and user can try again.
  void startTimer() {
    //_timer?.cancel();
    _timer = Timer.periodic(
        const Duration(milliseconds: 500),
        (timer) => setState(() {
              if (widget.accuracy >= 0.6) {
                if (timeHoldingSignCorrectly == 2) {
                  timer.cancel();
                  shouldUpdateMeter(true);
                } else {
                  timeHoldingSignCorrectly += 1;
                }
              } else {
                timeHoldingSignCorrectly = 0;
                isBusy = false;
                timer.cancel();
              }
            }));
  }

  void shouldUpdateMeter(bool correctSign) {
    setState(() {
      _correctSign = correctSign;
      timeHoldingSignCorrectly = 0;
      widget.correctCallback(_correctSign);
    });

    setState(() {
      Timer(const Duration(seconds: 1), () {
        _correctSign = false;
        widget.correctCallback(_correctSign);
        startTimer();
      });
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    //startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
