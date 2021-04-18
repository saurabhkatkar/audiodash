import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:m_player/model/PlayerModel.dart';
import 'package:m_player/model/SliderModel.dart';
import 'package:m_player/repository/dummy/DummyData.dart';
import 'package:m_player/repository/player/PlayerRepo.dart';

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
      SliderModel slider = await _fetchEnd(event.sliderValue);
      yield MplayerTime(slider);
    } else if (event is GetSongStatus) {
      SliderModel slider = await _fetchPosAndEnd();
      if (event.playerStatus == PlayerStatus.pause) {
        playerRepo.pauseMusic();
        yield MplayerStatus(event.playerStatus, slider);
      } else {
        playerRepo.playMusic();
        yield MplayerStatus(event.playerStatus, slider);
      }
    } else if (event is PlayerInitilized) {
      Playlist playlist = dummyData.initData();
      await playerRepo.initlizePlayer(
          playlist, changeNextTrack, changePreTrack, changePlayerStatus);
      int endTime = await playerRepo.getEndTime();
      yield MplayerLoaded(endTime, playlist.audios[0]);
    } else if (event is PlayerStarted) {
      SliderModel slider = await _fetchPosAndEnd();
      yield MplayerStarted(slider);
    } else if (event is PlayerSeekMusic) {
      playerRepo.seekMusic(event.seekPos);
    } else if (event is PlayerNextSong) {
      await playerRepo.nextSong();
      PlayingAudio song = await playerRepo.getSongDetails();

      yield MplayerLoaded(song.duration.inMilliseconds, song.audio,
          playerStatus: PlayerStatus.play);
    } else if (event is PlayerPreviousSong) {
      await playerRepo.previousSong();
      PlayingAudio song = await playerRepo.getSongDetails();

      yield MplayerLoaded(song.duration.inMilliseconds, song.audio,
          playerStatus: PlayerStatus.play);
    }
  }

  @override
  Future<void> close() async {
    await playerRepo?.dispose();
    return super.close();
  }

  void changePlayerStatus(bool status) {
    this.add(GetSongStatus(status ? PlayerStatus.pause : PlayerStatus.play));
  }

  void changePreTrack() async {
    this.add(PlayerPreviousSong());
  }

  void changeNextTrack() async {
    this.add(PlayerNextSong());
  }

  Future<SliderModel> _fetchPosAndEnd() async {
    int endTime = await playerRepo.getEndTime(),
        posTime = await playerRepo.getPosition();
    return new SliderModel(posTime.toDouble(), endTime);
  }

  Future<SliderModel> _fetchEnd(double sliderValue) async {
    int endTime = await playerRepo.getEndTime();
    return new SliderModel(sliderValue, endTime);
  }
}
