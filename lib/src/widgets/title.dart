import 'package:flutter/material.dart';
import 'package:music_app/src/widgets/style.dart';

class UiTitle extends StatelessWidget {
  const UiTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // return Text(title);

    return Container(
      margin: StyleUiTitle.margin, // Je veux changer l'écriture (Chatgpt)
      child: Text(
        title,
        // style: Theme.of(context).textTheme.headlineLarge
        style: const TextStyle(
          fontSize: StyleUiTitle.fontSize,
          color: StyleDarkMode.titleColor,
        ),
      ),
    );
  }
}