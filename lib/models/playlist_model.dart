import 'video_model.dart';

class Playlist {
  List<String> videoIds;
  List<Video> videoInfo;

  Playlist({this.videoIds, this.videoInfo});

  String videos(Map<String, dynamic> snippet) {
    return snippet['videoId'];
  }
}
