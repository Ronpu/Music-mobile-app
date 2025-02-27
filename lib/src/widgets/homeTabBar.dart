import 'package:flutter/material.dart';
import 'package:music_app/src/widgets/style.dart';

class HomeTabBar extends StatelessWidget {
  
  final List<Widget> listeBoutons;
  final List<Widget> listePages;

  const HomeTabBar({
    super.key,
    required this.listeBoutons,  
    required this.listePages
  });


  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length: listeBoutons.length,
      child: Column(
        children: <Widget>[
          Container(
            constraints: const BoxConstraints( maxHeight: 80, minHeight: 40),
            child: Material(
              color: Colors.black,
              child: TabBar(
                isScrollable: false,
                dividerColor: Colors.transparent,
                unselectedLabelColor: StyleDarkMode.textColor,
                labelColor: StyleDarkMode.mainColor,
                indicatorColor: StyleDarkMode.mainColor,
                labelStyle: const TextStyle(fontSize: StyleTextDefault.fontSize),

                /* Les "boutons" */
                tabs: listeBoutons,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              /* Les pages liées aux boutons */
              children: listePages
            ),
          ),
        ],
      ),
    );


    /* FONCTIONNE MAIS PAS MOYEN DE METTRE UN BACKGROUND COLOR */
    // DefaultTabController(
    //   length: listeBoutons.length,
    //   child: Scaffold(

        
    //     /* Les "boutons" */
    //     appBar: TabBar(
    //       tabs: listeBoutons,

    //       isScrollable: false,
    //       dividerColor: Colors.transparent,
    //       unselectedLabelColor: StyleTextDefault.color,
    //       labelColor: StyleTextSelected.color,
    //       indicatorColor: StyleTextSelected.color,
    //       labelStyle: const TextStyle(fontSize: StyleTextDefault.fontSize),
    //     ),

    //     /* Les pages liées aux boutons */
    //     body: TabBarView(
    //       children: listePages,
    //     ),

    //   )
    // );
  }
}

