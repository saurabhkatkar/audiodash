import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_player/bloc/mplayer_bloc.dart';
import 'package:m_player/model/PlayerModel.dart';
import 'package:m_player/model/SliderModel.dart';

Column buildColumnWithData(BuildContext context, SliderModel slider,
    {Stream<Duration> posStream}) {
  Duration end = Duration(milliseconds: slider.endTime);
  Duration pos =
      Duration(milliseconds: ((slider.value / 100) * slider.endTime).toInt());
  return Column(
    children: [
      StreamBuilder<Duration>(
          stream: posStream ?? null,
          builder: (context, snapshot) {
            final bloc = BlocProvider.of<MplayerBloc>(context);
            double val = slider.value;
            if (snapshot.hasData) {
              Duration dur = snapshot.data;
              val = (dur.inMilliseconds * 100) / end.inMilliseconds;
              // print("Slider val is : $val");
              if (val >= 100.0) bloc.add(GetSongStatus(PlayerStatus.pause));
              bloc.add(PlayerStarted());
            }
            return Slider(
              value: val,
              min: 0,
              max: 100,
              onChanged: (double value) {
                bloc.add(GetTimeInSec(value));
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
