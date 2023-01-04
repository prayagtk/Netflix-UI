import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix/domain/search/i_search_repo.dart';
import 'package:netflix/domain/search/model/search_resp/search_resp.dart';

import '../../domain/core/api_end_points.dart';

@LazySingleton(as: ISearchRepo)
class SearchRepository implements ISearchRepo {
  @override
  Future<Either<MainFailure, SearchResp>> searchMovies(
      {required String movieQuery}) async {
    try {
      final Response response = await Dio(BaseOptions()).get(
        ApiEndPoints.search,
        queryParameters: {
          'query': movieQuery,
        },
      );
      // log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final searchResult = SearchResp.fromJson(response.data);
        // log(searchResult.toString());
        return right(searchResult);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } 
    // on DioError catch (e) {
    //   log('$e catch dio error');
    //   return const Left(MainFailure.clientFailure());
    // } 
    catch (e) {
      log('$e catch  error');
      return const Left(MainFailure.clientFailure());
    }
  }
}
