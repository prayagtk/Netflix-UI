import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix/domain/downlods/models/downloads_model.dart';
import 'package:netflix/presentation/fast_laugh/widgets/video_list_item.dart';

class VideoListItemInherit extends InheritedWidget {
  final Widget widget;
  final Downloads movieData;

  const VideoListItemInherit({
    Key? key,
    required this.widget,
    required this.movieData,
  }) : super(key: key, child: widget);
  @override
  bool updateShouldNotify(covariant VideoListItemInherit oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VideoListItemInherit? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoListItemInherit>();
  }
}

class FastLaughScreen extends StatelessWidget {
  const FastLaughScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FastLaughBloc>(context).add(
        const Initialize(),
      );
    });
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<FastLaughBloc, FastLaughState>(
          builder: (context, state) {
            if (state.isError) {
              return const Center(
                child: Text('Data Error!!'),
              );
            } else if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.videosList.isEmpty) {
              return const Center(
                child: Text('Video List Empty!!'),
              );
            } else {
              return PageView(
                scrollDirection: Axis.vertical,
                children: List.generate(
                  state.videosList.length,
                  (index) {
                    return VideoListItemInherit(
                      key: Key(index.toString()),
                      widget: VideoListItem(index: index),
                      movieData: state.videosList[index],
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
