// import 'package:flutter/material.dart';
// import 'package:tricktok/API-services/youtube-data-api.dart';
// import 'package:tricktok/models/video_model.dart';
// import 'package:tricktok/models/playlist_model.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class VideoScreen extends StatefulWidget {
//   @override
//   _VideoScreenState createState() => _VideoScreenState();
// }

// class _VideoScreenState extends State<VideoScreen> {
//   PageController pageController =
//       PageController(viewportFraction: 1, initialPage: 0);
//   YoutubePlayerController _youController;
//   int currentPageValue = 0;
//   int position;
//   Playlist _playlist;
//   bool _isLoading = false;
//   int prevPage = 0;
//   List<YoutubePlayer> videoControllerList;

//   @override
//   void initState() {
//     super.initState();
//     _initPlaylist();
//   }

//   void _initPlaylist() async {
//     Playlist playlist = await YoutubeDataAPI.instance
//         .fromPlaylist(playlistId: 'PLlfoK0s_eIARWCqj5h4_aiebEaei4gYIA');
//     setState(() {
//       _playlist = playlist;
//     });
//   }

//   changeVideo(index) {
//     print("changeVideo called");
//     int prev = index > prevPage ? index - 2 : index + 2;
//     //videoControllerList[prevPage].controller.pause();
//     prevPage = index;
//     disposeVideo(prev);
//     print("dispose");
//     loadVideo(index);
//     print("load");
//     videoControllerList[index].controller.play();
//   }

//   loadVideo(index) {
//     print("Load Video Called");
//     if (videoControllerList[index].controller == null) {
//       print("In if load");
//       videoControllerList[index].controller = createController(index);
//     }
//   }

//   YoutubePlayerController createController(index) {
//     print("create Controller Called");
//     return YoutubePlayerController(
//         initialVideoId: _playlist.videoIds[index],
//         flags: YoutubePlayerFlags(
//           mute: false,
//           autoPlay: true,
//           hideControls: false,
//         ));
//   }

//   pauseVideo(index) {
//     if (videoControllerList[index].controller != null)
//       videoControllerList[index].controller.pause();
//   }

//   playVideo(index) {
//     if (videoControllerList[index].controller != null)
//       videoControllerList[index].controller.pause();
//   }

//   disposeVideo(index) {
//     print("disposeVideo");
//     if (index >= 0) {
//       if (videoControllerList[index].controller != null) {
//         videoControllerList[index].controller.dispose();
//         videoControllerList[index] = null;
//       }
//     }
//   }

//   disposeAllController() {
//     videoControllerList.forEach((element) {
//       if (element.controller != null) {
//         element.controller.dispose();
//       }
//     });
//   }

//   YoutubePlayerController getController(index) {
//     return videoControllerList[index].controller;
//   }

//   Widget _playerSetup(controller) {
//     return YoutubePlayer(
//       aspectRatio: 9 / 16,
//       controller: controller,
//       showVideoProgressIndicator: false,
//     );
//   }

//   Widget videoCard(YoutubePlayer player) {
//     var controller = player.controller;
//     return Stack(
//       children: <Widget>[
//         controller != null
//             ? GestureDetector(
//                 onTap: () {
//                   controller.value.isPlaying
//                       ? controller.pause()
//                       : controller.play();
//                 },
//                 child: Container(
//                   color: Colors.black,
//                   child: Center(
//                     child: _playerSetup(controller),
//                   ),
//                 ),
//               )
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   LinearProgressIndicator(),
//                   SizedBox(
//                     height: 56,
//                   )
//                 ],
//               ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: _playlist == null
//             ? Center(
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(
//                     Theme.of(context).primaryColor, // Red
//                   ),
//                 ),
//               )
//             : SafeArea(
//                 child: PageView.builder(
//                   physics: BouncingScrollPhysics(),
//                   itemCount: _playlist.videoIds.length,
//                   pageSnapping: true,
//                   scrollDirection: Axis.vertical,
//                   controller: pageController,
//                   onPageChanged: (index) {
//                     index = index % _playlist.videoIds.length;
//                     changeVideo(index);
//                   },
//                   itemBuilder: (context, index) {
//                     index = index % _playlist.videoIds.length;
//                     return videoCard(videoControllerList[index]);
//                   },
//                 ),
//               ));
//     @override
//     void dispose() {
//       super.dispose();
//     }
//   }
// }
