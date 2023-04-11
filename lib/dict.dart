import 'package:flutter/material.dart';

class ASLDictionaryScreen extends StatefulWidget {
  @override
  _ASLDictionaryScreenState createState() => _ASLDictionaryScreenState();
}

class _ASLDictionaryScreenState extends State<ASLDictionaryScreen> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';

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

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            icon: Icon(Icons.search),
          ),
        ),
      ),
      body: ListView(
        children: _Dictionary.entries
            .map((entry) => _buildDictionaryRow(entry.key, entry.value))
            .toList(),
      ),
    );
  }

  Widget _buildDictionaryRow(String imagePath, String text) {
    if (_searchText.isNotEmpty &&
        !text.toLowerCase().contains(_searchText.toLowerCase())) {
      return Container();
    }

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

class Dictionary extends StatelessWidget {
  final Map<String, String> _dictionary = {
    'A': 'assets/images/a.png',
    'B': 'assets/images/b.png',
    'C': 'assets/images/c.png',
    'D': 'assets/images/d.png',
    'E': 'assets/images/e.png',
    'F': 'assets/images/f.png',
    'G': 'assets/images/g.png',
    'H': 'assets/images/h.png',
    'I': 'assets/images/i.png',
    'K': 'assets/images/k.png',
    'L': 'assets/images/l.png',
    'M': 'assets/images/m.png',
    'N': 'assets/images/n.png',
    'O': 'assets/images/o.png',
    'P': 'assets/images/p.png',
    'Q': 'assets/images/q.png',
    'R': 'assets/images/r.png',
    'S': 'assets/images/s.png',
    'T': 'assets/images/t.png',
    'U': 'assets/images/u.png',
    'V': 'assets/images/v.png',
    'W': 'assets/images/w.png',
    'X': 'assets/images/x.png',
    'Y': 'assets/images/y.png',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Dictionary'),
      ),
      body: ListView.builder(
        itemCount: _dictionary.length,
        itemBuilder: (context, index) {
          final key = _dictionary.keys.elementAt(index);
          final value = _dictionary[key];
          return ListTile(
            leading: Image.asset('assets/images/a.png'),
            title: Text(key),
          );
        },
      ),
    );
  }
}
