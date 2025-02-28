import 'package:flutter/material.dart';
// 
import 'package:music_app/src/pages/musicPlayerPage.dart';
import 'package:music_app/src/pages/musicPlayerPage2.dart';
import 'package:music_app/src/widgets/song.dart';
// 
import 'package:music_app/src/widgets/style.dart';
import 'package:music_app/src/widgets/text.dart';

// import 'package:music_app/src/widgets/musicFind.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';


class MorceauxPage extends StatefulWidget {
  final bool permissionsStorage = false;
  final List<Song> listeMorceaux = <Song>[];

  @override
  createState() => new MorceauxPageState();
}

class MorceauxPageState extends State<MorceauxPage> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true; // Pour pas perdre la liste en changeant de page. Grâce à AutomaticKeepAliveClientMixin
  
  // const MorceauxPage({super.key}); // Ancien, quand la page était StatelessWidget
  bool permissionsStorage = false;
  List<Song> listeMorceaux = <Song>[];
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
            
            // ListView.builder(
            //   itemCount: listeMorceaux.length + (isLoading ? 1 : 0), // Add 1 for the loading indicator if still loading
            //   itemBuilder: (context, index) {
            //     if (index < listeMorceaux.length) {
            //       // Return the normal row with song information
            //       return GestureDetector(
            //         onTap: () {
            //           // Handle song selection
            //         },
            //         child: Container(
            //           // padding: EdgeInsets.all(8.0),
            //           child: Row(
            //             children: [
            //               const Icon(Icons.play_circle_fill_rounded),
            //               TextDefault( text: listeMorceaux[index], pMargin: const EdgeInsets.only(left: 5), ),
            //               TextDefault( text: 'Artiste : ???${listeMorceaux.length}-$index-$isLoading', pMargin: const EdgeInsets.only(left: 60), ),
            //             ],
            //           ),
            //         ),
            //       );
            //     } else {
            //       // Return the loading indicator at the bottom if still loading
            //       return Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 16.0),
            //         child: Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //       );
            //     }
            //   },
            // )

            // //
            Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.play_circle_fill_rounded),         /* Margin du texte de la ligne (met un espace après l'icone) */
                    TextDefault(text: listeMorceaux[index].title, pMargin: const EdgeInsets.only(left: 5),),
                    TextDefault(text: 'De : ${listeMorceaux[index].artiste}', pMargin: const EdgeInsets.only(left: 60),),
                  ]
                ),
                if (isLoading == true && index == listeMorceaux.length-1)
                const SizedBox(
                  height: 50, 
                  child: Center(
                    child: CircularProgressIndicator(),
                  )
                )
              ],
            ) 
            // //

          ),

          /* L'action d'appuyer sur une ligne */
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                // builder: (context) => MusicPlayerPage(titreMusique: listeMorceaux[index], album: 'album_name', artiste: 'artiste_name',)
                builder: (context) => MusicPlayerPage2(song: listeMorceaux[index])
              )
            );
          },
        );
      },
    );
  }




  // Fonction : demande la permission d'accès aux fichiers
  Future<void> _requestPermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted){
      permissionsStorage = true;
    }
    else {
      permissionsStorage = false;
    }
  }


  // Fonction : Retourne une liste des fichier .mp3 du dossier donné en paramètre
  Future<List<Song>> _getMusicFiles(Directory directory) async {

    // List<String> _listeMorceaux = [];
    // List<List<String>> listList = [];
    List<Song> _listeMorceaux = [];

    try {      
      if (directory.existsSync()) {
        
        // List<FileSystemEntity> 
        final files = directory.listSync(recursive: true);

        for (var file in files) {
          if (file is File && file.path.endsWith(".mp3")) {
            setState(() {
              Song song = Song(
                directory: file.path, 
                title: file.uri.pathSegments.last,
                // album: ???,
                // artiste: ???,
              );
              _listeMorceaux.add(song);
            });
          }
        }

      }
    } catch (e) {
      print("Error scanning directory: $e");
    }

    return _listeMorceaux;
  }


  // Fonction : Load les fichiers .mp3
  Future<void> _loadMusicFiles() async {

    setState(() {
      isLoading = true;
    });

    // Demande la permission
    await _requestPermission();
    
    if (permissionsStorage == true){

      // bool storageFound = false;
      listeMorceaux = [];

      if (Platform.isWindows){
      // if (storageFound == false){
        // Directory musicDirectory = Directory('/storage/emulated/0/Music'); // Adjust the path
        Directory? dir = Directory('C:/Users/hippolyte/Documents/Ynov M2/Cours Flutter (app mobile)/music_app/assets/songs'); // Adjust the path
        // Directory musicDirectory = Directory('../assets/songs'); // Adjust the path
        
        // listeMorceaux.addAll(await _getMusicFiles(dir));
        if (dir.existsSync()) {
        
          // List<FileSystemEntity> 
          final files = dir.listSync(recursive: true);

          for (var file in files) {
            if (file is File && file.path.endsWith(".mp3")) {
              setState(() {
                // _listeMorceaux.add(file.path);
                // listeMorceaux.add(file.uri.pathSegments.last);
                Song song = Song(
                  directory: file.path, 
                  title: file.uri.pathSegments.last,
                  // album: ???,
                  // artiste: ???,
                );
                listeMorceaux.add(song);
              });
            }
          }

        }
      }

      // Directory? dir = await getExternalStorageDirectory();
      // if (dir != null){
      //   // storageFound = true;
      //   listeMorceaux.addAll(await _getMusicFiles(dir));
      // }
      
      // List<Directory>? listDir = await getExternalStorageDirectories();
      // if (listDir != null) {
      //   // storageFound = true;
      //   for (var dir in listDir){
      //     listeMorceaux.addAll(await _getMusicFiles(dir));
      //   }
      // }
    }
    
    setState(() {
      isLoading = false;
    });
  }

}