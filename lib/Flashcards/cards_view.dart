import 'dart:io';
import 'package:ASL/Style/progress_bar.dart';
import 'package:ASL/Learn/ui/result_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import '../Style/colors.dart';

// class Flashcard extends StatelessWidget {
//   final String imagePath;
//   final String letter;

//   const Flashcard({Key? key, required this.imagePath, required this.letter})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FlipCard(
//       front: Container(
//           child: Image(
//         image: AssetImage(imagePath),
//       )),
//       back: Container(
//         child: Text(
//           letter,
//           style: TextStyle(fontSize: 36),
//         ),
//       ),
//     );
//   }
// }

// matching signing images with their corresponding letters
class FlashcardsView extends StatefulWidget {
  const FlashcardsView({super.key});
  @override
  _FlashcardsViewState createState() => _FlashcardsViewState();
}

class _FlashcardsViewState extends State<FlashcardsView> {
  final List<Map<String, dynamic>> flashcards = [
    {'image': ('assets/images/a.png'), 'letter': 'A', 'showImageFirst': true},
    {'image': ('assets/images/b.png'), 'letter': 'B', 'showImageFirst': true},
    {'image': ('assets/images/c.png'), 'letter': 'C', 'showImageFirst': true},
    {'image': ('assets/images/d.png'), 'letter': 'D', 'showImageFirst': true},
    {'image': ('assets/images/e.png'), 'letter': 'E', 'showImageFirst': true},
    {'image': ('assets/images/f.png'), 'letter': 'F', 'showImageFirst': true},
    {'image': ('assets/images/g.png'), 'letter': 'G', 'showImageFirst': true},
    {'image': ('assets/images/h.png'), 'letter': 'H', 'showImageFirst': true},
    {'image': ('assets/images/i.png'), 'letter': 'I', 'showImageFirst': true},
    {'image': ('assets/images/k.png'), 'letter': 'K', 'showImageFirst': true},
    {'image': ('assets/images/l.png'), 'letter': 'L', 'showImageFirst': true},
    {'image': ('assets/images/m.png'), 'letter': 'M', 'showImageFirst': true},
    {'image': ('assets/images/n.png'), 'letter': 'N', 'showImageFirst': true},
    {'image': ('assets/images/o.png'), 'letter': 'O', 'showImageFirst': true},
    {'image': ('assets/images/p.png'), 'letter': 'P', 'showImageFirst': true},
    {'image': ('assets/images/q.png'), 'letter': 'Q', 'showImageFirst': true},
    {'image': ('assets/images/r.png'), 'letter': 'R', 'showImageFirst': true},
    {'image': ('assets/images/s.png'), 'letter': 'S', 'showImageFirst': true},
    {'image': ('assets/images/t.png'), 'letter': 'T', 'showImageFirst': true},
    {'image': ('assets/images/u.png'), 'letter': 'U', 'showImageFirst': true},
    {'image': ('assets/images/v.png'), 'letter': 'V', 'showImageFirst': true},
    {'image': ('assets/images/w.png'), 'letter': 'W', 'showImageFirst': true},
    {'image': ('assets/images/x.png'), 'letter': 'X', 'showImageFirst': true},
    {'image': ('assets/images/y.png'), 'letter': 'Y', 'showImageFirst': true},
  ];
  int _currentIndex = 0;
  bool _isFront = true;

  // when card flips, turn card around
  void _flipCard() {
    setState(() {
      _isFront = !_isFront;
    });
  }

  // when next card, flips car back to image
  void _nextCard() {
    setState(() {
      _isFront = true;
      _currentIndex++;
    });
  }

  void _previousCard() {
    setState(() {
      _isFront = true;
      _currentIndex = (_currentIndex - 1) % flashcards.length;
    });
  }

  // builds page with flashcards that will flip horizontally
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  onPressed: () {
                    // If in the first question, pop back to main menu
                    if (_currentIndex == 0) {
                      Navigator.pop(context);
                    } else {
                      // otherwise, go back a question
                      setState(() {
                        _previousCard();
                      });
                    }
                  },
                  // Set return button styling
                  icon: const Icon(
                    CupertinoIcons.back,
                    size: 35,
                    color: kPrimaryColor,
                  ),
                ),
                ProgressBar(currentQuestion: _currentIndex, totalQuestions: 24),
                IconButton(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  onPressed: () {
                    if (_currentIndex < 24) {
                      setState(() {
                        _nextCard();
                      });
                    } else {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResultsPage()));
                    }
                  },
                  // Set "next" button styling
                  icon: const Icon(
                    CupertinoIcons.forward,
                    size: 35,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Column(
              children: const [
                Text(
                  "Test Your Knowledge",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Tap the card to reveal the answer",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Container(
                  height: 350,
                  width: 250,
                  decoration: BoxDecoration(
                    color: const Color(0x80F7BF4F),
                    border: Border.all(color: kPrimaryColor, width: 10),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                      front: Image.asset(
                        flashcards[_currentIndex]['image'],
                        fit: BoxFit.fitWidth,
                      ),
                      back: Text(
                        flashcards[_currentIndex]['letter'],
                        style: const TextStyle(
                          fontSize: 64.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      flipOnTouch: true,
                      onFlip: _flipCard,
                      onFlipDone: (_) {
                        setState(() {
                          _isFront = !_isFront;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.only(right: 20, bottom: 20),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => kSecondaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(33.0))),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 18)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(150, 45))),
                  onPressed: () {
                    if (_currentIndex < 23) {
                      setState(() {
                        _nextCard();
                      });
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResultsPage(),
                        ),
                      );
                    }
                  },
                  child: Text(_currentIndex < 23 ? 'NEXT' : 'See Results',
                      style: const TextStyle(fontWeight: FontWeight.bold))),
            ),
          ],
        ),
      ),
    );
  }
}
