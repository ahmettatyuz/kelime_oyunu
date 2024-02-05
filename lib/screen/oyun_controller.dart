import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:kelime_oyunu/screen/oyun.dart';

class OyunController extends StatefulWidget {
  const OyunController({super.key, required this.data, required this.kategori});
  final List data;
  final String kategori;

  @override
  State<OyunController> createState() => _OyunControllerState();
}

class _OyunControllerState extends State<OyunController> {
  String yeniKelime() {
    var randSayi = Random().nextInt(widget.data.length);
    return widget.data[randSayi];
  }

  final CountDownController timerController = CountDownController();

  void sonraki() {
    timerController.restart();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(widget.data);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.kategori,
          style: const TextStyle(
            letterSpacing: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Oyun(
            kelime: yeniKelime().toLowerCase().split(""),
            timerController: timerController,
            sonraki: sonraki,
          )
        ],
      ),
    );
  }
}
