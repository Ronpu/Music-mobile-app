import 'package:flutter/material.dart';
// 
import 'package:music_app/src/pages/musicPlayerPage.dart';
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

          ),

          /* L'action d'appuyer sur une ligne */
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MusicPlayerPage(song: listeMorceaux[index])
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
                title: file.uri.pathSegments.last.substring(0, file.uri.pathSegments.last.length - 4),
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

      // Refresh la liste
      listeMorceaux = [];

      // // WINDOWS : RECUP LES MUSIQUES TESTS 
      if (Platform.isWindows){
        Directory dir = Directory('${Directory.current.path}/assets/songs/');        
        listeMorceaux.addAll(await _getMusicFiles(dir));
      }
      // //

      // // PHONE (?android?): CHERCHE DANS LE STORAGE, JSP SI CA MARCHE (bug sur pc) :
      else { // else if (Platform.isAndroid) {
        Directory? dir = await getExternalStorageDirectory();
        if (dir != null){
          listeMorceaux.addAll(await _getMusicFiles(dir));
        }
      
        List<Directory>? listDir = await getExternalStorageDirectories();
        if (listDir != null) {
          for (var dir in listDir){
            listeMorceaux.addAll(await _getMusicFiles(dir));
          }
        }
      }

    }
    
    setState(() {
      isLoading = false;
    });
  }

}