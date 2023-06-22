import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../Provider/getStatusProvider.dart';
import '../../../../constants/style.dart';
import 'video_view.dart';

Future<String> getThumbnail(String path) async {
  String? thumb = await VideoThumbnail.thumbnailFile(video: path);

  return thumb!;
}
class VideoHomePage extends StatefulWidget {

  const VideoHomePage({Key? key}) : super(key: key);

  @override
  State<VideoHomePage> createState() => _VideoHomePageState();
}

class _VideoHomePageState extends State<VideoHomePage> {



  bool _isFetched = false;
  @override
  Widget build(BuildContext context) {
    return  Consumer<GetStatusProvider>(builder: (context, file, child) {
      if (_isFetched == false) {
        file.getStatus(".mp4");
        Future.delayed(const Duration(microseconds: 1), () {
          _isFetched = true;
        });
      }
      return file.isWhatsappAvailable == false
          ? const Center(
              child: Text("Whatsapp not available"),
            )
          : file.getVideos.isEmpty
              ? const Center(
                  child: Text("No Video available"),
                )
              : Container(
                  padding: const EdgeInsets.all(5),
                  child: GridView(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 300,
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                    children: List.generate(file.getVideos.length, (index) {
                      final data = file.getVideos[index];
                      return FutureBuilder<String>(
                          future: getThumbnail(data.path),
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (_) => VideoView(
                                            path: data.path,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      elevation: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: lightColor,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(
                                                File(snapshot.data!),

                                              ),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),),
                                      ),
                                    ),
                                  )
                                :Container(
                              width: 200.0,
                              height: 300.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Shimmer.fromColors(
                                baseColor: lightColor,
                                highlightColor: primary.withOpacity(0.3),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: primary,
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
                  ),
                );
    });
  }
}
