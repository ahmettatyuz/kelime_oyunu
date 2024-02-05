import 'package:flutter/material.dart';

class Kategori extends StatelessWidget {
  const Kategori({super.key, required this.name, required this.onPressed});
  final String name;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Theme.of(context).colorScheme.primary,
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
