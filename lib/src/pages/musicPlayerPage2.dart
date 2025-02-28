import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:music_app/src/widgets/song.dart';


class MusicPlayerPage2 extends StatefulWidget {
  
  // final String titreMusique;
  // final String album;
  // final String artiste;
  final Song song;

  const MusicPlayerPage2({
    Key? key,
    // this.titreMusique="Musique inconnue",
    // this.album="Inconnu",
    // this.artiste="Aucun",
    required this.song
  }) : super(key: key);

  // const MusicPlayerPage2({super.key,
  // this.titreMusique="Musique inconnue", this.artiste="Inconnu", this.album="Aucun"});


  @override
  _MusicPlayerPage2State createState() => _MusicPlayerPage2State();
}

class _MusicPlayerPage2State extends State<MusicPlayerPage2> {
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
      appBar: AppBar(title: Text(widget.song.title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.song.directory, style: TextStyle(fontSize: 18)),
          Text(widget.song.artiste, style: TextStyle(fontSize: 18)),
          Text(widget.song.album, style: TextStyle(fontSize: 16, color: Colors.grey)),

          // Progress Bar
          Slider(
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
