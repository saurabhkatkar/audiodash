import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_player/bloc/mplayer_bloc.dart';
import 'package:m_player/model/PlayerModel.dart';

Widget buildControlsWithData(BuildContext context, PlayerStatus status) {
  final bloc = BlocProvider.of<MplayerBloc>(context);

  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(icon: Icon(Icons.shuffle_rounded), onPressed: () {}),
        IconButton(
            icon: Icon(Icons.fast_rewind_rounded),
            onPressed: () {
              bloc.add(PlayerPreviousSong(status));
            }),
        RadiantGradientMask(
          child: IconButton(
              icon: Icon(status == PlayerStatus.pause
                  ? Icons.play_circle_fill_rounded
                  : Icons.pause_circle_filled_rounded),
              iconSize: 80,
              onPressed: () {
                bloc.add(GetSongStatus(status == PlayerStatus.play
                    ? PlayerStatus.pause
                    : PlayerStatus.play));
                bloc.add(PlayerStarted());
              }),
        ),
        IconButton(
            icon: Icon(Icons.fast_forward_rounded),
            onPressed: () {
              bloc.add(PlayerNextSong(status));
            }),
        IconButton(icon: Icon(Icons.autorenew_rounded), onPressed: () {}),
      ],
    ),
  );
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.bottomCenter,
        stops: [
          0.5,
          1,
        ],
        colors: [
          Colors.white,
          Theme.of(context).accentColor,
        ],
      ).createShader(bounds),
      child: child,
    );
  }
}
