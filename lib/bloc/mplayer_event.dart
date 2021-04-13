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
