import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:circular_countdown_timer/countdown_text_format.dart';
import 'package:flutter/material.dart';
import 'package:kelime_oyunu/helpers/stringHelper.dart';
import 'package:kelime_oyunu/widgets/harf_kutusu.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class Oyun extends StatefulWidget {
  Oyun({super.key, required this.kelime, required this.timerController});
  final List kelime;
  final CountDownController timerController;
  int hak = 4; // parametre olarak verilecek
  int sure = 10;
  List gorunenKelime = []; // parametre olarak verilecek
  int tahminSayisi = 0; // parametre
  List gorunenKelimeler = []; // parametre
  String mesaj = "";
  bool oyunBitti = false;
  bool tahminEdebilir = false;
  bool kazandiMi = false;
  bool sureBitti = false;
  TextEditingController tahminController = TextEditingController();
  // final CountdownController timerController =
  //     CountdownController(autoStart: true);
  @override
  State<Oyun> createState() => _OyunState();
}

class _OyunState extends State<Oyun> {
  bool kaybettiMi() {
    return widget.hak == 0 || widget.sureBitti;
  }

  void tahmin(String tahminKelime) {
    print("tahmin edilen kelime $tahminKelime");
    print("asıl kelime kelime ${widget.kelime.join()}");
    for (int j = 0; j < widget.kelime.length; j++) {
      if (widget.kelime[j] == tahminKelime[j]) {
        widget.gorunenKelimeler[widget.tahminSayisi][j] = "+${tahminKelime[j]}";
      } else {
        widget.gorunenKelimeler[widget.tahminSayisi][j] = "-${tahminKelime[j]}";
      }

      if (widget.kelime.contains(tahminKelime[j]) &&
          !widget.gorunenKelimeler[widget.tahminSayisi]
              .contains("+${tahminKelime[j]}")) {
        widget.gorunenKelimeler[widget.tahminSayisi][j] = "?${tahminKelime[j]}";
      }
    }

    if (widget.kelime.join() == tahminKelime) {
      widget.kazandiMi = true;
    } else {
      widget.timerController.restart();
    }

    widget.tahminSayisi++;
    widget.tahminController.text = "";
    widget.tahminEdebilir = false;
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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // oyun sonucunu kontrol et
    if (widget.kazandiMi) {
      widget.mesaj = "Tebrikler";
      widget.oyunBitti = true;
    } else if (kaybettiMi()) {
      widget.mesaj = "KELİME ŞUYDU : ${widget.kelime.join()}";
      widget.oyunBitti = true;
    }
    if (widget.oyunBitti) {
      widget.timerController.pause();
    }

    if (widget.gorunenKelime.length != widget.kelime.length) {
      widget.gorunenKelime = [widget.kelime[0]];
      for (int i = 1; i < widget.kelime.length; i++) {
        widget.gorunenKelime.add("  ");
      }
    }

    if (widget.gorunenKelimeler.isEmpty) {
      widget.gorunenKelimeler.add(widget.gorunenKelime);
      for (int i = 1; i < widget.hak; i++) {
        widget.gorunenKelimeler.add(gorunenKelimeOlustur(widget.kelime.length));
      }
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(children: [
            ...widget.gorunenKelimeler.map(
              (e) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [...e.map((e2) => Harf(harf: e2))],
              ),
            )
          ]),
          const SizedBox(
            height: 10,
          ),
          // Countdown(
          //   controller: widget.timerController,
          //   seconds: widget.sure,
          //   build: (_, double time) => Text(
          //     time.toString(),
          //     style: const TextStyle(
          //       fontSize: 20,
          //     ),
          //   ),
          //   interval: const Duration(milliseconds: 100),
          //   onFinished: () {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(
          //         content: Text('Timer is done!'),
          //       ),
          //     );
          //   },
          // ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: widget.mesaj.isNotEmpty
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.center,
            children: [
              widget.mesaj.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: widget.oyunBitti && widget.kazandiMi
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.error,
                      ),
                      child: Text(
                        upperCase(widget.mesaj),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    )
                  : const SizedBox(width: 0),
              CircularCountDownTimer(
                duration: widget.sure,
                initialDuration: 0,
                controller: widget.timerController,
                width: 50,
                height: 50,
                ringColor: Colors.grey[300]!,
                ringGradient: null,
                fillColor: kaybettiMi()
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.primary,
                fillGradient: null,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                backgroundGradient: null,
                strokeWidth: 20.0,
                strokeCap: StrokeCap.round,
                textStyle: const TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textFormat: CountdownTextFormat.S,
                isReverse: true,
                isReverseAnimation: true,
                isTimerTextShown: true,
                autoStart: true,
                onStart: () {
                  debugPrint('Countdown Started');
                },
                onComplete: () {
                  setState(() {
                    widget.sureBitti = true;
                  });
                  debugPrint('Countdown Ended');
                },
                onChange: (String timeStamp) {
                  debugPrint('Countdown Changed $timeStamp');
                },
                timeFormatterFunction: (defaultFormatterFunction, duration) {
                  if (duration.inMilliseconds == 0) {
                    return "Süre bitti";
                  } else {
                    return Function.apply(defaultFormatterFunction, [duration]);
                  }
                },
              ),
            ],
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
                      if (word.length == widget.kelime.length) {
                        widget.tahminEdebilir = true;
                      } else {
                        widget.tahminEdebilir = false;
                      }
                      setState(() {});
                    },
                    controller: widget.tahminController,
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
                    Text("Hakkınız: ${widget.hak}"),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: widget.tahminEdebilir &&
                                widget.hak > 0 &&
                                !widget.oyunBitti
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.error,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.check),
                        color: Colors.white,
                        onPressed: widget.tahminEdebilir &&
                                widget.hak > 0 &&
                                !widget.oyunBitti
                            ? () {
                                tahmin(
                                    widget.tahminController.text.toLowerCase());
                                setState(() {
                                  widget.hak--;
                                });
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
