import 'package:dartz/dartz.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/downlods/models/downloads_model.dart';

abstract class IDownloadRepo {
  Future<Either<MainFailure, List<Downloads>>> getDownloadsImage();
}
