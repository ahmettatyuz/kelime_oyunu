import 'package:flutter/material.dart';
import 'package:kelime_oyunu/data.dart';
import 'package:kelime_oyunu/screen/kategoriler/kategori.dart';
import 'package:kelime_oyunu/screen/oyun_controller.dart';

class Kategoriler extends StatefulWidget {
  const Kategoriler({super.key});

  @override
  State<Kategoriler> createState() => _KategorilerState();
}

class _KategorilerState extends State<Kategoriler> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: const EdgeInsets.all(10),
        children: [
          Kategori(
              name: "Fiiller",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const OyunController(
                      data: fiiller,
                      kategori: "Fiiller",
                    ),
                  ),
                );
              }),
          Kategori(
              name: "İngilizce",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const OyunController(
                      data: english,
                      kategori: "İngilizce",
                    ),
                  ),
                );
              }),
          Kategori(
              name: "Yiyecekler",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const OyunController(
                      data: yiyecekler,
                      kategori: "Yiyecekler",
                    ),
                  ),
                );
              }),
          Kategori(
              name: "Hayvanlar",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const OyunController(
                      data: hayvanlar,
                      kategori: "Hayvanlar",
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
