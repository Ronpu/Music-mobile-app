class Song {

  String directory;
  String title;
  String album;
  String artiste;

  Song({
    required this.directory,
    required this.title,
    this.album="Album inconnu",
    this.artiste="Artiste inconnu",
  });
}
