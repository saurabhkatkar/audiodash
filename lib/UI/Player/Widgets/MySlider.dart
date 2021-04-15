import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_player/bloc/mplayer_bloc.dart';
import 'package:m_player/model/PlayerModel.dart';
import 'package:m_player/model/SliderModel.dart';

Widget buildColumnWithData(BuildContext context, SliderModel slider) {
  final bloc = BlocProvider.of<MplayerBloc>(context);

  return StreamBuilder<Duration>(
      stream: bloc.playerRepo.getPositionStream(),
      builder: (context, snapshot) {
        double val = slider.value;
        if (snapshot.hasData) {
          // print("Slider val is : ${slider.value}");
          Duration dur = snapshot.data;
          val = min(dur.inMilliseconds.toDouble(), slider.endTime.toDouble());

          // print("Slider val is : $val");
          if (val != 0 && val == slider.endTime.toDouble())
            bloc.add(PlayerNextSong(PlayerStatus.play));
          //To change Position Value in Label
          bloc.add(GetTimeInSec(val));
        }

        return SeekBar(
          pos: val,
          endTime: slider.endTime,
          onChangeEnd: (newPosition) {
            bloc.add(PlayerSeekMusic(newPosition));
          },
          onChanged: (pos) {
            bloc.add(GetTimeInSec(pos));
          },
        );
      });
}

class SeekBar extends StatefulWidget {
  final double pos;
  final int endTime;
  final ValueChanged<Duration> onChangeEnd;
  final ValueChanged<double> onChanged;

  const SeekBar(
      {Key key, this.pos, this.endTime, this.onChangeEnd, this.onChanged})
      : super(key: key);

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double _dragValue;

  @override
  Widget build(BuildContext context) {
    Duration end = Duration(milliseconds: widget.endTime);
    Duration pos =
        Duration(milliseconds: _dragValue?.toInt() ?? widget.pos.toInt());
    return Column(
      children: [
        Slider(
          value: _dragValue ?? widget.pos,
          min: 0,
          max: widget.endTime.toDouble(),
          onChanged: (double value) {
            widget.onChanged(value);

            setState(() {
              _dragValue = value;
            });
          },
          onChangeEnd: (double value) {
            _dragValue = null;
            widget.onChangeEnd(Duration(milliseconds: value.round()));
          },
          activeColor: Theme.of(context).accentColor,
        ),
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
}
