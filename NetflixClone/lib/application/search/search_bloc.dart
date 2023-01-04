// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/downlods/i_downloads_repo.dart';
import 'package:netflix/domain/downlods/models/downloads_model.dart';
import 'package:netflix/domain/search/i_search_repo.dart';
import 'package:netflix/domain/search/model/search_resp/search_resp.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IDownloadRepo _iDownloadRepo;
  final ISearchRepo _iSearchRepo;
  SearchBloc(
    this._iDownloadRepo,
    this._iSearchRepo,
  ) : super(SearchState.initial()) {
    // >>>idle state<<<
    on<Initialize>((event, emit) async {
      if (state.ideLisst.isNotEmpty) {
        emit(state);
        // emit(
        //   SearchState(
        //     searchResultList: [],
        //     ideLisst: state.ideLisst,
        //     isLodinng: false,
        //     isError: false,
        //   ),
        // );
        return;
      }
      emit(
        const SearchState(
          searchResultList: [],
          ideLisst: [],
          isLodinng: true,
          isError: false,
        ),
      );
      //>>> get trending <<<
      final result = await _iDownloadRepo.getDownloadsImage();
      final resultState = result.fold(
        (MainFailure failure) {
          return const SearchState(
            searchResultList: [],
            ideLisst: [],
            isLodinng: false,
            isError: true,
          );
        },
        (List<Downloads> list) {
          return SearchState(
            searchResultList: [],
            ideLisst: list,
            isLodinng: false,
            isError: false,
          );
        },
      );
      emit(resultState);
    });
    // >>>Search result state<<<
    on<SearchMovie>(
      (event, emit) async {
        //>>> serach api call <<<
        // log('${event.movieQuery}');
        emit(
          SearchState(
            searchResultList: [],
            ideLisst: state.ideLisst,
            isLodinng: true,
            isError: false,
          ),
        );
        final result =
            await _iSearchRepo.searchMovies(movieQuery: event.movieQuery);
        // print('$result search reslt ');
        // ignore: no_leading_underscores_for_local_identifiers
        final _state = result.fold(
          (MainFailure f) {
            return SearchState(
              searchResultList: [],
              ideLisst: state.ideLisst,
              isLodinng: false,
              isError: true,
            );
          },
          (SearchResp r) {
            return SearchState(
              searchResultList: r.results,
              ideLisst: state.ideLisst,
              isLodinng: false,
              isError: false,
            );
          },
        );
        emit(_state);
      },
    );
  }
}
