import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:playlist_music/app/core/constant.dart';
import 'package:playlist_music/app/core/widgets/error_widget.dart';
import 'package:playlist_music/app/data/model/song_model.dart';
import 'package:playlist_music/app/data/service/song_service.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomeController extends GetxController {
  final SongService _service = SongService();
  final AudioPlayer _audioPlayer = AudioPlayer();
  var songs = <Song>[].obs;
  var isLoading = false.obs;
  var termserch = "".obs;

  // สถานะการเล่น
  var playingTrackId = 0.obs;
  var isPlaying = false.obs;
  // เล่นล่าสุด
  var selectedSong = Rxn<Song>();
  var position = Duration.zero.obs; // เวลาปัจจุบันที่เล่น
  var duration = Duration.zero.obs; // เวลาทั้งหมดของเพลง

  // loadmore
  var isMoreLoading = false.obs; // โหลดเพิ่ม
  var hasMore = true.obs; // เช็กข้อมูลว่าหมดหรือยัง
  var backToTop = false.obs; // ปุ่มกลับไปบนสุด

  //
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    loadSongList();
    // scroller
    scrollController.addListener(() {
      backToTop.value = scrollController.offset > 500;
    });
    // pause music
    _audioPlayer.onPositionChanged.listen((p) => position.value = p);
    _audioPlayer.onDurationChanged.listen((d) => duration.value = d);
    _audioPlayer.onPlayerComplete.listen((event) {
      isPlaying(false);
      playingTrackId.value = 0;
    });
  }

  // --- กลับไปบนสุด ---
  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  //load
  Future<void> loadSongList() async {
    try {
      if (songs.isEmpty) isLoading(true);

      if (termserch.value.isEmpty) {
        termserch.value = "PERSES";
      }

      var data =
          await _service.fetchSonglist(term: termserch.value);

      if (data == null) {
        refreshController.refreshFailed();
        showErrorDialog(AppConstant.errorMsgGeneral);
        return;
      }

      if (data.results != null) {
        songs.assignAll(data.results!);

        hasMore.value = songs.length < (data.resultCount ?? 0);

        refreshController.refreshCompleted();
        if (!hasMore.value) {
          refreshController.loadNoData();
        } else {
          refreshController.resetNoData();
        }
      }
    } catch (e) {
      log("Error in loadSongList controller : $e");

      showErrorDialog(AppConstant.errorMsgGeneral);
    } finally {
      isLoading(false);
    }
  }

  // --- โหลดเพิ่ม (Load More / Pull Up) ---
  Future<void> loadMoreSong() async {
    if (!hasMore.value) {
      refreshController.loadNoData();
      return;
    }

    try {
      var data = await _service.fetchSonglist(
        term: termserch.value
      );

      if (data == null) {
        refreshController.loadFailed();
        return;
      }

      if (data.results != null) {
        if (data.results!.isEmpty) {
          hasMore.value = false;
          refreshController.loadNoData();
        } else {
          songs.addAll(data.results!);
          hasMore.value = songs.length < (data.resultCount ?? 0);

          if (!hasMore.value) {
            refreshController.loadNoData();
          } else {
            refreshController.loadComplete();
          }
        }
      }
    } catch (e) {
      log("Error in loadMoreSong: $e");
      refreshController.loadFailed();
      showErrorDialog(AppConstant.errorMsgGeneral);
    }
  }

  // search music 
  void searchMusic(String query) {
    termserch.value = query;
    if (query.isNotEmpty) {
      loadSongList(); 
    }
  }

  // เล่นเพลง
  Future<void> togglePlay(Song song) async {
    selectedSong.value = song;

    if (song.previewUrl == null) {
      showErrorDialog(AppConstant.errorMsgMusic);
      return;
    }

    try {
      if (playingTrackId.value == song.trackId && isPlaying.value) {
        await _audioPlayer.pause();
        isPlaying(false);
      } else {
        await _audioPlayer.stop();
        await _audioPlayer.play(UrlSource(song.previewUrl.toString()));
        playingTrackId.value = song.trackId ?? 0;
        isPlaying(true);
      }
    } catch (e) {
      log("Audio Player Error: $e");
      isPlaying(false);
    }
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}
