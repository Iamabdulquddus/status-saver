import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stickisaver/pages/saved/compoents/saved_image_show.dart';
import '../../../../constants/style.dart';
import '../../../provider/getSavedProvider.dart';
import '../../image/image_view.dart';

class SavedImage extends StatefulWidget {
  const SavedImage({Key? key}) : super(key: key);

  @override
  State<SavedImage> createState() => _SavedImageState();
}

class _SavedImageState extends State<SavedImage> {
  bool _isFetched = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<GetSavedProvider>(
      builder: (context, file, child) {
        if (_isFetched == false) {
          file.getStatus(".jpg");
          Future.delayed(const Duration(microseconds: 1), () {
            _isFetched = true;
          });
        }
        return file.folderAvaliable == false
            ? const Center(
                child: Text("Folder not avaliable"),
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
                                  builder: (_) => SavedImageShow(
                                    savedImagePath: data.path,
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
