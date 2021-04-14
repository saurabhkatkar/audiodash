import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_player/bloc/mplayer_bloc.dart';
import 'package:m_player/model/PlayerModel.dart';
import 'package:m_player/model/SliderModel.dart';

Column buildColumnWithData(BuildContext context, SliderModel slider,
    {Stream<Duration> posStream}) {
  final bloc = BlocProvider.of<MplayerBloc>(context);

  Duration end = Duration(milliseconds: slider.endTime);
  Duration pos = Duration(milliseconds: slider.value.toInt());
  return Column(
    children: [
      StreamBuilder<Duration>(
          stream: posStream ?? null,
          builder: (context, snapshot) {
            double val = slider.value;
            if (snapshot.hasData && posStream != null) {
              print("Slider val is : ${slider.value}");
              Duration dur = snapshot.data;
              val =
                  min(dur.inMilliseconds.toDouble(), slider.endTime.toDouble());
              print("Value val is : ${val}");

              // print("Slider val is : $val");
              if (val == slider.endTime.toDouble())
                bloc.add(GetSongStatus(PlayerStatus.pause));
              bloc.add(PlayerStarted());
            }

            return Slider(
              value: val,
              min: 0,
              max: slider.endTime.toDouble(),
              onChanged: (double value) {
                bloc.add(GetTimeInSec(value));
              },
              onChangeEnd: (double value) {
                bloc.add(PlayerSeekMusic(value.toInt()));
              },
            );
          }),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${pos.inMinutes}:${pos.inSeconds.remainder(60)}"),
            Text("${end.inMinutes}:${end.inSeconds.remainder(60)}"),
          ],
        ),
      )
    ],
  );
}
