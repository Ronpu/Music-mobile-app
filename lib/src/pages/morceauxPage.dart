import 'package:flutter/material.dart';
import 'package:music_app/src/pages/musicPlayerPage.dart';
import 'package:music_app/src/widgets/style.dart';
import 'package:music_app/src/widgets/text.dart';
// import 'package:music_app/src/widgets/musicFind.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';


class MorceauxPage extends StatefulWidget {
  final bool permissionsStorage = false;
  final List<String> listeMorceaux = <String>[];

  @override
  createState() => new MorceauxPageState();
}

class MorceauxPageState extends State<MorceauxPage> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true; // Pour pas perdre la liste en changeant de page. Grâce à AutomaticKeepAliveClientMixin
  
  // const MorceauxPage({super.key}); // Ancien, quand la page était StatelessWidget
  bool permissionsStorage = false;
  List<String> listeMorceaux = <String>[];
  bool isLoading = false;

  @override
  void initState() {
    listeMorceaux = widget.listeMorceaux;
    super.initState();
    // build(context); // truc idiot que j'ai ajouté ?
    // _loadMusicFiles();
  }

  // Refresh les musics quand le widget est à nouveau sur l'écran
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _loadMusicFiles();
  }

  @override
  Widget build(BuildContext context) {

    _loadMusicFiles();

    // List<String> listeMorceaux = <String>['A', 'B', 'C'];

    return ListView.builder(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15,), /* Padding de l'ensemble des lignes */
      scrollDirection: Axis.vertical,
      itemCount: listeMorceaux.length, /* Nombre de ligne */
      itemBuilder: (BuildContext context, int index) {
        
        // if (index == listeMorceaux.length){
        //   return const Padding(
        //       padding: EdgeInsets.symmetric(vertical: 16.0),
        //       child: Center(child: CircularProgressIndicator()),
        //     );
        // }
        
        return GestureDetector(
          child: Container(

            height: 30,
            decoration: BoxDecoration(
              color: StyleDarkMode.itemBackgroundColor,
              borderRadius: BorderRadius.circular(5),
            ),
            margin: const EdgeInsets.only(top: 1, bottom: 1,),/* Margin des lignes */
            padding: const EdgeInsets.only(left: 5), /* Padding des lignes */

            /* Ecritures dans les lignes */
            child: 
            ListView.builder(
              itemCount: listeMorceaux.length + (isLoading ? 1 : 0), // Add 1 for the loading indicator if still loading
              itemBuilder: (context, index) {
                if (index < listeMorceaux.length) {
                  // Return the normal row with song information
                  return GestureDetector(
                    onTap: () {
                      // Handle song selection
                    },
                    child: Container(
                      // padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.play_circle_fill_rounded),
                          TextDefault( text: listeMorceaux[index], pMargin: const EdgeInsets.only(left: 5), ),
                          TextDefault( text: 'Artiste : ???${listeMorceaux.length}-$index-$isLoading', pMargin: const EdgeInsets.only(left: 60), ),
                        ],
                      ),
                    ),
                  );
                } else {
                  // Return the loading indicator at the bottom if still loading
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            )

            // //
            // Column(
            //   children: [
            //     Row(
            //       children: [
            //         const Icon(Icons.play_circle_fill_rounded),         /* Margin du texte de la ligne (met un espace après l'icone) */
            //         TextDefault(text: listeMorceaux[index], pMargin: const EdgeInsets.only(left: 5),),
            //         TextDefault(text: 'Artiste : ???${listeMorceaux.length}-$index-$isLoading', pMargin: const EdgeInsets.only(left: 60),),
            //       ]
            //     ),
            //     if (isLoading == true && index == listeMorceaux.length-1)
            //     const SizedBox(
            //       height: 50, 
            //       child: Center(
            //         child: CircularProgressIndicator(),
            //       )
            //     )
            //   ],
            // ) 
            // //
            
            // decoration: const BoxDecoration(
            //   gradient: LinearGradient(
            //       begin: Alignment.topCenter,
            //       end: Alignment.bottomCenter,
            //       stops: [0, 0.1, 0.9, 1],
            //       colors: <Color>[
            //         Color.fromRGBO(10, 10, 10, 1),
            //         // Color.fromRGBO(40, 40, 40, 1),
            //         Color.fromRGBO(80, 80, 80, 1),
            //         Color.fromRGBO(80, 80, 80, 1),
            //         // Color.fromRGBO(40, 40, 40, 1),
            //         Color.fromRGBO(10, 10, 10, 1),
            //       ]
            //     )
            // ),

          ),

          /* L'action d'appuyer sur une ligne */
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MusicPlayerPage(titreMusique: listeMorceaux[index], album: 'album_name', artiste: 'artiste_name',)
              )
            );
          },
        );
      },
    );
  }




  // Load music files from the device
  Future<void> _loadMusicFiles() async {

    setState(() {
      isLoading = true;
    });

    // Request permission first
    await _requestPermission();
    
    
    if (permissionsStorage == true){

      // Directory musicDirectory = Directory('/storage/emulated/0/Music'); // Adjust the path
      Directory musicDirectory = Directory('C:/Users/hippolyte/Documents/Ynov M2/Cours Flutter (app mobile)/music_app/assets/songs'); // Adjust the path

      if (musicDirectory.existsSync()) {
        final files = musicDirectory.listSync(recursive: true);

        listeMorceaux = <String>[]; // Supprime toute la liste pour ne pas 

        for (var file in files) {
          if (file is File && file.path.endsWith(".mp3")) {
            // You can extract the song title here. For now, we just use the file name.
            setState(() {
              listeMorceaux.add(file.uri.pathSegments.last);
            });
          }
        }
        
      }

    }
    
    setState(() {
      isLoading = false;
    });
  }

  // Request storage permission
  Future<void> _requestPermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted){
      permissionsStorage = true;
    }
    else {
      permissionsStorage = false;
    }
  }
}