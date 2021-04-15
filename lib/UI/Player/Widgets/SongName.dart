import 'package:flutter/material.dart';

class SongName extends StatelessWidget {
  final String name;
  const SongName({
    Key key,
    this.name = "Back In Black",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
          RadiantGradientMask(
            child: Icon(
              Icons.favorite,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.bottomCenter,
        radius: 0.8,
        colors: [
          Colors.white,
          Theme.of(context).accentColor,
        ],
      ).createShader(bounds),
      child: child,
    );
  }
}
