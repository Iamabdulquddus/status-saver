import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import '../../../../constants/style.dart';


class SavedImageShow extends StatefulWidget {
  final String? savedImagePath;
  const SavedImageShow({Key? key, this.savedImagePath}) : super(key: key);

  @override
  State<SavedImageShow> createState() => _SavedImageShowState();
}



class _SavedImageShowState extends State<SavedImageShow> {



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightColor,
        body: Container(
          decoration: BoxDecoration(
            color: lightColor,
            image: DecorationImage(
              fit: BoxFit.contain,
              image: FileImage(
                File(widget.savedImagePath!),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(onPressed: (){
          FlutterNativeApi.shareImage(widget.savedImagePath!);
        }, label:Row(
          children: [
            Icon(Icons.share),
            SizedBox(width: 10,),
            Text('Share'),
          ],
        ),),
      ),
    );
  }
}
