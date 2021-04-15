part of 'mplayer_bloc.dart';

abstract class MplayerEvent extends Equatable {
  const MplayerEvent();

  @override
  List<Object> get props => [];
}

class GetTimeInSec extends MplayerEvent {
  final double sliderValue;

  const GetTimeInSec(this.sliderValue);

  @override
  List<double> get props => [sliderValue];
}

class GetSongStatus extends MplayerEvent {
  final PlayerStatus playerStatus;

  const GetSongStatus(this.playerStatus);

  @override
  List<PlayerStatus> get props => [playerStatus];
}

class PlayerInitilized extends MplayerEvent {}

class PlayerStarted extends MplayerEvent {}

class PlayerStoped extends MplayerEvent {}

class PlayerNextSong extends MplayerEvent {}

class PlayerSeekMusic extends MplayerEvent {
  final Duration seekPos;

  PlayerSeekMusic(this.seekPos);

  @override
  List<Object> get props => [seekPos];
}
