import 'package:flutter/cupertino.dart';

class Video {
  Video({@required this.title, @required this.videoURL, this.description});

  final String title;
  final String videoURL;
  String description;
}