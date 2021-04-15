import 'package:m_player/repository/song/SongDetails.dart';

class DummyData {
  final List<SongDetails> songs = [];
  static int index = 0;

  List<String> urls = [
    "https://firebasestorage.googleapis.com/v0/b/musicplayer-be37b.appspot.com/o/songs%2FBack%20in%20Black.mp3?alt=media&token=6bb8cc8d-ba5c-452d-a664-9f8f4753a9df",
    "https://firebasestorage.googleapis.com/v0/b/musicplayer-be37b.appspot.com/o/songs%2FCounting%20Stars%20(Alex%20Goot).mp3?alt=media&token=86078c04-e87c-4ab0-9cc0-ba97eecaafaa"
  ];

  List<String> covers = [
    "https://firebasestorage.googleapis.com/v0/b/musicplayer-be37b.appspot.com/o/covers%2Falbum4.jpg?alt=media&token=feb4c444-aa86-4d2f-bab0-744a9c0d42b7",
    "https://firebasestorage.googleapis.com/v0/b/musicplayer-be37b.appspot.com/o/covers%2Fcounting%20stars.jpg?alt=media&token=54240b1b-3b8e-4ae1-8770-d4d5940aa15f"
  ];

  List<String> names = ["Back In Back", "Counting Stars"];
  List<String> artists = ["AC/DC", "OneRepublic - Alex Goot"];

  SongDetails initData() {
    for (int i = 0; i < 2; i++) {
      SongDetails song =
          new SongDetails(urls[i], names[i], artists[i], covers[i]);
      songs.add(song);
    }
    index = 0;
    return songs[0];
  }

  SongDetails nextSong() {
    index = (index + 1) % 2;
    return songs[index];
  }
}
