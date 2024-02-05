import 'package:flutter/material.dart';

class Oyun extends StatefulWidget {
  const Oyun({super.key});

  @override
  State<Oyun> createState() => _OyunState();
}

class _OyunState extends State<Oyun> {
  @override
  Widget build(BuildContext context) {
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
