import 'package:flutter/material.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Image.asset('assets/cover/album4.jpg')),
    );
  }
}
