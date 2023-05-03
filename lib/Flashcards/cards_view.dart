import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class Flashcard extends StatelessWidget {
  final String imagePath;
  final String letter;

  const Flashcard({Key? key, required this.imagePath, required this.letter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      front: Container(
          child: Image(
        image: AssetImage(imagePath),
      )),
      back: Container(
        child: Text(
          letter,
          style: TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}

class FlashcardsView extends StatefulWidget {
  final List<Map<String, dynamic>> flashcards = [
    {'image': ('images/a.png'), 'letter': 'A', 'showImageFirst': true},
    {'image': ('images/b.png'), 'letter': 'B', 'showImageFirst': true},
    {'image': ('images/c.png'), 'letter': 'C', 'showImageFirst': true},
    {'image': ('images/d.png'), 'letter': 'D', 'showImageFirst': true},
    {'image': ('images/e.png'), 'letter': 'E', 'showImageFirst': true},
    {'image': ('images/f.png'), 'letter': 'F', 'showImageFirst': true},
    {'image': ('images/g.png'), 'letter': 'G', 'showImageFirst': true},
    {'image': ('images/h.png'), 'letter': 'H', 'showImageFirst': true},
    {'image': ('images/i.png'), 'letter': 'I', 'showImageFirst': true},
    {'image': ('images/k.png'), 'letter': 'K', 'showImageFirst': true},
    {'image': ('images/l.png'), 'letter': 'L', 'showImageFirst': true},
    {'image': ('images/m.png'), 'letter': 'M', 'showImageFirst': true},
    {'image': ('images/n.png'), 'letter': 'N', 'showImageFirst': true},
    {'image': ('images/o.png'), 'letter': 'O', 'showImageFirst': true},
    {'image': ('images/p.png'), 'letter': 'P', 'showImageFirst': true},
    {'image': ('images/r.png'), 'letter': 'R', 'showImageFirst': true},
    {'image': ('images/s.png'), 'letter': 'S', 'showImageFirst': true},
    {'image': ('images/t.png'), 'letter': 'T', 'showImageFirst': true},
    {'image': ('images/u.png'), 'letter': 'U', 'showImageFirst': true},
    {'image': ('images/v.png'), 'letter': 'V', 'showImageFirst': true},
    {'image': ('images/w.png'), 'letter': 'W', 'showImageFirst': true},
    {'image': ('images/x.png'), 'letter': 'X', 'showImageFirst': true},
    {'image': ('images/y.png'), 'letter': 'Y', 'showImageFirst': true},
  ];
  @override
  _FlashcardsViewState createState() => _FlashcardsViewState();
}

class _FlashcardsViewState extends State<FlashcardsView> {
  int _currentIndex = 0;
  bool _isFront = true;

  void _flipCard() {
    setState(() {
      _isFront = !_isFront;
    });
  }

  void _nextCard() {
    setState(() {
      _isFront = true;
      _currentIndex = (_currentIndex + 1) % widget.flashcards.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcards'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: FlipCard(
                direction: FlipDirection.HORIZONTAL,
                front: Container(
                  child: Image.asset(
                    widget.flashcards[_currentIndex]['image'],
                    fit: BoxFit.cover,
                  ),
                ),
                back: Container(
                  child: Text(
                    widget.flashcards[_currentIndex]['letter'],
                    style: TextStyle(
                      fontSize: 64.0,
                      fontWeight: FontWeight.bold,
                    ),
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
          Container(
            margin: EdgeInsets.only(bottom: 16.0, right: 16.0),
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: _nextCard,
              shape: RoundedRectangleBorder(
                  //borderRadius: BorderRadius.circular(10.0),
                  ),
              child: Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
