import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_player/bloc/mplayer_bloc.dart';
import 'package:m_player/model/SliderModel.dart';

Column buildColumnWithData(BuildContext context, SliderModel slider) {
  Duration end = Duration(milliseconds: slider.endTime);
  Duration pos =
      Duration(milliseconds: ((slider.value / 100) * slider.endTime).toInt());
  return Column(
    children: [
      StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return Slider(
              value: slider.value,
              min: 0,
              max: 100,
              onChanged: (double value) {
                final bloc = BlocProvider.of<MplayerBloc>(context);
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
