import "package:flutter/material.dart";
import 'package:kelime_oyunu/screen/ana_ekran.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Lingo",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: const Color.fromARGB(255, 1, 147, 50),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "LİNGO",
            style: TextStyle(
              letterSpacing: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: const AnaEkran(),
      ),
    );
  }
}
