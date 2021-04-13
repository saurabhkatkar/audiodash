import 'package:flutter/material.dart';

class SongArtist extends StatelessWidget {
  const SongArtist({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Text(
            "AC/DC",
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
