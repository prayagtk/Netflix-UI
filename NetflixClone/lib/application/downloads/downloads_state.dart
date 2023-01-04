part of 'downloads_bloc.dart';

@freezed
class DownloadState with _$DownloadState {
  const factory DownloadState({
    required bool isLoading,
    required List<Downloads> downloads,
    required Option<Either<MainFailure, List<Downloads>>>
        downloadsFailureorSucessOption,
  }) = _DownloadState;
  factory DownloadState.inital() {
    return const DownloadState(
      isLoading: false,
      downloadsFailureorSucessOption: None(),
      downloads: [],
    );
  }
}
