part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    required List<SearchResultData> searchResultList,
    required List<Downloads> ideLisst,
    required bool isLodinng,
    required bool isError,
  }) = _SearchState;

  factory SearchState.initial() => const SearchState(
        searchResultList: [],
        ideLisst: [],
        isLodinng: false,
        isError: false,
      );
}
