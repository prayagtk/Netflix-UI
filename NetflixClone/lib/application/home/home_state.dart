part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required String stateId,
    required List<HotAndNewData> pastyearMovie,
    required List<HotAndNewData> trendinNow,
    // required List<HotAndNewData> topTen,
    required List<HotAndNewData> tenseDrama,
    required List<HotAndNewData> southIndian,
    required List<HotAndNewData> trendingTvList,
    required bool isLoading,
    required bool isError,
  }) = _Initial;
  factory HomeState.initial() => const HomeState(
        stateId: '0',
        pastyearMovie: [],
        trendinNow: [],
        // topTen: [],
        tenseDrama: [],
        southIndian: [],
        trendingTvList: [],
        isLoading: false,
        isError: false,
      );
}
