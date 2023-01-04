import 'package:flutter/material.dart';
import 'package:netflix/constants/colors/colors.dart';
import 'package:netflix/constants/widgets/constants_widgets.dart';
import 'package:netflix/presentation/home/homescreen.dart';
import 'package:netflix/presentation/widgets/video_widget.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class ComingSoonTab extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String filmName;
  final String posterPath;
  final String description;

  const ComingSoonTab({
    Key? key,
    required this.id,
    required this.month,
    required this.day,
    required this.filmName,
    required this.posterPath,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        StickyHeader(
          header: Column(
            children: [
              Text(
                month,
                style: const TextStyle(
                  fontSize: 15,
                  letterSpacing: 2,
                  color: kgrey,
                ),
              ),
              Text(
                day,
                style: const TextStyle(
                  fontSize: 20,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const SizedBox(
            height: 450,
            width: 50,
          ),
        ),
        SizedBox(
          width: size.width - 50,
          // width: double.infinity,
          height: 500,
          child: Column(
            children: [
              VideoWidget(videoImage: posterPath),
              kheight20,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      filmName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        letterSpacing: -3,
                        color: ktextwhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  const IconsInHome(
                    icon: Icons.notification_important,
                    buttonName: 'Remind me',
                    iconSize: 25,
                    textSize: 12,
                  ),
                  kwidth,
                  const IconsInHome(
                    icon: Icons.info,
                    buttonName: 'Info',
                    iconSize: 25,
                    textSize: 12,
                  ),
                ],
              ),
              // kheight,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: const [
              //     IconsInHome(
              //       icon: Icons.notification_important,
              //       buttonName: 'Remind me',
              //       iconSize: 25,
              //       textSize: 12,
              //     ),
              //     kwidth,
              //     IconsInHome(
              //       icon: Icons.info,
              //       buttonName: 'Info',
              //       iconSize: 25,
              //       textSize: 12,
              //     ),
              //     kwidth20,
              //   ],
              // ),
              kheight20,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  filmName,
                  style: const TextStyle(
                    color: kwhite,
                  ),
                ),
              ),
              kheight,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'The next $day $month',
                  style: const TextStyle(
                    color: kwhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              kheight,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  description,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: kgrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
