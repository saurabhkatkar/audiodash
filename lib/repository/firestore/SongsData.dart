import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:m_player/repository/firestore/SongMethods.dart';

import '../constants.dart';

class SongsData {
  final List<Audio> songs = [];
  static int index = 0;

  Future<Playlist> initData() async {
    List<Map<String, String>> songsRef = await SongMethods.getSongDetails();
    songsRef.forEach((songData) {
      Audio song = Audio.network(songData["url"],
          metas: Metas(
              title: songData["title"],
              artist: songData["artist"],
              image: MetasImage.network(songData["cover"]),
              album: songData["title"]));
      songs.add(song);
    });

    final pl = Playlist(audios: songs);

    return pl;
  }

  Audio nextSong() {
    index = (index + 1) % urls.length;
    return songs[index];
  }

  Audio previousSong() {
    index = (index - 1) % urls.length;
    return songs[index];
  }
}
