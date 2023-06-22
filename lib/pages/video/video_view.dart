import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:stickisaver/constants/style.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String path;

  const VideoView({Key? key, required this.path}) : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
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
    _videoPlayerController = VideoPlayerController.file(File(widget.path));
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
                  GallerySaver.saveVideo(
                    widget.path,
                    albumName: "Status Videos",
                  ).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Video Saved"),
                      ),
                    );
                  });
                },
                icon: Icon(Icons.download),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  FlutterNativeApi.shareVideo(widget.path);
                },
                icon: Icon(Icons.share_outlined),
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