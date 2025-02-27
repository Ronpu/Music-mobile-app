import 'package:flutter/material.dart';
import 'package:music_app/src/widgets/style.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {

    // return const UiTitle(title: "Page d'accueil");


    return Scaffold(
      backgroundColor: StyleDarkMode.backgroundColor,

      /* L'appBar avec le bouton retour et la searchBar */
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: StyleDarkMode.backgroundColor,

        title: SizedBox(
          height: StyleTextField.searchTextFieldHeight,
          child: TextField(
            style: const TextStyle(color: StyleDarkMode.textColor, fontSize: StyleTextField.fontSize),
            cursorColor: StyleDarkMode.mainColor,
            cursorHeight: StyleTextField.cursorHeight,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: 'Rechercher...',
              isCollapsed: true,
              prefixIcon: const Icon(Icons.search_rounded, color: StyleDarkMode.textColor,),
              hintStyle: const TextStyle(color: StyleDarkMode.textGreyColor),
              hintMaxLines: 1,
              filled: true,
              fillColor: StyleDarkMode.textFieldBackgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(StyleTextField.borderRadius),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(StyleTextField.borderRadius),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        
        /* Bouton de retour */
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(), /* Retourne sur la dernière page */
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: 'Retour',
          color: StyleDarkMode.titleColor,
          ),
      ),


      /* Body avec la liste des recherches */
      body: const Center(
        child: Text(
          'La recherche apparaît ici',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );


    // return Scaffold(
    //   appBar: AppBar(
    //       backgroundColor: const Color.fromRGBO(0, 0, 0, 1),// Theme.of(context).colorScheme.inversePrimary,
    //       title: Text(title),
    //     ),
    // );

  }
}