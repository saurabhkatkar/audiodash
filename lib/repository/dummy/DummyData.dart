import 'package:assets_audio_player/assets_audio_player.dart';

import '../constants.dart';

class DummyData {
  final List<Audio> songs = [];
  static int index = 0;

  Playlist initData() {
    for (int i = 0; i < urls.length; i++) {
      Audio song = Audio.network(urls[i],
          metas: Metas(
              title: titles[i],
              artist: artists[i],
              image: MetasImage.network(covers[i]),
              album: "Album"));
      songs.add(song);
    }

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
