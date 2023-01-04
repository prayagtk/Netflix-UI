import 'package:flutter/material.dart';
import 'package:netflix/constants/colors/colors.dart';

ValueNotifier<int> navigationbarindexnotifier = ValueNotifier(0);

class BottomNavigationWidgets extends StatelessWidget {
  const BottomNavigationWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: navigationbarindexnotifier,
      builder: (context, int newIndex, _) {
        return BottomNavigationBar(
          onTap: (value) {
            navigationbarindexnotifier.value = value;
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: bagroundColor,
          elevation: 0,
          currentIndex: newIndex,
          selectedItemColor: kwhite,
          unselectedItemColor: kgrey,
          selectedIconTheme: const IconThemeData(
            color: kwhite,
          ),
          unselectedIconTheme: const IconThemeData(
            color: kgrey,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.video_library_outlined,
              ),
              label: 'New & Hot',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.sentiment_satisfied_alt,
              ),
              label: 'FastLaughs',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.download_for_offline_outlined,
              ),
              label: 'Downloads',
            ),
          ],
        );
      },
    );
  }
}
