import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/constants/colors/colors.dart';
import 'package:netflix/constants/widgets/constants_widgets.dart';

class WidgetAppBar extends StatelessWidget {
  final String title;
  const WidgetAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        kwidth,
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.cast,
            color: kwhite,
            size: 30,
          ),
        ),
        // kwidth,
        Container(
          height: 30,
          width: 30,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'asset/image/ntflixAvat.jpg',
              ),
            ),
          ),
        ),
        kwidth,
      ],
    );
  }
}
