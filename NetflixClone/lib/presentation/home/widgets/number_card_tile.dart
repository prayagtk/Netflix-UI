import 'package:flutter/material.dart';

import '../../widgets/maintitle.dart';
import 'number_card.dart';

class NumbeCard extends StatelessWidget {
  final List<String> posterList;
  const NumbeCard({
    Key? key,
    required this.posterList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MainTitleWidgets(
          mainTitle: 'Top 10 Tv Shows In India Today',
        ),
        // kheight,
        LimitedBox(
          maxHeight: 250,
          child: ListView(
            // padding: EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            children: List.generate(
              posterList.length,
              (index) => NumberCardWidget(
                index: index,
                topImageUrl: posterList[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
