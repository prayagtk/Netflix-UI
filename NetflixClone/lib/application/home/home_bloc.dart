// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/hot_and_new/i_hotandnewrepo.dart';
import 'package:netflix/domain/hot_and_new/model/hot_and_new.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IHotAndNewRepo iHomeRepo;
  HomeBloc(this.iHomeRepo) : super(HomeState.initial()) {
    on<GetHomeScreenData>((event, emit) async {
      emit(
        state.copyWith(
          isLoading: true,
          isError: false,
        ),
      );
      final movieResult = await iHomeRepo.getHotsndNewMovieData();
      final tvResult = await iHomeRepo.getHotsndNewTvData();
      final stateone = movieResult.fold(
        (MainFailure failure) {
          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastyearMovie: [],
            trendinNow: [],
            tenseDrama: [],
            southIndian: [],
            trendingTvList: [],
            isLoading: false,
            isError: true,
          );
        },
        (HotAndNew resp) {
          final pastYear = resp.results;
          final trending = resp.results;
          final tenseDramaovie = resp.results;
          final southIndianMovie = resp.results;
          // final trendinggTvList = resp.results;
          pastYear.shuffle();
          trending.shuffle();
          tenseDramaovie.shuffle();
          southIndianMovie.shuffle();

          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastyearMovie: pastYear,
            trendinNow: trending,
            tenseDrama: tenseDramaovie,
            southIndian: southIndianMovie,
            trendingTvList: state.trendingTvList,
            isLoading: false,
            isError: false,
          );
        },
      );
      emit(stateone);

      final statetwo = tvResult.fold(
        (MainFailure failure) {
          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastyearMovie: [],
            trendinNow: [],
            tenseDrama: [],
            southIndian: [],
            trendingTvList: [],
            isLoading: false,
            isError: true,
          );
        },
        (HotAndNew resp) {
          final topTen = resp.results;
          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastyearMovie: state.pastyearMovie,
            trendinNow: state.trendinNow,
            tenseDrama: state.tenseDrama,
            southIndian: state.southIndian,
            trendingTvList: topTen,
            isLoading: false,
            isError: false,
          );
        },
      );

      emit(statetwo);
    });
  }
}
