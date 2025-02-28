import 'package:flutter/material.dart';
import 'package:music_app/src/pages/albumsPage.dart';
import 'package:music_app/src/pages/favorisPage.dart';
import 'package:music_app/src/pages/morceauxPage.dart';
import 'package:music_app/src/pages/searchPage.dart';
import 'package:music_app/src/widgets/homeTabBar.dart';
import 'package:music_app/src/widgets/style.dart';
import 'package:music_app/src/widgets/title.dart';

class PageHome extends StatelessWidget {

  final String appTitle;

  const PageHome({
      super.key,
      required this.appTitle
    });

  @override
  Widget build(BuildContext context) {


    List<Widget> listeBoutons = [const Text("Morceaux"), const Text("Albums"), const Text("Favoris")];
    List<Widget> listePages = [MorceauxPage(), const AlbumsPage(), const FavorisPage()];


    return DefaultTabController(
      length: 2,
      child: Scaffold(

        /* Barre avec titre, bouton recherche et bouton paramêtres */
        appBar: AppBar(
          backgroundColor: StyleDarkMode.backgroundColor,
          title: UiTitle(title: appTitle),

          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search_rounded),
              tooltip: 'Rechercher morceaux',
              onPressed: () {
                // ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('This is a snackbar')));
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SearchPage()
                  )
                );
              },
            ),
            
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Paramêtres',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text('Bidules paramêtres'),
                      ),
                      body: const Center(
                        child: Text(
                          'JSP',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  },
                ));
              },
            ),
          ],
        ),

        
        /* Body avec la barre qui fait défiler les pages différentes (HomeTabBar.dart) */
        body: Container(
          color: StyleDarkMode.backgroundColor,
          child: HomeTabBar(listeBoutons: listeBoutons, listePages: listePages),
        )
      )
  );
}
}