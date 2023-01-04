import 'package:netflix/constants/baseurl/base_url.dart';
import 'package:netflix/infrastructure/apikey.dart';

class ApiEndPoints {
  static const downloads = "$kBaseURL/trending/all/day?api_key=$apikey";
  static const search = "$kBaseURL/search/movie?api_key=$apikey";
  static const hotandnewMovie = "$kBaseURL/discover/movie?api_key=$apikey";
  static const hotandnewTv = "$kBaseURL/discover/tv?api_key=$apikey";
}
