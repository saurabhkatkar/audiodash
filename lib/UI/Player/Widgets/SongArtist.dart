import 'package:flutter/material.dart';

class SongArtist extends StatelessWidget {
  final String artist;
  const SongArtist({
    Key key,
    this.artist = "AC/DC",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 5, 25, 15),
      child: Row(
        children: [
          Text(
            artist,
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Colors.white70, fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}
