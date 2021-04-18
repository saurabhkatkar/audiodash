import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_player/bloc/mplayer_bloc.dart';
import 'package:m_player/model/PlayerModel.dart';
import 'package:m_player/model/SliderModel.dart';
import 'package:m_player/repository/dummy/DummyData.dart';
import 'package:m_player/repository/player/PlayerRepo.dart';
import 'Widgets/CoverImage.dart';
import 'Widgets/MyControls.dart';
import 'Widgets/MySlider.dart';
import 'Widgets/MyTitleBar.dart';
import 'Widgets/SongArtist.dart';
import 'Widgets/SongName.dart';

class PlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              // Add one stop for each color
              // Values should increase from 0.0 to 1.0
              stops: [0.1, 0.3, 0.7, 0.8, 1.0],
              colors: [
                const Color(0xFF18171B),
                const Color(0xFF181D22),
                const Color(0xFF272B30),
                const Color(0xFF35393F),
                const Color(0xFF353638),
              ],
            ),
          ),
          child: BlocProvider(
              create: (BuildContext context) =>
                  MplayerBloc(playerRepo: PlayerRepo(), dummyData: DummyData())
                    ..add(PlayerInitilized()),
              child: playerLayout()),
        ),
      ),
    );
  }

  Column playerLayout() {
    return Column(
      children: [
        MyTitleBar(),
        BlocBuilder<MplayerBloc, MplayerState>(
            buildWhen: (previousState, state) {
          if (state is MplayerLoaded) {
            return true;
          }
          return false;
        }, builder: (context, state) {
          if (state is MplayerLoaded) {
            return Column(
              children: [
                CoverImage(coverUrl: state.song.metas.image.path),
                SongName(
                  name: state.song.metas.title,
                ),
                SongArtist(
                  artist: state.song.metas.artist,
                ),
              ],
            );
          }
          return Column(
            children: [
              CoverImage(),
              SongName(),
              SongArtist(),
            ],
          );
        }),

        //Build Slider with Bloc
        BlocBuilder<MplayerBloc, MplayerState>(builder: (context, state) {
          if (state is MplayerLoaded) {
            return buildColumnWithData(
                context, new SliderModel(0, state.endTime));
          } else if (state is MplayerTime) {
            return buildColumnWithData(context, state.slider);
          } else if (state is MplayerStatus) {
            return buildColumnWithData(context, state.slider);
          } else if (state is MplayerStarted) {
            return buildColumnWithData(
              context,
              state.slider,
            );
          }
          return buildColumnWithData(context, new SliderModel(0, 0));
        }),
        //Build Player Controls with Bloc
        BlocBuilder<MplayerBloc, MplayerState>(
            buildWhen: (previousState, state) {
          if (state is MplayerStatus || state is MplayerLoaded) {
            return true;
          }
          return false;
        }, builder: (context, state) {
          if (state is MplayerStatus) {
            return buildControlsWithData(context, state.status);
          } else if (state is MplayerLoaded) {
            return buildControlsWithData(
                context, state.playerStatus ?? PlayerStatus.pause);
          }
          return buildControlsWithData(context, PlayerStatus.pause);
        })
      ],
    );
  }
}
