import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:r_stream/controllers/auth_controller.dart';
import 'package:r_stream/models/video.dart';
import 'package:r_stream/widgets/video_tile.dart';

List<Video> videos = [
  Video(
    title: 'Big Buck Bunny',
    videoURL:
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
  ),
  Video(
    title: 'Elephant Dream',
    videoURL: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
  ),
  Video(
    title: 'For Bigger Blazes',
    videoURL: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
  ),
];

class HomePage extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('R Stream'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _authController.signOut,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return VideoTile(
              video: videos[index],
            );
          },
          itemCount: videos.length,
        ),
      ),
    );
  }
}
