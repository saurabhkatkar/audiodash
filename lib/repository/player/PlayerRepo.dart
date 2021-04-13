import 'package:just_audio/just_audio.dart';

class PlayerRepo {
  final player = AudioPlayer();

  Future<void> initlizePlayer() async {
    var duration = await player.setUrl(
        'https://cdnm.meln.top/mr/Ac%20%5C%20Dc%20-%20Back%20in%20Black.mp3?session_key=3baa1a275489ed599b562c88a73678d5&hash=d9e73eb5ece2fc64ea412ff2551d5b9a');
  }

  int getEndTime() {
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

  Stream<Duration> getPositionStream() {
    return player.positionStream;
  }

  Future<void> dispose() async {
    await player.stop();
    await player.dispose();
  }
}
