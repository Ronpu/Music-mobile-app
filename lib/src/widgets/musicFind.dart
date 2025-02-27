// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// // import 'package:just_audio/just_audio.dart';
// import 'dart:io';

// import 'package:music_app/src/pages/musicPlayerPage.dart';
// import 'package:music_app/src/widgets/style.dart';
// import 'package:music_app/src/widgets/text.dart';

// class Musicfind extends StatefulWidget {
//   @override
//   _MusicfindState createState() => _MusicfindState();
// }

// class _MusicfindState extends State<Musicfind> {
//   List<String> songTitles = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadMusicFiles();
//   }

//   // Request storage permission
//   Future<void> _requestPermission() async {
//     final status = await Permission.storage.request();
//     if (status.isGranted) {
//       _loadMusicFiles();
//     } else {
//       // Handle permission denial
//       print("Permission Denied!");
//     }
//   }

//   // Load music files from the device
//   Future<void> _loadMusicFiles() async {
//     // Request permission first
//     await _requestPermission();

//     // Assuming you want to search in external storage, adjust based on your needs
//     // Directory musicDirectory = Directory('/storage/emulated/0/Music'); // Adjust the path
//     Directory musicDirectory = Directory('C:/Users/hippolyte/Documents/Ynov M2/Cours Flutter (app mobile)/music_app/assets/songs'); // Adjust the path

//     if (musicDirectory.existsSync()) {
//       final files = musicDirectory.listSync(recursive: true);
//       List<String> titles = [];

//       for (var file in files) {
//         if (file is File && file.path.endsWith(".mp3")) {
//           // You can extract the song title here. For now, we just use the file name.
//           titles.add(file.uri.pathSegments.last);
//         }
//       }

//       setState(() {
//         songTitles = titles;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Music Player"),
//       ),
//       body: ListView.builder(
//         itemCount: songTitles.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(songTitles[index]),
//             onTap: () {
//               // Handle song selection, for example, play the song
//             },
//           );
//         },
//       ),
//     );
//   }
// }
