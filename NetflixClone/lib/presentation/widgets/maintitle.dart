import 'package:flutter/material.dart';

class MainTitleWidgets extends StatelessWidget {
  final String mainTitle;
  const MainTitleWidgets({
    Key? key,
    required this.mainTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      mainTitle,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
