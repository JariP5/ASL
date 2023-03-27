import 'package:flutter/material.dart';

class ASLDashboard extends StatelessWidget {
  final String title;
  const ASLDashboard({super.key, required this.title});

  @override
  Widget build(BuildContext context) => Container(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        const SizedBox(height: 700),
        Padding(padding: EdgeInsets.only(top: 5)),
        ElevatedButton(
          child: Text('Practice'),
          onPressed: () {},
          // on press go to new page or something
        ),
        ElevatedButton(
          child: Text('Learn'),
          onPressed: () {},
          // on press go to new page or something
        ),
        ElevatedButton(
          child: Text('Dictionary'),
          onPressed: () {},
          // on press go to new page or something
        ),
      ]));
}
