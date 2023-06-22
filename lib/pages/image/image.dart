import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Provider/getStatusProvider.dart';
import '../../../../constants/style.dart';
import 'image_view.dart';

class ImageTab extends StatefulWidget {
  const ImageTab({Key? key}) : super(key: key);

  @override
  State<ImageTab> createState() => _ImageTabState();
}

class _ImageTabState extends State<ImageTab> {
  bool _isFetched = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<GetStatusProvider>(
      builder: (context, file, child) {
        if (_isFetched == false) {
          file.getStatus(".jpg");
          Future.delayed(const Duration(microseconds: 1), () {
            _isFetched = true;
          });
        }
        return file.isWhatsappAvailable == false
            ? const Center(
                child: Text("Whatsapp not available"),
              )
            : file.getImages.isEmpty
                ? const Center(
                    child: Text("No image available"),
                  )
                : Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(5),
                    child: GridView(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 300,
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                      children: List.generate(
                        file.getImages.length,
                        (index) {
                          final data = file.getImages[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) => ImageView(
                                    imagePath: data.path,
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
                                      File(data.path),
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
      },
    );
  }
}
