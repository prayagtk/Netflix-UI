import 'package:flutter/material.dart';
import 'package:netflix/constants/widgets/constants_widgets.dart';

class MainCard extends StatelessWidget {
  final String imageUrl;
  const MainCard({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      // padding: EdgeInsets.symmetric(vertical: 50),
      height: 250,
      width: 130,
      // color: Colors.green,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            imageUrl,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: kradius10,
      ),
    );
  }
}
