import 'package:flutter/material.dart';
import 'package:ext_video_player/ext_video_player.dart';
import 'package:get/get.dart';
import 'package:r_stream/models/video.dart';

class VideoPlayingPage extends StatefulWidget {
  final Video video;

  const VideoPlayingPage({Key key, @required this.video}) : super(key: key);

  @override
  _VideoPlayingPageState createState() => _VideoPlayingPageState();
}

class _VideoPlayingPageState extends State<VideoPlayingPage> {
  VideoPlayerController _videoPlayerController;
  var isVideoPlayerInitialised = false.obs;

  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.network(widget.video.videoURL)
          ..initialize().then((value) => isVideoPlayerInitialised.value =
              _videoPlayerController.value.initialized).catchError((e) { print(e);});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16,),
          color: Colors.black,
          child: Center(
            child: AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  VideoPlayer(_videoPlayerController),
                  VideoControlsOverlay(_videoPlayerController),
                  VideoProgressIndicator(
                    _videoPlayerController,
                    allowScrubbing: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class VideoControlsOverlay extends StatefulWidget {
  VideoControlsOverlay(this.videoPlayerController);

  final VideoPlayerController videoPlayerController;

  @override
  _VideoControlsOverlayState createState() => _VideoControlsOverlayState();
}

class _VideoControlsOverlayState extends State<VideoControlsOverlay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.videoPlayerController?.value?.isPlaying ? Colors.transparent : Colors.black26.withOpacity(0.4),
      ),
      child: !widget.videoPlayerController.value.isPlaying ? Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white,),
              onPressed: reverseVideo,
            ),
            IconButton(icon: getPlayPauseIcon(), onPressed: playPause),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios_sharp, color: Colors.white,),
              onPressed: forwardVideo,
            ),
          ],
        ),
      ) : GestureDetector(
        onTap: playPause,
      ),
    );
  }

  Icon getPlayPauseIcon() {
    return widget.videoPlayerController.value.isPlaying
        ? Icon(Icons.pause, color: Colors.white,)
        : Icon(Icons.play_arrow, color: Colors.white,);
  }

  void reverseVideo() {
    widget.videoPlayerController.position.then((value) {
      if ((value - Duration(seconds: 10)).inSeconds <= 10)
        widget.videoPlayerController.seekTo(Duration());
      else
        widget.videoPlayerController.seekTo(value - Duration(seconds: 10));
    });
  }

  void forwardVideo() {
    VideoPlayerController videoPlayerController = widget.videoPlayerController;

    videoPlayerController.position.then((value) {
      Duration videoEnd = videoPlayerController.value.duration;
      if ((value + Duration(seconds: 10)) > videoEnd)
        videoPlayerController.seekTo(videoEnd);
      else
        videoPlayerController.seekTo(value + Duration(seconds: 10));
    });
  }

  void playPause() {
    VideoPlayerController videoPlayerController = widget.videoPlayerController;
    videoPlayerController.value.isPlaying
        ? videoPlayerController.pause()
        : videoPlayerController.play();
    setState(() {});
  }
}
