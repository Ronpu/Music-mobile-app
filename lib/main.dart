import 'package:flutter/material.dart';
// import 'package:flutter_application_1/src/pages/home.dart';
import 'package:music_app/src/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 51, 206, 206)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Music app'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
      body: PageHome(appTitle: 'Music app'), // ?????? widget.title

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => {
      //     setState(() {
      //       _counter++;
      //     })
      //   },
      //   tooltip: 'Ajouter',
      //   child: const Icon(Icons.add),
      // ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
