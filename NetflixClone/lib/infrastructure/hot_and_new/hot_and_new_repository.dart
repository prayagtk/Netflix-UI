import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/api_end_points.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix/domain/hot_and_new/i_hotandnewrepo.dart';
import 'package:netflix/domain/hot_and_new/model/hot_and_new.dart';

@Singleton(as: IHotAndNewRepo)
class HotAndNewRepository implements IHotAndNewRepo {
  @override
  Future<Either<MainFailure, HotAndNew>> getHotsndNewMovieData() async {
    try {
      final Response response =
          await Dio(BaseOptions()).get(ApiEndPoints.hotandnewMovie);
      // log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final searchResult = HotAndNew.fromJson(response.data);
        // log(searchResult.toString());
        return right(searchResult);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      // log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }

  @override
  Future<Either<MainFailure, HotAndNew>> getHotsndNewTvData() async {
    try {
      final Response response =
          await Dio(BaseOptions()).get(ApiEndPoints.hotandnewTv);
      // log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final searchResult = HotAndNew.fromJson(response.data);
        // log(searchResult.toString());
        return right(searchResult);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      // log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
}
