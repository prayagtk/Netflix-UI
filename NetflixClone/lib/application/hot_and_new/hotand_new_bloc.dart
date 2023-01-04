import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/hot_and_new/i_hotandnewrepo.dart';
import 'package:netflix/domain/hot_and_new/model/hot_and_new.dart';

part 'hotand_new_event.dart';
part 'hotand_new_state.dart';
part 'hotand_new_bloc.freezed.dart';

@injectable
class HotandNewBloc extends Bloc<HotandNewEvent, HotandNewState> {
  final IHotAndNewRepo iHotAndNewRepo;
  HotandNewBloc(this.iHotAndNewRepo) : super(HotandNewState.initial()) {
    on<LoadDatainComingSoon>((event, emit) async {
      emit(
        const HotandNewState(
          comingSoonList: [],
          everyOneIsWatching: [],
          isLoading: true,
          isError: false,
        ),
      );

      final result = await iHotAndNewRepo.getHotsndNewMovieData();
      final newState = result.fold(
        (MainFailure f) {
          return const HotandNewState(
            comingSoonList: [],
            everyOneIsWatching: [],
            isLoading: false,
            isError: true,
          );
        },
        (HotAndNew s) {
          return HotandNewState(
            comingSoonList: s.results,
            everyOneIsWatching: state.everyOneIsWatching,
            isLoading: false,
            isError: false,
          );
        },
      );
      emit(newState);
    });
    on<LoadDatainEveryOneWatching>((event, emit) async {
      emit(
        const HotandNewState(
          comingSoonList: [],
          everyOneIsWatching: [],
          isLoading: true,
          isError: false,
        ),
      );

      final tvresult = await iHotAndNewRepo.getHotsndNewTvData();
      final newState = tvresult.fold(
        (MainFailure failure) {
          return const HotandNewState(
            comingSoonList: [],
            everyOneIsWatching: [],
            isLoading: false,
            isError: true,
          );
        },
        (HotAndNew succes) {
          return HotandNewState(
            comingSoonList: [],
            everyOneIsWatching: succes.results,
            isLoading: false,
            isError: false,
          );
        },
      );
      emit(newState);
    });
  }
}
