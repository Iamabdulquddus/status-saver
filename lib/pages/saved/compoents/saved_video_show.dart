import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:stickisaver/constants/style.dart';
import 'package:video_player/video_player.dart';

class SavedVideoView extends StatefulWidget {
  final String savedVideoPath;

  const SavedVideoView({Key? key, required this.savedVideoPath}) : super(key: key);

  @override
  State<SavedVideoView> createState() => _SavedVideoViewState();
}

class _SavedVideoViewState extends State<SavedVideoView> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  late Future<void> _future;

  Future<void> initVideoPlayer() async {
    await _videoPlayerController.initialize();
    setState(() {
      _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          aspectRatio: _videoPlayerController.value.aspectRatio,
          looping: true,
          autoPlay: true);
    });
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.file(File(widget.savedVideoPath));
    _future = initVideoPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightColor,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  FlutterNativeApi.shareVideo(widget.savedVideoPath);
                },
                icon: const Icon(Icons.share),
              ),
            ),
          ],
        ),
        body: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              return Center(
                child: _videoPlayerController.value.isInitialized
                    ? AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: Chewie(
                    controller: _chewieController,
                  ),
                )
                    : const CircularProgressIndicator(),
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
