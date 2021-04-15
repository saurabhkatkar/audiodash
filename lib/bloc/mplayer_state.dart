part of 'mplayer_bloc.dart';

abstract class MplayerState extends Equatable {
  const MplayerState();

  @override
  List<Object> get props => [];
}

class MplayerInitial extends MplayerState {}

class MplayerTime extends MplayerState {
  final SliderModel slider;

  MplayerTime(this.slider);

  @override
  List<SliderModel> get props => [slider];
}

class MplayerStatus extends MplayerState {
  final PlayerStatus status;
  final SliderModel slider;

  MplayerStatus(this.status, this.slider);

  @override
  List<Object> get props => [status, slider];
}

class MplayerLoaded extends MplayerState {
  final int endTime;
  final SongDetails song;

  MplayerLoaded(this.endTime, this.song);

  @override
  List<Object> get props => [endTime, song];
}

class MplayerStarted extends MplayerState {
  final SliderModel slider;

  MplayerStarted(this.slider);

  @override
  List<Object> get props => [slider];
}

class MplayerNextSong extends MplayerState {
  final SongDetails song;

  MplayerNextSong(this.song);

  @override
  List<Object> get props => [song];
}
