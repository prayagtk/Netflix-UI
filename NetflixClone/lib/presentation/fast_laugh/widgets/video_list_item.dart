import 'package:flutter/material.dart';
import 'package:netflix/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix/constants/baseurl/base_url.dart';
import 'package:netflix/constants/colors/colors.dart';
import 'package:netflix/presentation/fast_laugh/fast_laugh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class VideoListItem extends StatelessWidget {
  final int index;
  const VideoListItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posterpath = VideoListItemInherit.of(context)?.movieData.posterPath;
    final videoUrl = dummyVideoList[index % dummyVideoList.length];
    return Stack(
      children: [
        FastLaughVideoPlayer(
          videoUrl: videoUrl,
          onStateChanged: (bool) {},
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Left side
                CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  radius: 30,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.volume_off,
                      color: kwhite,
                      size: 30,
                    ),
                  ),
                ),

                // Right side
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: posterpath == null
                            ? null
                            : NetworkImage(
                                '$kImageURL$posterpath',
                              ),
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: likedVideoIdNotifier,
                      builder: (BuildContext ctx, Set<int> newLikedVideo,
                          Widget? _) {
                        final _indexLol = index;
                        if (newLikedVideo.contains(_indexLol)) {
                          return GestureDetector(
                            onTap: () {
                              likedVideoIdNotifier.value.remove(_indexLol);
                              likedVideoIdNotifier.notifyListeners();
                              // BlocProvider.of<FastLaughBloc>(context).add(
                              //   LikedVideo(id: _indexLol),
                              // );
                            },
                            child: const VideoActionWidgets(
                              actionIcon: Icons.favorite,
                              actionTitle: 'Liked',
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            likedVideoIdNotifier.value.add(_indexLol);
                            likedVideoIdNotifier.notifyListeners();
                            // BlocProvider.of<FastLaughBloc>(context).add(
                            //   UnLikedVideo(id: _indexLol),
                            // );
                          },
                          child: const VideoActionWidgets(
                            actionIcon: Icons.emoji_emotions,
                            actionTitle: 'LOL',
                          ),
                        );
                      },
                    ),
                    const VideoActionWidgets(
                      actionIcon: Icons.add,
                      actionTitle: 'My List',
                    ),
                    GestureDetector(
                      onTap: () {
                        final movieName =
                            VideoListItemInherit.of(context)?.movieData.title;
                        if (movieName != null) {
                          Share.share(movieName);
                        }
                      },
                      child: const VideoActionWidgets(
                        actionIcon: Icons.share,
                        actionTitle: 'Share',
                      ),
                    ),
                    const VideoActionWidgets(
                      actionIcon: Icons.play_arrow,
                      actionTitle: 'Play',
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        // Positioned(
        //   bottom: 0,
        //   left: 0,
        //   right: 0,
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.end,
        //     children: [
        //       IconButton(
        //         onPressed: () {},
        //         icon: Icon(
        //           Icons.volume_off,
        //         ),
        //       )
        //     ],
        //   ),
        // )
      ],
    );
  }
}

class VideoActionWidgets extends StatelessWidget {
  final IconData actionIcon;
  final String actionTitle;
  const VideoActionWidgets({
    Key? key,
    required this.actionIcon,
    required this.actionTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Column(
        children: [
          Icon(
            actionIcon,
            color: kwhite,
            size: 30,
          ),
          Text(
            actionTitle,
            style: const TextStyle(
              color: ktextwhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  final String videoUrl;
  Function(bool isPlaying) onStateChanged;
  FastLaughVideoPlayer({
    Key? key,
    required this.videoUrl,
    required this.onStateChanged,
  }) : super(key: key);

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    videoPlayerController.initialize().then((value) {
      setState(() {});
      videoPlayerController.play();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: VideoPlayer(videoPlayerController),
            )
          : const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            ),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
