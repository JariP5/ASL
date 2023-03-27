import 'package:flutter/material.dart';

import './dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  // @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Flutter Hello World',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // A widget which will be started on application startup
      home: const ASLHomePage(title: 'ASL Home Page'),
    );
  }
}

class ASLHomePage extends StatelessWidget {
  final String title;
  const ASLHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'images/ASLearning-logos.jpeg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          const SizedBox(height: 400),
          ElevatedButton(
            child: Text('Press me!'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ASLDashboard()),
              );
            },
            // on press go to new page or something
          )
        ]),
      );
}

// can probably remove all of this, it is all on quiz1.dart
