import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:netflix/constants/colors/colors.dart';

class DropDownListWidget extends StatelessWidget {
  const DropDownListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 10,
        sigmaY: 10,
      ),
      child: Dialog(
        backgroundColor: ktransperant,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(
                height: 25,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SizedBox(height: index == 0 ? 100 : 0),
                    Text(
                      categoryList[index],
                      style: const TextStyle(
                        color: Color.fromARGB(255, 149, 144, 144),
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      color: Colors.transparent,
                      height: index == categoryList.length - 1 ? 200 : 0,
                    )
                  ],
                );
              },
              itemCount: categoryList.length,
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.close,
                  size: 29,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

final List<String> categoryList = [
  'My List',
  'Available For Download',
  'Every Day id Filmy With Netfix',
  'HIndi',
  'Tamil',
  'Telugu',
  'Malayalam',
  'Marathi',
  'Bengali',
  'Englsih',
  'Action',
  'Anime',
  'Award Winners',
  'Biographical',
  'Blockbusters',
  'Bollywood',
  'Kids & Family',
  'Comedies',
  'Documents',
  'Dramas',
  'Fantasy',
  'Hollywood',
  'Horror',
  'International',
  'Indian',
  'Music & Musicals',
  'Reality & Talk',
  'Roamnce',
  'Sci-Fi',
  'Stand-Up',
  'Thrillers',
  'United States',
  'Audio decription',
];
