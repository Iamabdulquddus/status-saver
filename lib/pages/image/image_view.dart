import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:gallery_saver/gallery_saver.dart';
import '../../../../constants/style.dart';

class ImageView extends StatefulWidget {
  final String? imagePath;
  const ImageView({Key? key, this.imagePath}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: lightColor,
            image: DecorationImage(
              fit: BoxFit.contain,
              image: FileImage(
                File(widget.imagePath!),
              ),
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton.extended(
                heroTag: "btn1",
                onPressed: () {
                  GallerySaver.saveImage(
                    widget.imagePath!,
                    albumName: "Status Images",
                  ).then(
                    (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Image Saved"),
                        ),
                      );
                    },
                  );
                },
                label: Row(
                  children: const [
                    Icon(Icons.download),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Save"),
                  ],
                ),
              ),
              FloatingActionButton.extended(
                heroTag: "btn2",
                onPressed: () {
                  FlutterNativeApi.shareImage(widget.imagePath!);
                },
                label: Row(
                  children: const [
                    Icon(Icons.share),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Share'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
