import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pod_player/pod_player.dart';
import '/consts/consts.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen(this.url, {super.key});
  final String url;
  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late final PodPlayerController controller;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);

    super.initState();

    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(widget.url),
    )..initialise();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        title: const Text(
          'Live',
          style: TextStyle(
            color: AppColors.text,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
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
                  videoThumbnail: const DecorationImage(
                    image: AssetImage(
                      'assets/images/logo.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
