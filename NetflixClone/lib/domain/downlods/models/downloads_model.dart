// import 'package:freezed_annotation/freezed_annotation.dart';
// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
part 'downloads_model.freezed.dart';
part 'downloads_model.g.dart';

@freezed
class Downloads with _$Downloads {
  const factory Downloads({
    // ignore: invalid_annotation_target
    @JsonKey(name: "poster_path") required String? posterPath,
    // ignore: invalid_annotation_target
    @JsonKey(name: "title") required String? title,
    // title
  }) = _Downloads;

  factory Downloads.fromJson(Map<String, dynamic> json) =>
      _$DownloadsFromJson(json);
}
