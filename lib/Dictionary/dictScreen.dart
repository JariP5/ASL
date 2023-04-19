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
    'images/a.png': 'A',
    'images/b.png': 'B',
    'images/c.png': 'C',
    'images/d.png': 'D',
    'images/e.png': 'E',
    'images/f.png': 'F',
    'images/g.png': 'G',
    'images/h.png': 'H',
    'images/i.png': 'I',
    'images/k.png': 'K',
    'images/l.png': 'L',
    'images/m.png': 'M',
    'images/n.png': 'N',
    'images/o.png': 'O',
    'images/p.png': 'P',
    'images/q.png': 'Q',
    'images/r.png': 'R',
    'images/s.png': 'S',
    'images/t.png': 'T',
    'images/u.png': 'U',
    'images/v.png': 'V',
    'images/w.png': 'W',
    'images/x.png': 'X',
    'images/y.png': 'Y',
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
