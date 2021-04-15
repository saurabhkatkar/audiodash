import 'package:flutter/material.dart';

class CoverImage extends StatelessWidget {
  final String coverUrl;

  const CoverImage({
    Key key,
    this.coverUrl =
        'https://i.pinimg.com/originals/49/11/c3/4911c3e7f55f9e539f663db3ac7e049e.jpg',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      height: MediaQuery.of(context).size.height * 0.5,
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Image.network(coverUrl, fit: BoxFit.fill,)),
    );
  }
}
