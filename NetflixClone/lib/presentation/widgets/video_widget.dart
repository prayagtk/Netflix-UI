import 'package:flutter/material.dart';
import 'package:netflix/constants/colors/colors.dart';

class VideoWidget extends StatelessWidget {
  final String videoImage;
  const VideoWidget({
    Key? key,
    required this.videoImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(
            videoImage,
            fit: BoxFit.cover,
            loadingBuilder:
                (BuildContext _, Widget child, ImageChunkEvent? progress) {
              if (progress == null) {
                return child;
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              }
            },
            errorBuilder: (BuildContext _, Object child, StackTrace? trace) {
              return const Center(
                child: Icon(
                  Icons.wifi_off,
                  color: kwhite,
                ),
              );
            },
          ),
          // decoration: BoxDecoration(
          //   borderRadius: kradius10,
          //   image: DecorationImage(
          //     image: NetworkImage(videoImage),
          //     fit: BoxFit.cover,

          //   ),
          // ),
        ),
        Positioned(
          // left: 0,
          right: 10,
          bottom: 10,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.black.withOpacity(0.5),
            child: const Icon(
              Icons.volume_off,
              color: kwhite,
            ),
          ),
        )
      ],
    );
  }
}
