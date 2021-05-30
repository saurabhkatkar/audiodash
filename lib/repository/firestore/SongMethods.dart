import 'package:cloud_firestore/cloud_firestore.dart';

class SongMethods {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<List<Map<String, String>>> getSongDetails() async {
    List<Map<String, String>> songDetails = [];

    QuerySnapshot songsSnap = await _firestore.collection('songs').get();
    if (songsSnap.size > 0) {
      songsSnap.docs.forEach((songData) {
        print(songData["name"]);
        if (songData["url"] != "" &&
            songData["name"] != "" &&
            songData["artist"] != "" &&
            songData["cover"] != "") {
          songDetails.add({
            "url": songData["url"],
            "title": songData["name"],
            "artist": songData["artist"],
            "cover": songData["cover"],
          });
        }
      });
    }

    return songDetails;
  }
}
