import 'package:flutter/material.dart';
import 'package:music_app/src/pages/home.dart';
import 'package:music_app/src/widgets/title.dart';

class PageLogin extends StatelessWidget {
  const PageLogin({super.key});

  @override
  Widget build(BuildContext context) {


    /* ACTUELLEMENT PAS UTILISE PAR CE PROJET */

    return Center(
      child: Column(children: [
        const UiTitle(title: "Me connecter",),
        ElevatedButton(onPressed: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PageHome(appTitle: 'Music app')
            )
          )
        },
        child: const Text("bouton")
        )
      ])
    );

  }
}