import 'package:flutter/material.dart';
import 'package:music_app/src/widgets/text.dart';

// Une view est la "fausse page" faite pour le menu en bas de la page home

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Row(children: [
        Icon(Icons.music_video),
        TextDefault(text: "Albums de musique"),
      ],),
    ],);
  }
}