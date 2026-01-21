import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:playlist_music/app/core/constant.dart';
import 'package:playlist_music/app/core/network/dio_client.dart';
import 'package:playlist_music/app/data/model/song_model.dart';

class SongService {
  final Dio _dio = DioClient.instance;

  Future<SongModel?> fetchSonglist({
    required String term,
  }) async {
    try {
      final response = await _dio.get(
        AppConstant.search,
        queryParameters: {
          'term': term,
          'limit': 50,
          'entity': 'song',
          'country': 'th'
        },
      );
      if (response.data != null) {
        return SongModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      log("Error in Song Data Service: $e");
      return null;
    }
  }
}
