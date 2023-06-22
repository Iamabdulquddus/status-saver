import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class GetStatusProvider extends ChangeNotifier {

  int? androidSdk;
  List<FileSystemEntity> _getImages = [];
  List<FileSystemEntity> _getVideos = [];
  static String WHATSAPP_PATH = '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses';
  static String WHATSAPP_BUSINESS_PATH = '/storage/emulated/0/Android/media/com.whatsapp.w4b/WhatsApp Business/Media/.Statuses';
  static String OLD_WHATSAPP_BUSINESS_PATH = '/storage/emulated/0/WhatsApp Business/Media/.Statuses';
  static String Old_Whatsapp_Path = "/storage/emulated/0/WhatsApp/Media/.Statuses";

  bool _isWhatsappAvailable = false;

  List<FileSystemEntity> get getImages => _getImages;
  List<FileSystemEntity> get getVideos => _getVideos;

  bool get isWhatsappAvailable => _isWhatsappAvailable;

  void getStatus(String ext) async {

    final androidInfo = await DeviceInfoPlugin().androidInfo;
    androidSdk = androidInfo.version.sdkInt;

    final PermissionStatus status;

    if(androidSdk! >= 30){
      status = await Permission.manageExternalStorage.request();

      notifyListeners();
    } else {
      status = await Permission.storage.request();
      notifyListeners();
    }

    if (status.isDenied) {

      Permission.storage.request();
      log("Permission denied");
      return;
    }

    /// Normal Whatsapp

     if (status.isGranted) {
      final Directory directory = Directory(WHATSAPP_PATH);
      final Directory oldDirectory = Directory(Old_Whatsapp_Path);
      // print(directory);

      /// Original Whatsapp android 11 and above
      if (directory.existsSync()) {
        final items = directory.listSync();
        if (ext == ".mp4") {
          _getVideos =
              items.where((element) => element.path.endsWith(".mp4")).toList();
          notifyListeners();
        }
        else {
          _getImages =
              items.where((element) => element.path.endsWith(".jpg")).toList();
          notifyListeners();
        }
        _isWhatsappAvailable = true;
        notifyListeners();
        log(items.toString());
      }

      /// Older Versions Whatsapp
      else  if   (oldDirectory.existsSync()) {
        final items = oldDirectory.listSync();
        if (ext == ".mp4") {
          _getVideos =
              items.where((element) => element.path.endsWith(".mp4")).toList();
          notifyListeners();
        } else {
          _getImages =
              items.where((element) => element.path.endsWith(".jpg")).toList();
          notifyListeners();
        }
        _isWhatsappAvailable = true;
        notifyListeners();
        log(items.toString());
      }


      else {
        log("No whatsapp  found");
        _isWhatsappAvailable = false;
        notifyListeners();
      }
    }

    /// Whatsapp Business

     else if (status.isGranted) {
      final Directory businessDirectory = Directory(WHATSAPP_BUSINESS_PATH);
      final Directory oldBusinessDirectory = Directory(OLD_WHATSAPP_BUSINESS_PATH);
      // print(directory);

      /// Original Whatsapp android 11 and above
      if (businessDirectory.existsSync()) {
        final items = businessDirectory.listSync();
        if (ext == ".mp4") {
          _getVideos =
              items.where((element) => element.path.endsWith(".mp4")).toList();
          notifyListeners();
        }
        else {
          _getImages =
              items.where((element) => element.path.endsWith(".jpg")).toList();
          notifyListeners();
        }
        _isWhatsappAvailable = true;
        notifyListeners();
        log(items.toString());
      }

      /// Older Versions Whatsapp
      else  if   (oldBusinessDirectory.existsSync()) {
        final items = oldBusinessDirectory.listSync();
        if (ext == ".mp4") {
          _getVideos =
              items.where((element) => element.path.endsWith(".mp4")).toList();
          notifyListeners();
        } else {
          _getImages =
              items.where((element) => element.path.endsWith(".jpg")).toList();
          notifyListeners();
        }
        _isWhatsappAvailable = true;
        notifyListeners();
        log(items.toString());
      }


      else {
        log("No whatsapp  found");
        _isWhatsappAvailable = false;
        notifyListeners();
      }
    }

  }
}
