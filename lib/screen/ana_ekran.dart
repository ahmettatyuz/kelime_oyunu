import 'package:flutter/material.dart';
import 'package:kelime_oyunu/screen/kategoriler/kategoriler.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});
  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "KATEGORİLER",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const Kategoriler(),
      ],
    );
  }
}
