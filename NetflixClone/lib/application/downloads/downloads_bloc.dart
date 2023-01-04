// ignore: depend_on_referenced_packages
import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/downlods/i_downloads_repo.dart';
import 'package:netflix/domain/downlods/models/downloads_model.dart';
part 'downloads_event.dart';
part 'downloads_state.dart';
part 'downloads_bloc.freezed.dart';

@injectable
class DownloadsBloc extends Bloc<DownloadsEvent, DownloadState> {
  final IDownloadRepo downloadRepo;
  DownloadsBloc(this.downloadRepo) : super(DownloadState.inital()) {
    on<_GetDownloadsImage>(
      (event, emit) async {
        if (state.downloads.isNotEmpty) {
          emit(
            state.copyWith(
              isLoading: false,
              downloadsFailureorSucessOption: none(),
            ),
          );
          return;
        }
        emit(
          state.copyWith(
            isLoading: true,
            downloadsFailureorSucessOption: none(),
          ),
        );
        final Either<MainFailure, List<Downloads>> downloadsOption =
            await downloadRepo.getDownloadsImage();
        log(downloadsOption.toString());
        emit(
          downloadsOption.fold(
            (failure) => state.copyWith(
              isLoading: false,
              downloadsFailureorSucessOption: Some(
                left(failure),
              ),
            ),
            (sucess) => state.copyWith(
              isLoading: false,
              downloads: sucess,
              downloadsFailureorSucessOption: Some(
                right(sucess),
              ),
            ),
          ),
        );
      },
    );
  }
}
