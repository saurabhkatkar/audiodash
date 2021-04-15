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
        IconButton(icon: Icon(Icons.fast_rewind_rounded), onPressed: () {
          bloc.add(PlayerPreviousSong(status));
        }),
        IconButton(
            icon: Icon(status == PlayerStatus.pause
                ? Icons.play_arrow_rounded
                : Icons.pause),
            iconSize: 50,
            onPressed: () {
              bloc.add(GetSongStatus(status == PlayerStatus.play
                  ? PlayerStatus.pause
                  : PlayerStatus.play));
              bloc.add(PlayerStarted());
            }),
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
