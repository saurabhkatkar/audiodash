import 'package:flutter/material.dart';

class MyTitleBar extends StatelessWidget {
  const MyTitleBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){}),
          Container(
            child: Text(
              "Playing Now",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          IconButton(icon: Icon(Icons.playlist_add), onPressed: () {}),
        ],
      ),
    );
  }
}
