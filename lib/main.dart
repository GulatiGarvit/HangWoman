import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:hangwoman/homepage.dart';
import 'package:hangwoman/selector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Load ads.
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: SelectorPage(),
    );
  }
}
