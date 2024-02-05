import 'package:flutter/material.dart';

class Harf extends StatefulWidget {
  const Harf({super.key, required this.harf});
  final String harf;
  @override
  State<Harf> createState() => _HarfState();
}

class _HarfState extends State<Harf> {
  @override
  Widget build(BuildContext context) {
    Color? harfRengi;
    if (widget.harf.trim().isEmpty || widget.harf.startsWith("-")) {
      harfRengi = Theme.of(context).colorScheme.secondary;
    } else if (widget.harf.trim().startsWith("+")) {
      harfRengi = Theme.of(context).colorScheme.primary;
    } else if (widget.harf.trim().startsWith("?")) {
      harfRengi = Colors.orange;
    } else {
      harfRengi = Theme.of(context).colorScheme.secondary;
    }
    return Container(
      decoration: BoxDecoration(
        color: harfRengi,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.all(10),
      child: Text(
        widget.harf
            .replaceAll("i", "İ")
            .toUpperCase()
            .replaceAll("-", "")
            .replaceAll("+", "")
            .replaceAll("?", ""),
        // widget.harf.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Theme.of(context).colorScheme.background),
      ),
    );
  }
}
