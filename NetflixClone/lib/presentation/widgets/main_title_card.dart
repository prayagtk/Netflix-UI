import 'package:flutter/material.dart';
import 'package:netflix/presentation/widgets/maintitle.dart';
import 'main_card.dart';

class MainCardTile extends StatelessWidget {
  final String cardTitle;
  final List<String> posterList;
  const MainCardTile({
    Key? key,
    required this.cardTitle,
    required this.posterList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitleWidgets(
          mainTitle: cardTitle,
        ),
        // kheight,
        LimitedBox(
          maxHeight: 250,
          child: ListView(
            // padding: EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            children: List.generate(
              posterList.length,
              (index) => MainCard(
                imageUrl: posterList[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
