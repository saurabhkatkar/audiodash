import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:m_player/model/PlayerModel.dart';
import 'package:m_player/model/SliderModel.dart';
import 'package:m_player/repository/player/PlayerRepo.dart';

part 'mplayer_event.dart';
part 'mplayer_state.dart';

class MplayerBloc extends Bloc<MplayerEvent, MplayerState> {
  final PlayerRepo playerRepo;

  MplayerBloc({@required this.playerRepo}) : super(MplayerInitial());

  @override
  Stream<MplayerState> mapEventToState(
    MplayerEvent event,
  ) async* {
    if (event is GetTimeInSec) {
      SliderModel slider = _fetchTimeFromSecs(event.sliderValue);
      yield MplayerTime(slider);
    } else if (event is GetSongStatus) {
      if (event.playerStatus == PlayerStatus.pause) {
        playerRepo.pauseMusic();
      } else {
        playerRepo.playMusic();
      }
      SliderModel slider = _fetchValueFromPos();
      yield MplayerStatus(event.playerStatus, slider);
    } else if (event is PlayerInitilized) {
      await playerRepo.initlizePlayer();
      int endTime = playerRepo.getEndTime();
      yield MplayerLoaded(endTime);
    }
  }

  @override
  Future<void> close() async {
    await playerRepo?.dispose();
    return super.close();
  }

  SliderModel _fetchValueFromPos() {
    int endTime = playerRepo.getEndTime(), posTime = playerRepo.getPosition();
    double sliderValue = posTime * 100 / endTime;
    return new SliderModel(sliderValue, endTime);
  }

  SliderModel _fetchTimeFromSecs(double sliderValue) {
    int endTime = playerRepo.getEndTime();
    SliderModel slider = new SliderModel(sliderValue, endTime);
    return slider;
  }
}
