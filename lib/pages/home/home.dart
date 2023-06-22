import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stickisaver/constants/style.dart';
import 'package:stickisaver/pages/saved/saved.dart';

import '../../provider/bottom_nav_provider.dart';
import '../image/image.dart';
import '../video/video.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, nav, child) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: snowBackground,
            appBar: AppBar(
              title: const Text('Status Saver'),
              actions: [
                PopupMenuButton(itemBuilder: (ctx) {
                  return [
                    PopupMenuItem(
                      value: "saved",
                      child: ListTile(
                        title: Text(
                          "Saved Statuses         ",
                          style: MyTextStyles.headingSmallPrimary,
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Saved(),
                            ),
                          );
                        },
                      ),
                    ),
                  ];
                })
              ],
              bottom: TabBar(
                tabs: [
                  const Tab(
                    icon: Icon(Icons.image),
                  ),
                  const Tab(
                    icon: Icon(Icons.ondemand_video),
                  ),

                ],
              ),
            ),
            body: const TabBarView(
              children: [
                ImageTab(),
                VideoHomePage(),
              ],
            ),
          ),
        );
      },
    );
  }
}
