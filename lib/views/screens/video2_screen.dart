import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/utils/helpers.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_data_api/models/video.dart';
import 'package:youtube_data_api/youtube_data_api.dart';
import '/consts/consts.dart';

class Video2Screen extends StatefulWidget {
  const Video2Screen(this.item, {super.key});
  final Movie item;
  @override
  State<Video2Screen> createState() => _Video2ScreenState();
}

class _Video2ScreenState extends State<Video2Screen> {
  late final PodPlayerController controller;
  late String title;
  Video? trailer;
  bool isLoading = true;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);

    super.initState();

    title = removeAllHtmlTags(widget.item.title!.rendered!);

    Future.delayed(1.seconds, () async {
      List<dynamic> list = await YoutubeDataApi().fetchSearchVideo(
        title,
        AppConsts.ytApiKey,
      );

      trailer = list.firstWhereOrNull((element) => element is Video);
      if (trailer != null) {
        controller = PodPlayerController(
          playVideoFrom: PlayVideoFrom.youtube(
            "https://www.youtube.com/watch?v=${trailer!.videoId}",
          ),
          podPlayerConfig: const PodPlayerConfig(
            autoPlay: true,
            isLooping: true,
          ),
        )..initialise();

        //controller.enableFullScreen();
        controller.addListener(() {
          // if (!controller.) {
          //   Get.back();
          // }
        });
      }
      isLoading = false;
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.disableFullScreen(context);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        title: title.length > 25
            ? SizedBox(
                height: AppSizes.newSize(2),
                child: Marquee(
                  text: title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.size14,
                    color: AppColors.text2,
                  ),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 100.0,
                  pauseAfterRound: const Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
              )
            : Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.size14,
                  color: AppColors.text2,
                ),
              ),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.background,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: AppColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isLoading)
            if (trailer != null)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    PodVideoPlayer(
                      controller: controller,
                      podProgressBarConfig: const PodProgressBarConfig(
                        padding: EdgeInsets.only(
                          bottom: 20,
                          left: 20,
                          right: 20,
                        ),
                        playingBarColor: Colors.blue,
                        circleHandlerColor: Colors.blue,
                        backgroundColor: Colors.blueGrey,
                      ),
                      videoThumbnail: DecorationImage(
                        image: NetworkImage(
                          widget.item.eEmbedded?.wpFeaturedmedia?[0]
                                  .sourceUrl ??
                              '',
                        ),
                        fit: BoxFit.cover,
                      ),
                      videoTitle: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          trailer!.title!,
                          style: TextStyle(
                            color: AppColors.text,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            fontSize: AppSizes.size13,
                          ),
                          maxLines: 1,
                          //textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              ClipPath(
                //clipper: NewsContainerClipPath(),
                child: cachedNetworkImage(
                  widget.item.eEmbedded!.wpFeaturedmedia![0].sourceUrl!,
                  height: AppSizes.newSize(25),
                  width: double.infinity,
                  imageBuilder: (context, imageProvider) => Container(
                    height: AppSizes.newSize(25),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                    alignment: Alignment.center,
                    height: double.infinity,
                    width: double.infinity,
                    child: SizedBox(
                      height: AppSizes.newSize(4),
                      width: AppSizes.newSize(4),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              )
          else
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
        ],
      ),
    );
  }
}
