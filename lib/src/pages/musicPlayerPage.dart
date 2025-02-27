import 'package:flutter/material.dart';
import 'package:music_app/src/widgets/style.dart';
import 'package:music_app/src/widgets/text.dart';
import 'package:music_app/src/widgets/title.dart';

class MusicPlayerPage extends StatelessWidget {
  const MusicPlayerPage({super.key, this.titreMusique="Musique inconnue", this.artiste="Inconnu", this.album="Aucun"});

  final String titreMusique;
  final String artiste;
  final String album;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: StyleDarkMode.backgroundColor,

      /* L'appBar avec le bouton retour et la searchBar */
      appBar: AppBar(
        title: const UiTitle(title: "Music player"),
        centerTitle: true,
        backgroundColor: StyleDarkMode.backgroundColor,
        
        /* Bouton de retour */
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(), /* Retourne sur la dernière page */
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: 'Retour',
          color: StyleDarkMode.titleColor,
          ),
      ),


      /* Body avec la liste des recherches */
      body: Center(
        child: Column(
          children: [
            UiTitle(title: titreMusique),
            TextDefault(text: 'Album: $album - Artiste: $artiste'),
          ],
        )
      ),
    );


    // return Scaffold(
    //   appBar: AppBar(
    //       backgroundColor: const Color.fromRGBO(0, 0, 0, 1),// Theme.of(context).colorScheme.inversePrimary,
    //       title: Text(title),
    //     ),
    // );



  //   return DefaultTabController(
  //     length: 2,
  //     child: Scaffold(
  //       appBar: AppBar(
  //         // bottom: const TabBar(tabs: [
  //         //   Tab(icon: Icon(Icons.info_outline_rounded),),
  //         //   Tab(icon: Icon(Icons.person_2_rounded),)
  //         // ]),
  //       ),
  //       bottomNavigationBar: const TabBar(
  //         // labelColor: Colors.white,
  //         // unselectedLabelColor: Colors.white70,
  //         // indicatorSize: TabBarIndicatorSize.tab,
  //         // indicatorPadding: EdgeInsets.all(5.0),
  //         // indicatorColor: Colors.blue,
  //         tabs: [
  //           Tab(icon: Icon(Icons.info_outline_rounded),),
  //           Tab(icon: Icon(Icons.person_2_rounded),)
  //         ]
  //       ),
  //       body: const TabBarView(children: [

  //         Column(children: [
  //           Row(children: [
  //             const Text("Paragraphe de la page d'accueil suivi d'une image ! "),
  //             const Image(image: AssetImage('assets/images/boutonCroix.png')),
  //           ],)
  //         ],),

  //         // ViewAbout(),
  //       ]),
  //     )
  // );
}
}