import 'package:ASL/Dashboard/dashboard_view.dart';
import 'package:ASL/Style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  // Needed to initalize camera and Firebase
  WidgetsFlutterBinding.ensureInitialized();
  // Needed to force phone orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // Boot/Start application
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      // Application name
      title: 'ASLearning',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: kPrimaryColor, secondary: kSecondaryColor)),
      // A widget which will be started on application startup
      home: const ASLSplashView(title: 'ASL Home Page'),
    );
  }
}

// This class holds the info for the splash screen of the app and prompts
// the user to be taken to the main menu
class ASLSplashView extends StatelessWidget {
  final String title;
  const ASLSplashView({super.key, required this.title});

  @override
  Widget build(BuildContext context) => Container(
        // Widget that places the app's logo as the background
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/ASLearning-logo.jpeg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                // Styling of Button that takes the user to the main menu
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
                          MaterialStateProperty.all(const Size(280, 65))),
                  child: const Text('START NOW!',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashboardView()),
                    );
                  },
                ),
              ),
            ),
          ),
        ]),
      );
}
