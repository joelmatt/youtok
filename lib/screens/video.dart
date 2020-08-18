import 'package:flutter/material.dart';
import 'package:tricktok/API-services/youtube-data-api.dart';
import 'package:tricktok/models/video_model.dart';
import 'package:tricktok/models/playlist_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video extends StatefulWidget {
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  PageController pageController;
  Playlist _playlist;
  YoutubePlayerController prev, current, next;
  YoutubePlayer prevVideo, currentVideo, nextVideo;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _initPlaylist();
  }

  void _initPlaylist() async {
    Playlist playlist = await YoutubeDataAPI.instance
        .fromPlaylist(playlistId: 'PLlfoK0s_eIARWCqj5h4_aiebEaei4gYIA');
    setState(() {
      _playlist = playlist;
    });
    getVideo(0);
  }

  pauseVideo(YoutubePlayerController controller) {
    controller.pause();
  }

  playVideo(YoutubePlayerController controller) {
    controller.play();
  }

  disposeVideo(YoutubePlayerController controller) {
    controller.pause();
    controller.dispose();
  }

  YoutubePlayerController createNewController(int index) {
    if (index >= 0) {
      return YoutubePlayerController(
          initialVideoId: _playlist.videoIds[index % _playlist.videoIds.length],
          flags: YoutubePlayerFlags(
            mute: false,
            autoPlay: false,
            hideControls: false,
          ));
    } else {
      return null;
    }
  }

  YoutubePlayer createVideo(YoutubePlayerController controller) {}

  getVideo(int index) {
    if (index == 0) {
      current = createNewController(index);
      next = createNewController(index + 1);
      prev = createNewController(index - 1);
      currentPage = 0;
    }
    if (index > currentPage) {
      prev = current;
      current = next;
      disposeVideo(next);
      next = createNewController(index + 1);
      currentPage = index;
    }
    if (index < currentPage) {
      next = current;
      current = prev;
      disposeVideo(prev);
      prev = createNewController(index - 1);
      currentPage = index;
    }

    playVideo(current);
  }

  Widget youtubeVideo() {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.black,
          child: Center(
            child: currentVideo,
          ),
        ),
      ],
    );
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
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _playlist.videoIds.length,
                  pageSnapping: true,
                  scrollDirection: Axis.vertical,
                  controller: pageController,
                  onPageChanged: (index) {
                    print("JOoeleleelleleleleL ::{}" + index.toString());
                    getVideo(index);
                  },
                  itemBuilder: (context, index) {
                    return youtubeVideo();
                  },
                ),
              ));
  }
}
