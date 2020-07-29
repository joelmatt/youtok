import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tricktok/models/video_model.dart';
import 'package:tricktok/models/playlist_model.dart';
import 'package:tricktok/utilities/credentials.dart';

class YoutubeDataAPI {
  // a singleton so that the the the same instance runs through out the lifetime
  // of the application
  YoutubeDataAPI._instantiate();
  static final YoutubeDataAPI instance = YoutubeDataAPI._instantiate();

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';

  Future<Playlist> fromPlaylist({String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'contentDetails',
      'playlistId': playlistId,
      'pageToken': _nextPageToken,
      'maxResults': '10',
      'key': YOUTUBE_API_KEY,
    };

    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: '/application/json'
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data['items'].length);
      _nextPageToken = data['nextPageToken'] ?? '';
      Playlist playlist = Playlist();
      List<String> videoList = [];
      List<dynamic> temp = data['items'];
      temp.forEach(
          (json) => videoList.add(playlist.videos(json["contentDetails"])));
      playlist.videoIds = videoList;
      playlist.videoInfo = await videoInfos(videoList: videoList);
      return playlist;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Video>> videoInfos({List<String> videoList}) async {
    List<Video> videoInfo = [];
    Map<String, String> parameters = {
      'part': 'statistics, snippet',
      'id': videoList.join(','),
      'key': YOUTUBE_API_KEY,
    };

    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/videos',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: '/application/json'
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data['items'].length);
      List<dynamic> videosJson = data['items'];
      videosJson.forEach((json) {
        videoInfo.add(Video.fromMap(json));
      });
      return videoInfo;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
