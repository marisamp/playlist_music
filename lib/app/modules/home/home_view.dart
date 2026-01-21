import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:playlist_music/app/core/app_style/app_colors.dart';
import 'package:playlist_music/app/core/app_style/app_text.dart';
import 'package:playlist_music/app/core/constant.dart';
import 'package:playlist_music/app/core/widgets/error_widget.dart';
import 'package:playlist_music/app/data/model/song_model.dart';
import 'package:playlist_music/app/modules/home/home_contoller.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        leading: Image.asset(AppConstant.logoApp),
        title: AppText.title(AppConstant.appName),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child:
                  AppText.title("PERSES Playlist", color: AppColors.blackColor),
            ),
          ),
          // ส่วนของ List เพลง
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.songs.isEmpty) {
                return NoData();
              }

              return SmartRefresher(
                controller: controller.refreshController,
                scrollController: controller.scrollController,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: controller.loadSongList,
                onLoading: controller.loadMoreSong,
                header: headLoad(),
                footer: footerload(),
                child: ListView.builder(
                  itemCount: controller.songs.length,
                  itemBuilder: (context, index) {
                    final song = controller.songs[index];
                    return cardSong(song);
                  },
                ),
              );
            }),
          ),
          SizedBox(height: 20.h),
          // Mini Player
          Obx(() {
            final song = controller.selectedSong.value;
            if (song == null) {
              return const SizedBox.shrink();
            }

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.blackColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  progressbar(),
                  SizedBox(height: 10.h),
                  minicard(song),
                ],
              ),
            );
          }),
        ],
      ),
      floatingActionButton: Obx(
        () {
          // เช็กว่า Mini Player แสดงผลอยู่ไหม
          double bottomPadding =
              controller.selectedSong.value != null ? 80.0 : 0.0;

          return Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: FloatingActionButton(
              onPressed: () => controller.scrollToTop(),
              backgroundColor: AppColors.blackColor,
              foregroundColor: AppColors.whiteColor,
              splashColor: AppColors.whiteColor,
              mini: true,
              elevation: 5,
              child: const Icon(Icons.keyboard_arrow_up),
            ),
          );
        },
      ),
    );
  }

  Widget headLoad() {
    return WaterDropHeader(
      waterDropColor: AppColors.blackColor,
      refresh: CircularProgressIndicator(),
      complete: Icon(
        Icons.check,
        color: AppColors.blackColor,
        size: AppConstant.iconsize,
      ),
    );
  }

  Widget footerload() {
    return CustomFooter(
      builder: (context, mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = AppText(AppConstant.pullUpToLoad);
        } else if (mode == LoadStatus.loading) {
          body = CircularProgressIndicator();
        } else if (mode == LoadStatus.failed) {
          body = AppText(AppConstant.loadFailed);
        } else if (mode == LoadStatus.noMore) {
          body = AppText(AppConstant.noMoreData);
        } else {
          body = AppText(AppConstant.releaseToLoad);
        }
        return SizedBox(height: 55.0, child: Center(child: body));
      },
    );
  }

  Widget cardSong(Song song) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          song.artworkUrl100 ?? '',
          width: AppConstant.imgWSize,
          height: AppConstant.imgHSize,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              AppConstant.logoApp,
              width: AppConstant.imgWSize,
              height: AppConstant.imgHSize,
            );
          },
        ),
      ),
      title: AppText.des(song.trackName ?? "", color: AppColors.blackColor),
      subtitle: AppText(song.artistName ?? "", color: AppColors.blackColor),
      trailing: Obx(
        () {
          //  เช็กเพลง
          bool isThisSong = controller.playingTrackId.value == song.trackId;

          // 2. เช็กสถานะ
          bool isPlayingNow = isThisSong && controller.isPlaying.value;

          return IconButton(
            icon: Icon(
              isPlayingNow
                  ? Icons.pause_circle_filled
                  : Icons.play_circle_outline,
              color: isPlayingNow ? AppColors.yellowColor : AppColors.grayColor,
              size: AppConstant.iconsize,
            ),
            onPressed: () {
              controller.togglePlay(song);
            },
          );
        },
      ),
      onTap: () => controller.togglePlay(song),
    );
  }

  Widget progressbar() {
    return Obx(
      () {
        // คำนวณเปอร์เซ็นต์ (ปัจจุบัน / ทั้งหมด)
        double progress = 0.0;
        if (controller.duration.value.inMilliseconds > 0) {
          progress = controller.position.value.inMilliseconds /
              controller.duration.value.inMilliseconds;
        }

        return LinearProgressIndicator(
          value: progress,
          color: AppColors.yellowColor,
          backgroundColor: AppColors.grayColor,
          minHeight: 4, 
        );
      },
    );
  }

  Widget minicard(Song song) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            song.artworkUrl100 ?? '',
            width: AppConstant.imgWSize,
            height: AppConstant.imgHSize,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                AppConstant.logoApp,
                width: AppConstant.imgWSize,
                height: AppConstant.imgHSize,
              );
            },
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.des(song.trackName ?? ""),
              AppText(song.artistName ?? ""),
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
            size: AppConstant.iconsize,
            color: AppColors.yellowColor,
          ),
          onPressed: () => controller.togglePlay(song),
        ),
      ],
    );
  }
}
