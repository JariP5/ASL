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
    imagePath: 'assets/images/c.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'J', isCorrect: false),
      const Option(text: 'K', isCorrect: false),
      const Option(text: 'P', isCorrect: false),
      const Option(text: 'B', isCorrect: true),
    ],
    imagePath: 'assets/images/b.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'T', isCorrect: false),
      const Option(text: 'A', isCorrect: true),
      const Option(text: 'I', isCorrect: false),
      const Option(text: 'M', isCorrect: false),
    ],
    imagePath: 'assets/images/a.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'A', isCorrect: false),
      const Option(text: 'Z', isCorrect: false),
      const Option(text: 'Q', isCorrect: true),
      const Option(text: 'X', isCorrect: false),
    ],
    imagePath: 'assets/images/q.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'W', isCorrect: true),
      const Option(text: 'Q', isCorrect: false),
      const Option(text: 'E', isCorrect: false),
      const Option(text: 'R', isCorrect: false),
    ],
    imagePath: 'assets/images/w.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'O', isCorrect: true),
      const Option(text: 'G', isCorrect: false),
      const Option(text: 'J', isCorrect: false),
      const Option(text: 'H', isCorrect: false),
    ],
    imagePath: 'assets/images/o.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'T', isCorrect: false),
      const Option(text: 'Y', isCorrect: true),
      const Option(text: 'U', isCorrect: false),
      const Option(text: 'I', isCorrect: false),
    ],
    imagePath: 'assets/images/y.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'P', isCorrect: false),
      const Option(text: 'M', isCorrect: false),
      const Option(text: 'K', isCorrect: false),
      const Option(text: 'L', isCorrect: true),
    ],
    imagePath: 'assets/images/l.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'O', isCorrect: false),
      const Option(text: 'V', isCorrect: true),
      const Option(text: 'B', isCorrect: false),
      const Option(text: 'N', isCorrect: false),
    ],
    imagePath: 'assets/images/v.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'X', isCorrect: false),
      const Option(text: 'G', isCorrect: false),
      const Option(text: 'D', isCorrect: true),
      const Option(text: 'Y', isCorrect: false),
    ],
    imagePath: 'assets/images/d.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'T', isCorrect: true),
      const Option(text: 'W', isCorrect: false),
      const Option(text: 'H', isCorrect: false),
      const Option(text: 'Z', isCorrect: false),
    ],
    imagePath: 'assets/images/t.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'E', isCorrect: true),
      const Option(text: 'V', isCorrect: false),
      const Option(text: 'D', isCorrect: false),
      const Option(text: 'O', isCorrect: false),
    ],
    imagePath: 'assets/images/e.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'I', isCorrect: false),
      const Option(text: 'S', isCorrect: false),
      const Option(text: 'H', isCorrect: true),
      const Option(text: 'G', isCorrect: false),
    ],
    imagePath: 'assets/images/h.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'D', isCorrect: false),
      const Option(text: 'I', isCorrect: false),
      const Option(text: 'V', isCorrect: false),
      const Option(text: 'M', isCorrect: true),
    ],
    imagePath: 'assets/images/m.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'F', isCorrect: true),
      const Option(text: 'K', isCorrect: false),
      const Option(text: 'W', isCorrect: false),
      const Option(text: 'Y', isCorrect: false),
    ],
    imagePath: 'assets/images/f.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'K', isCorrect: false),
      const Option(text: 'A', isCorrect: false),
      const Option(text: 'B', isCorrect: false),
      const Option(text: 'G', isCorrect: true),
    ],
    imagePath: 'assets/images/g.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'B', isCorrect: false),
      const Option(text: 'N', isCorrect: false),
      const Option(text: 'R', isCorrect: false),
      const Option(text: 'I', isCorrect: true),
    ],
    imagePath: 'assets/images/i.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'O', isCorrect: false),
      const Option(text: 'P', isCorrect: false),
      const Option(text: 'T', isCorrect: false),
      const Option(text: 'N', isCorrect: true),
    ],
    imagePath: 'assets/images/n.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'K', isCorrect: true),
      const Option(text: 'Q', isCorrect: false),
      const Option(text: 'I', isCorrect: false),
      const Option(text: 'O', isCorrect: false),
    ],
    imagePath: 'assets/images/k.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'D', isCorrect: false),
      const Option(text: 'K', isCorrect: false),
      const Option(text: 'R', isCorrect: true),
      const Option(text: 'Y', isCorrect: false),
    ],
    imagePath: 'assets/images/r.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'S', isCorrect: false),
      const Option(text: 'P', isCorrect: true),
      const Option(text: 'U', isCorrect: false),
      const Option(text: 'A', isCorrect: false),
    ],
    imagePath: 'assets/images/p.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'C', isCorrect: false),
      const Option(text: 'K', isCorrect: false),
      const Option(text: 'V', isCorrect: false),
      const Option(text: 'U', isCorrect: true),
    ],
    imagePath: 'assets/images/u.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'R', isCorrect: false),
      const Option(text: 'O', isCorrect: false),
      const Option(text: 'X', isCorrect: true),
      const Option(text: 'V', isCorrect: false),
    ],
    imagePath: 'assets/images/x.png',
  ),
  Question(
    text: 'What is the letter for this sign?',
    options: [
      const Option(text: 'N', isCorrect: false),
      const Option(text: 'F', isCorrect: false),
      const Option(text: 'S', isCorrect: true),
      const Option(text: 'M', isCorrect: false),
    ],
    imagePath: 'assets/images/s.png',
  ),
];
