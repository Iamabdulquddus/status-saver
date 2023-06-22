import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stickisaver/pages/home/home.dart';
import 'package:stickisaver/provider/getSavedProvider.dart';
import 'provider/bottom_nav_provider.dart';
import 'Provider/getStatusProvider.dart';
import 'constants/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> pages = const [Text('Image'), Text('Video')];
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => GetStatusProvider()),
        ChangeNotifierProvider(create: (_) => GetSavedProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'Stickisaver',
          theme: ThemeData(
            // useMaterial3: true,
            primarySwatch: Palette.myColors,
          ),
          home: const HomePage(),


    ),);
  }
}
