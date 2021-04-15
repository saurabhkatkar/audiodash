import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_player/bloc/mplayer_bloc.dart';
import 'package:m_player/model/PlayerModel.dart';
import 'package:m_player/model/SliderModel.dart';
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
        body: BlocProvider(
            create: (BuildContext context) =>
                MplayerBloc(playerRepo: PlayerRepo())..add(PlayerInitilized()),
            child: playerLayout()),
      ),
    );
  }

  Column playerLayout() {
    return Column(
      children: [
        MyTitleBar(),
        CoverImage(),
        SongName(),
        SongArtist(),
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
          if (state is MplayerStatus) {
            return true;
          }
          return false;
        }, builder: (context, state) {
          if (state is MplayerStatus) {
            return buildControlsWithData(context, state.status);
          }
          return buildControlsWithData(context, PlayerStatus.pause);
        })
      ],
    );
  }
}
