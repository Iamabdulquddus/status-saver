import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class GetSavedProvider extends ChangeNotifier {
  int? androidSdk;
  List<FileSystemEntity> getSavedImages = [];
  List<FileSystemEntity> getSavedVideo = [];

  /// New android saved files path
  static String savedImageNewPath =
      "/storage/emulated/0/Pictures/Status Images";
  static String savedVideoNewPath = "/storage/emulated/0/Movies/Status Videos";

  /// Old android saved file path
  static String savedImageOldPath = "/storage/emulated/0/Status Images";
  static String savedVideoOldPath = "/storage/emulated/0/Status Videos";

  bool isfolderAvaliable = false;

  List<FileSystemEntity> get getImages => getSavedImages;
  List<FileSystemEntity> get getVideos => getSavedVideo;

  bool get folderAvaliable => isfolderAvaliable;

  void getStatus(String ext) async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    androidSdk = androidInfo.version.sdkInt;

    final PermissionStatus status;

    status = await Permission.storage.request();
    notifyListeners();

    if (status.isDenied) {
      Permission.storage.request();
      log("Permission denied");
      return;
    }

    if (status.isGranted) {
      final Directory imageDirectoryNew = Directory(savedImageNewPath);
      final Directory videoDirectoryNew = Directory(savedVideoNewPath);
      final Directory imageDirectoryOld = Directory(savedImageOldPath);
      final Directory videoDirectoryOld = Directory(savedVideoOldPath);

      ///  New Images
      if (imageDirectoryNew.existsSync()) {
        final items = imageDirectoryNew.listSync();

        getSavedImages =
            items.where((element) => element.path.endsWith(".jpg")).toList();

        isfolderAvaliable = true;
        notifyListeners();
        log(items.toString());
      }

      /// Old Images
      else if (imageDirectoryOld.existsSync()) {
        final items = imageDirectoryOld.listSync();

        getSavedImages =
            items.where((element) => element.path.endsWith(".jpg")).toList();

        isfolderAvaliable = true;
        notifyListeners();
        log(items.toString());
      }

      /// New Videos
      if (videoDirectoryNew.existsSync()) {
        final videoItems = videoDirectoryNew.listSync();

        getSavedVideo = videoItems
            .where((element) => element.path.endsWith(".mp4"))
            .toList();

        isfolderAvaliable = true;
        notifyListeners();
        log(videoItems.toString());
      }

      /// Video folder
      else if (videoDirectoryOld.existsSync()) {
        final videoItems = videoDirectoryOld.listSync();

        isfolderAvaliable = true;
        getSavedVideo = videoItems
            .where((element) => element.path.endsWith(".mp4"))
            .toList();

        notifyListeners();
        log(videoItems.toString());
      } else {
        log("No Status found");
        isfolderAvaliable = false;
        notifyListeners();
      }
    }
  }
}
