import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:tricktok/API-services/youtube-data-api.dart';
import 'package:tricktok/models/video_model.dart';
import 'package:tricktok/models/playlist_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  PreloadPageController pageController = PreloadPageController();
  YoutubePlayerController _youController;
  int currentPageValue = 0;
  int position;
  Playlist _playlist;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initPlaylist();
  }

  void _initPlaylist() async {
    Playlist playlist = await YoutubeDataAPI.instance
        .fromPlaylist(playlistId: 'PLIbLfYSA8ACNYCOaDWmj6EA1F1uS-pyVL');
    setState(() {
      _playlist = playlist;
    });
  }

  Widget _playerSetup(int index) {
    print(index);
    if (index == 0)
      _youController = YoutubePlayerController(
          initialVideoId: _playlist.videoIds[index],
          flags: YoutubePlayerFlags(
            mute: false,
            autoPlay: true,
            hideControls: false,
          ));
    else {
      _youController = YoutubePlayerController(
          initialVideoId: _playlist.videoIds[index],
          flags: YoutubePlayerFlags(
            mute: false,
            autoPlay: false,
            hideControls: false,
          ));
    }

    return YoutubePlayer(
      aspectRatio: 9 / 20,
      controller: _youController,
      showVideoProgressIndicator: false,
    );
  }

  createController(index) {}

  deactivate() {
    _youController.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _playlist == null
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor, // Red
                  ),
                ),
              )
            : SafeArea(
                child: PreloadPageView.builder(
                  physics: BouncingScrollPhysics(),
                  preloadPagesCount: 1,
                  pageSnapping: true,
                  scrollDirection: Axis.vertical,
                  onPageChanged: (index) {
                    _youController.play();
                  },
                  controller: pageController,
                  itemBuilder: (context, position) {
                    this.position = position;
                    return Stack(
                      children: <Widget>[
                        Container(
                          color: Colors.black,
                          child: Center(
                            child: _playerSetup(position),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ));
  }
}
