import 'package:flutter/material.dart';
// import 'package:flutter_application_1/src/pages/home.dart';
import 'package:music_app/src/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music app',
      home: MyHomePage(title: 'Music app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  final String title;
  
  const MyHomePage({
    super.key,
    required this.title
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
      body: PageHome(appTitle: 'Music app'), 

    );
  }
}
