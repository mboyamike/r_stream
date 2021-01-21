import 'package:ext_video_player/ext_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:r_stream/models/video.dart';
import 'package:r_stream/screens/video_playing_page.dart';

class VideoTile extends StatefulWidget {
  VideoTile({this.video});

  final Video video;

  @override
  _VideoTileState createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.network(widget.video.videoURL)
          ..initialize()
              .then((value) => setState(() {}))
              .catchError((onError) => print(onError));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(VideoPlayingPage(video: widget.video));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 32),
        child: _videoPlayerController.value.initialized
            ? Column(
                children: [
                  SizedBox(
                    height: 200,
                    width: _videoPlayerController.value.aspectRatio * 200,
                    child: VideoPlayer(
                      _videoPlayerController,
                    ),
                  ),
                  Text(widget.video.title),
                ],
              )
            : Container(
                height: 220,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
