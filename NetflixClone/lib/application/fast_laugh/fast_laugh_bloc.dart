// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/downlods/i_downloads_repo.dart';
import 'package:netflix/domain/downlods/models/downloads_model.dart';

part 'fast_laugh_event.dart';
part 'fast_laugh_state.dart';
part 'fast_laugh_bloc.freezed.dart';

final dummyVideoList = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
];

ValueNotifier<Set<int>> likedVideoIdNotifier = ValueNotifier({});

@injectable
class FastLaughBloc extends Bloc<FastLaughEvent, FastLaughState> {
  FastLaughBloc(
    IDownloadRepo iDownloadRepo,
  ) : super(FastLaughState.initial()) {
    on<Initialize>((event, emit) async {
      emit(
        const FastLaughState(
          videosList: [],
          isLoading: true,
          isError: false,
        ),
      );
      // ignore: no_leading_underscores_for_local_identifiers
      final _result = await iDownloadRepo.getDownloadsImage();
      // ignore: no_leading_underscores_for_local_identifiers
      final _state = _result.fold((MainFailure f) {
        return const FastLaughState(
          videosList: [],
          isLoading: false,
          isError: true,
        );
      }, (resp) {
        return FastLaughState(
          videosList: resp,
          isLoading: false,
          isError: false,
        );
      });
      emit(_state);
    });
    on<LikedVideo>((event, emit) async {
      likedVideoIdNotifier.value.add(event.id);
      likedVideoIdNotifier.notifyListeners();
    });
    on<UnLikedVideo>((event, emit) {
      likedVideoIdNotifier.value.remove(event.id);
    });
  }
}
