class Song {

  String directory;
  String title;
  String album;
  String artiste;

  Song({
    required this.directory, //="",
    required this.title, //="Musique inconnue",
    this.album="Inconnu",
    this.artiste="Inconnu",
  });
}
