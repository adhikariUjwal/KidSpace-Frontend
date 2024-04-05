
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String selectedVideoUrl;
  final int videoId;

  const VideoPlayerWidget({super.key, required this.selectedVideoUrl, required this.videoId});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late FlickManager flickManager;

  @override
  void initState(){
    super.initState();
    flickManager = FlickManager(videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(widget.selectedVideoUrl)));
  }

  @override
  void dispose(){
    flickManager.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio:  6/11,child: FlickVideoPlayer(flickManager: flickManager));
  }
}