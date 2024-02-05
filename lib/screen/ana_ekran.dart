import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:kelime_oyunu/data.dart';
import 'package:kelime_oyunu/screen/oyun.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});
  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  String yeniKelime() {
    var randSayi = Random().nextInt(words.length);
    return words[randSayi];
  }

  final CountDownController timerController = CountDownController();
  @override
  Widget build(BuildContext context) {
    List kelime = yeniKelime().toUpperCase().split("");
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            timerController.restart();
            setState(() {});
          },
          child: const Text("Yenile"),
        ),
        Oyun(
          kelime: kelime,
          timerController: timerController,
        ),
      ],
    );
  }
}
