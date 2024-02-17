import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  final VideoPlayerController _videoPlayerController = VideoPlayerController.asset("assets/stop_watch.MOV");

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.position == _videoPlayerController.value.duration) {
        widget.onVideoFinished();
      }
      // if (_videoPlayerController.value.isCompleted) {
      //   widget.onVideoFinished();
      // }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    _videoPlayerController.play();
    setState(() {});
    _videoPlayerController.addListener(_onVideoChange);
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black,
          child: _videoPlayerController.value.isInitialized
              ? VideoPlayer(_videoPlayerController)
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ],
    );
  }
}
