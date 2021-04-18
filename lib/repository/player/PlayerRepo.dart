import 'package:assets_audio_player/assets_audio_player.dart';

class PlayerRepo {
  // final player = AudioPlayer();
  final _player = AssetsAudioPlayer();

  Future<void> initlizePlayer(Playlist playlist, Function changeNextTrack,
      Function changePreTrack, Function changePlayerStatus) async {
    try {
      await _player?.stop();
      await _player.open(playlist,
          autoStart: false,
          showNotification: true,
          loopMode: LoopMode.playlist,
          notificationSettings: NotificationSettings(
            stopEnabled: false,
            customPlayPauseAction: (player) async {
              bool res = await this.isPlaying();
              changePlayerStatus(res);
            },
            customNextAction: (player) {
              changeNextTrack();
            },
            customPrevAction: (player) {
              changePreTrack();
            },
          ));
    } catch (e) {
      print("Error with Song Load");
    }
  }

  Future<PlayingAudio> getSongDetails() async {
    final playingAudio = await _player.current.first;
    return playingAudio.audio;
  }

  Future<int> getEndTime() async {
    final playingAudio = await _player.current.first;
    if (playingAudio?.audio?.duration == null) return 0;
    Duration dur = playingAudio.audio.duration;
    int mins = dur.inMilliseconds;
    return mins;
  }

  Future<int> getPosition() async {
    Duration dur = await _player.currentPosition.first;
    int mins = dur.inMilliseconds;
    return mins;
  }

  void playMusic() {
    _player.play();
  }

  Future<void> pauseMusic() async {
    await _player.pause();
  }

  Future<bool> isPlaying() async {
    return await _player.isPlaying.first;
  }

  Stream<Duration> getPositionStream() {
    return _player.currentPosition;
  }

  Future<void> seekMusic(Duration pos) async {
    await _player.seek(pos);
  }

  Future<void> nextSong() async {
    await _player.next();
  }

  Future<void> previousSong() async {
    await _player.previous();
  }

  Future<void> dispose() async {
    await _player.stop();
    await _player.dispose();
  }
}
