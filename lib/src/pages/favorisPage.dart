import 'package:flutter/material.dart';
import 'package:music_app/src/widgets/text.dart';

// Une view est la "fausse page" faite pour le menu en bas de la page home

class FavorisPage extends StatelessWidget {
  const FavorisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Row(children: [
        Icon(Icons.play_circle_fill_rounded),
        TextDefault(text: "Liste des favoris"),
      ],),
    ],);
  }
}