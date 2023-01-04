import 'package:flutter/material.dart';
import 'package:netflix/constants/colors/colors.dart';
import 'package:netflix/constants/widgets/constants_widgets.dart';
import 'package:netflix/presentation/home/homescreen.dart';
import 'package:netflix/presentation/widgets/video_widget.dart';

class EveryoneWatchingTab extends StatelessWidget {
  final String filmName;
  final String posterPath;
  final String description;
  const EveryoneWatchingTab({
    Key? key,
    required this.filmName,
    required this.posterPath,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // shrinkWrap: true,
      children: [
        kheight,
        Text(
          filmName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            // letterSpacing: 1,
            color: ktextwhite,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        kheight,
        Text(
          description,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: kgrey,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        kheight50,
        VideoWidget(videoImage: posterPath),
        kheight20,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            IconsInHome(
              icon: Icons.share,
              buttonName: 'Share',
              textSize: 14,
              iconSize: 30,
            ),
            kwidth,
            IconsInHome(
              icon: Icons.add,
              buttonName: 'My List',
              textSize: 14,
              iconSize: 30,
            ),
            kwidth,
            IconsInHome(
              icon: Icons.play_arrow,
              buttonName: 'Play',
              textSize: 14,
              iconSize: 30,
            ),
            kwidth,
          ],
        ),
        kheight,
      ],
    );
  }
}
