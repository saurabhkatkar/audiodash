import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:m_player/model/PlayerModel.dart';
import 'package:m_player/model/SliderModel.dart';
import 'package:m_player/repository/dummy/DummyData.dart';
import 'package:m_player/repository/player/PlayerRepo.dart';
import 'package:m_player/repository/song/SongDetails.dart';

part 'mplayer_event.dart';
part 'mplayer_state.dart';

class MplayerBloc extends Bloc<MplayerEvent, MplayerState> {
  final PlayerRepo playerRepo;
  final DummyData dummyData;

  MplayerBloc({this.playerRepo, this.dummyData}) : super(MplayerInitial());

  @override
  Stream<MplayerState> mapEventToState(
    MplayerEvent event,
  ) async* {
    if (event is GetTimeInSec) {
      SliderModel slider = _fetchEnd(event.sliderValue);
      yield MplayerTime(slider);
    } else if (event is GetSongStatus) {
      SliderModel slider = _fetchPosAndEnd();
      if (event.playerStatus == PlayerStatus.pause) {
        playerRepo.pauseMusic();
        yield MplayerStatus(event.playerStatus, slider);
      } else {
        playerRepo.playMusic();
        yield MplayerStatus(event.playerStatus, slider);
      }
    } else if (event is PlayerInitilized) {
      SongDetails song = dummyData.initData();
      await playerRepo.initlizePlayer(song);
      int endTime = playerRepo.getEndTime();
      yield MplayerLoaded(endTime, song);
    } else if (event is PlayerStarted) {
      SliderModel slider = _fetchPosAndEnd();
      yield MplayerStarted(slider);
    } else if (event is PlayerSeekMusic) {
      playerRepo.seekMusic(event.seekPos);
    } else if (event is PlayerNextSong) {
      SongDetails song = dummyData.nextSong();
      await playerRepo.initlizePlayer(song);
      int endTime = playerRepo.getEndTime();
      if(event.playerStatus == PlayerStatus.play) {
        playerRepo.playMusic();
      }
      yield MplayerLoaded(endTime, song,playerStatus: event.playerStatus);
    }else if (event is PlayerPreviousSong) {
      SongDetails song = dummyData.previousSong();
      await playerRepo.initlizePlayer(song);
      int endTime = playerRepo.getEndTime();
      if(event.playerStatus == PlayerStatus.play) {
        playerRepo.playMusic();
      }
      yield MplayerLoaded(endTime, song,playerStatus: event.playerStatus);
    }

  }

  @override
  Future<void> close() async {
    await playerRepo?.dispose();
    return super.close();
  }

  SliderModel _fetchPosAndEnd() {
    int endTime = playerRepo.getEndTime(), posTime = playerRepo.getPosition();
    return new SliderModel(posTime.toDouble(), endTime);
  }

  SliderModel _fetchEnd(double sliderValue) {
    int endTime = playerRepo.getEndTime();
    return new SliderModel(sliderValue, endTime);
  }
}
