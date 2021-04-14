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
  final Stream<Duration> positionStream;

  MplayerStatus(this.status, this.slider, {this.positionStream});

  @override
  List<Object> get props => [status, slider, positionStream];
}

class MplayerLoaded extends MplayerState {
  final int endTime;

  MplayerLoaded(this.endTime);

  @override
  List<int> get props => [endTime];
}

class MplayerStarted extends MplayerState {
  final SliderModel slider;
  final Stream<Duration> positionStream;

  MplayerStarted(this.slider, {this.positionStream});

  @override
  List<Object> get props => [slider, positionStream];
}
