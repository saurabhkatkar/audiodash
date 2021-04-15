import 'package:just_audio/just_audio.dart';
import 'package:m_player/repository/song/SongDetails.dart';

class PlayerRepo {
  final player = AudioPlayer();

  Future<void> initlizePlayer(SongDetails song) async {
    try {
      await player?.stop();
      await player.setUrl(song.url);
    } catch (e) {
      print("Error with Song Load");
    }
  }

  int getEndTime() {
    if (player.duration == null) return 0;
    Duration dur = player.duration;
    int mins = dur.inMilliseconds;
    return mins;
  }

  int getPosition() {
    Duration dur = player.position;
    int mins = dur.inMilliseconds;
    return mins;
  }

  void playMusic() {
    player.play();
  }

  Future<void> pauseMusic() async {
    await player.pause();
  }

  bool isPlaying() {
    return player.playing;
  }

  Stream<Duration> getPositionStream() {
    return player.positionStream;
  }

  Future<void> seekMusic(Duration pos) async {
    await player.seek(pos);
  }

  Future<void> dispose() async {
    await player.stop();
    await player.dispose();
  }
}
