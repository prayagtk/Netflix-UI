part of 'hotand_new_bloc.dart';

@freezed
class HotandNewState with _$HotandNewState {
  const factory HotandNewState({
    required List<HotAndNewData> comingSoonList,
    required List<HotAndNewData> everyOneIsWatching,
    required bool isLoading,
    required bool isError,
  }) = _Initial;
  factory HotandNewState.initial() => const HotandNewState(
        comingSoonList: [],
        everyOneIsWatching: [],
        isLoading: false,
        isError: false,
      );
}
