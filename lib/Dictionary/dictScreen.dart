import 'package:flutter/material.dart';

class ASLDictionaryScreen extends StatefulWidget {
  // creates the screen
  @override
  _ASLDictionaryScreenState createState() => _ASLDictionaryScreenState();
}

// class that that contains the search bar and the list of ASL images and their corresponding letters
class _ASLDictionaryScreenState extends State<ASLDictionaryScreen> {
  TextEditingController _searchController = TextEditingController();
  // user input
  String _searchText = '';

  // dictionary which assigns ASL images to their corresponding letters
  final Map<String, String> _Dictionary = {
    'assets/images/a.png': 'A',
    'assets/images/b.png': 'B',
    'assets/images/c.png': 'C',
    'assets/images/d.png': 'D',
    'assets/images/e.png': 'E',
    'assets/images/f.png': 'F',
    'assets/images/g.png': 'G',
    'assets/images/h.png': 'H',
    'assets/images/i.png': 'I',
    'assets/images/k.png': 'K',
    'assets/images/l.png': 'L',
    'assets/images/m.png': 'M',
    'assets/images/n.png': 'N',
    'assets/images/o.png': 'O',
    'assets/images/p.png': 'P',
    'assets/images/q.png': 'Q',
    'assets/images/r.png': 'R',
    'assets/images/s.png': 'S',
    'assets/images/t.png': 'T',
    'assets/images/u.png': 'U',
    'assets/images/v.png': 'V',
    'assets/images/w.png': 'W',
    'assets/images/x.png': 'X',
    'assets/images/y.png': 'Y',
  };

  // listens for user input
  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        // sets the seach bar to reflect use input
        _searchText = _searchController.text;
      });
    });
  }

  //. The ListView .
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          // used to get the text value entered by the user
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            icon: Icon(Icons.search),
          ),
        ),
      ),
      // displays a list of dictionary images
      body: ListView(
        children: _Dictionary.entries
            .map((entry) => _buildDictionaryRow(entry.key, entry.value))
            .toList(),
      ),
    );
  }

  // called for each dictonary item to build a row in the list
  Widget _buildDictionaryRow(String imagePath, String text) {
    if (_searchText.isNotEmpty &&
        !text.toLowerCase().contains(_searchText.toLowerCase())) {
      return Container();
    }

    // visual specifics of each row and how each dictionary image
    // will appear to the user
    return Row(
      children: [
        Image.asset(imagePath, height: 100, width: 100),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
