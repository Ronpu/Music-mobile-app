import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:music_app/src/widgets/song.dart';
import 'package:music_app/src/widgets/style.dart';
import 'package:music_app/src/widgets/text.dart';
import 'package:music_app/src/widgets/title.dart';

import 'package:path_provider/path_provider.dart';

class MusicPlayerPage extends StatefulWidget {
  
  final Song song;

  const MusicPlayerPage({
    Key? key,
    required this.song
  }) : super(key: key);

  // const MusicPlayerPage({super.key,
  // this.titreMusique="Musique inconnue", this.artiste="Inconnu", this.album="Aucun"});


  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _setupAudioPlayer();
  }

  void _setupAudioPlayer() {
    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
    });

    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() => _position = p);
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() => _isPlaying = false);
    });
  }

  Future<void> _playMusic() async {
    await _audioPlayer.play(DeviceFileSource(widget.song.directory));
    setState(() => _isPlaying = true);
  }

  Future<void> _pauseMusic() async {
    await _audioPlayer.pause();
    setState(() => _isPlaying = false);
  }

  Future<void> _stopMusic() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
      _position = Duration.zero;
    });
  }

  Future<void> _seekTo(Duration newPosition) async {
    await _audioPlayer.seek(newPosition);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: StyleDarkMode.backgroundColor,
      // appBar: AppBar(title: Text(widget.song.title)),
      appBar: AppBar(
        title: UiTitle(title: widget.song.title),
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

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.song.album, style: TextStyle(fontSize: 18, color: StyleDarkMode.textColor)),
          Text('de ${widget.song.artiste}', style: TextStyle(fontSize: 16, color: StyleDarkMode.textGreyColor)),

          // Progress Bar
          Slider(
            thumbColor: StyleDarkMode.mainColor,
            activeColor: StyleDarkMode.mainColor,
            min: 0,
            max: _duration.inSeconds.toDouble(),
            value: _position.inSeconds.toDouble(),
            onChanged: (value) {
              _seekTo(Duration(seconds: value.toInt()));
            },
          ),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: _stopMusic,
              ),
              IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: _isPlaying ? _pauseMusic : _playMusic,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
