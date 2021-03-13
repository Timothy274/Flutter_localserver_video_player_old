import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class Player extends StatefulWidget {
  String path;
  Player({this.path});
  @override
  _playerState createState() => _playerState();
}

class _playerState extends State<Player> {
  TargetPlatform _platform;
  VideoPlayerController _controller;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
    // _chewieController.enterFullScreen();
    _controller.seekTo(const Duration());
    _chewieController = ChewieController(videoPlayerController: _controller, autoPlay: true, looping: true, aspectRatio: 16 / 9);
  }

  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    String link = widget.path.substring(1);
    String baselink = 'http://192.168.0.200/access/server_1';
    String linkresult = baselink + link;
    print(linkresult);
    String linkresultformat = linkresult.replaceAll(' ', '%20');
    linkresultformat = linkresultformat.replaceAll('[', '%5b');
    linkresultformat = linkresultformat.replaceAll(']', '%5d');
    print(linkresultformat);

    _controller = VideoPlayerController.network(linkresultformat);
    await Future.wait([_controller.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: true,
    );
    // Try playing around with some of these other options:

    // showControls: false,
    // materialProgressColors: ChewieProgressColors(
    //   playedColor: Colors.red,
    //   handleColor: Colors.blue,
    //   backgroundColor: Colors.grey,
    //   bufferedColor: Colors.lightGreen,
    // ),
    // placeholder: Container(
    //   color: Colors.grey,
    // ),
    // autoInitialize: true,
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: FutureBuilder(
                future: initializePlayer(),
                builder: (context, i) {
                  if (i.hasError) print(i.error);
                  return _chewieController != null && _chewieController.videoPlayerController.value.initialized
                      ? Chewie(
                          controller: _chewieController,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                          ],
                        );
                })));
  }
}
