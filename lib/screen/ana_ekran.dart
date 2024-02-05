import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kelime_oyunu/data.dart';
import 'package:kelime_oyunu/widgets/harf_kutusu.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});
  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  TextEditingController tahminController = TextEditingController();
  int orjinalSure = 60;
  int kalanSure = 60;
  Timer? timer;
  List kelime = [];
  List gorunenKelime = [];
  int hak = 5;
  int tahminSayisi = 0;
  List gorunenKelimeler = [];
  bool tahminEdebilir = false;
  bool sureyiBaslat = true;
  String mesaj = "";
  bool oyunBitti = false;
  bool kazandiMi = false;

  String yeniKelime() {
    var randSayi = Random().nextInt(words.length);
    return words[randSayi];
  }

  void oyunuYenile() {
    setState(() {
      kelime = yeniKelime().toUpperCase().split("");
      kalanSure = orjinalSure;
      gorunenKelime = [];
      hak = 5;
      tahminSayisi = 0;
      gorunenKelimeler = [];
      tahminEdebilir = false;
      sureyiBaslat = true;
      tahminController.text = "";
      oyunBitti = false;
      kazandiMi = false;
      timer!.cancel();
    });
  }

  void tahmin(String tahminKelime) {
    print("tahmin edilen kelime $tahminKelime");
    print("tahmin edilen kelime ${kelime.join()}");
    for (int j = 0; j < kelime.length; j++) {
      if (kelime[j] == tahminKelime[j]) {
        gorunenKelimeler[tahminSayisi][j] = "+${tahminKelime[j]}";
      } else {
        gorunenKelimeler[tahminSayisi][j] = "-${tahminKelime[j]}";
      }

      if (kelime.contains(tahminKelime[j]) &&
          !gorunenKelimeler[tahminSayisi].contains("+${tahminKelime[j]}")) {
        gorunenKelimeler[tahminSayisi][j] = "?${tahminKelime[j]}";
      }
    }

    if (kelime.join() == tahminKelime) {
      mesaj = "TEBRİKLER";
      oyunBitti = true;
      kazandiMi = true;
      timer!.cancel();
    }

    tahminSayisi++;
    tahminController.text = "";
    tahminEdebilir = false;
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (kalanSure == 0) {
          setState(() {
            timer.cancel();
            oyunBitti = true;
          });
        } else {
          setState(() {
            kalanSure--;
            mesaj = "Kalan süre : $kalanSure";
          });
        }
      },
    );
  }

  List gorunenKelimeOlustur(int uzunluk) {
    List gorunenKelime = [];
    for (int i = 0; i < uzunluk; i++) {
      gorunenKelime.add("  ");
    }
    return gorunenKelime;
  }

  @override
  void initState() {
    super.initState();
    kelime = yeniKelime().toUpperCase().split("");
  }

  @override
  Widget build(BuildContext context) {
    if (sureyiBaslat) {
      sureyiBaslat = false;
      startTimer();
    }
    if (!kazandiMi && (kalanSure == 0 || hak == 0)) {
      mesaj = "KELİME ŞUYDU : ${kelime.join()}";
      oyunBitti = true;
      timer!.cancel();
    }
    print(kelime);
    if (gorunenKelime.length != kelime.length) {
      gorunenKelime = [kelime[0]];
      for (int i = 1; i < kelime.length; i++) {
        gorunenKelime.add("  ");
      }
    }
    if (gorunenKelimeler.isEmpty) {
      gorunenKelimeler.add(gorunenKelime);
      for (int i = 1; i < hak; i++) {
        gorunenKelimeler.add(gorunenKelimeOlustur(kelime.length));
      }
    }
    print(gorunenKelimeler);
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(children: [
            ...gorunenKelimeler.map(
              (e) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [...e.map((e2) => Harf(harf: e2))],
              ),
            )
          ]),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: oyunBitti && kazandiMi
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.error,
            ),
            child: Text(
              mesaj,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (word) {
                      print(word);
                      if (word.length == kelime.length) {
                        tahminEdebilir = true;
                      } else {
                        tahminEdebilir = false;
                      }
                      setState(() {});
                    },
                    controller: tahminController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Tahmininizi buraya yazın...",
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text("Hakkınız: $hak"),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: tahminEdebilir &&
                                kalanSure > 0 &&
                                hak > 0 &&
                                !oyunBitti
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.error,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.check),
                        color: Colors.white,
                        onPressed: tahminEdebilir &&
                                kalanSure > 0 &&
                                hak > 0 &&
                                !oyunBitti
                            ? () {
                                tahmin(tahminController.text.toUpperCase());
                                setState(() {
                                  hak--;
                                  kalanSure = orjinalSure;
                                });
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      oyunuYenile();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
