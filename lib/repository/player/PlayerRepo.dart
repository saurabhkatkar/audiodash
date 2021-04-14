import 'package:just_audio/just_audio.dart';

class PlayerRepo {
  final player = AudioPlayer();

  Future<void> initlizePlayer() async {
    try {
      //  await player.setUrl(
      //       "https://incompetech.com/music/royalty-free/mp3-royaltyfree/Midnight%20Tale.mp3");
      await player.setUrl(
          "https://srv-store6.gofile.io/download/ykD17c/fcf37a46c5b7450079e69926a975998c/BIB.mp3");
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

  Future<void> seekMusic(int pos) async {
    await player.seek(Duration(milliseconds: pos));
  }

  Future<void> dispose() async {
    await player.stop();
    await player.dispose();
  }
}
