import 'package:flutter/material.dart';
import 'package:netflix/presentation/downloads/download_screen.dart';
import 'package:netflix/presentation/fast_laugh/fast_laugh.dart';
import 'package:netflix/presentation/home/homescreen.dart';
import 'package:netflix/presentation/mainpage/widgets/bottom_navigation.dart';
import 'package:netflix/presentation/new_and_hot/new_and_hot.dart';
import 'package:netflix/presentation/search/search.dart';

class NavigatonBarScreen extends StatelessWidget {
  NavigatonBarScreen({Key? key}) : super(key: key);
  final pages = [
    HomeScreen(),
    const HotandNewScreen(),
    const FastLaughScreen(),
    SearchScreen(),
    DownloadsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: navigationbarindexnotifier,
          builder: (context, int value, _) {
            return pages[value];
          },
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidgets(),
    );
  }
}
