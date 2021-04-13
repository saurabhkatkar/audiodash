import 'package:flutter/material.dart';

class SongName extends StatelessWidget {
  const SongName({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "Back In Black",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
          Icon(
            Icons.favorite,
            size: 40,
          ),
        ],
      ),
    );
  }
}
