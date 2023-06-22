import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stickisaver/constants/style.dart';

import '../../provider/bottom_nav_provider.dart';
import 'compoents/saved_image.dart';
import 'compoents/saved_video.dart';
class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, nav, child) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: snowBackground,
            appBar: AppBar(
              title: const Text('Saved Media'),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.image),

                  ),
                  Tab(
                    icon: Icon(Icons.ondemand_video),
                  ),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                SavedImage(),
                SavedVideo(),
              ],
            ),

          ),
        );
      },
    );
  }
}
