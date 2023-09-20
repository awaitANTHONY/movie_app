import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:movie_app/controllers/movie_controller.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/services/tmdb_service.dart';
import 'package:movie_app/views/screens/video2_screen.dart';
import 'package:movie_app/views/widgets/favourite_widget.dart';
import 'package:movie_app/views/widgets/home_channel_widget.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_data_api/models/video.dart';
import 'package:youtube_data_api/youtube_data_api.dart';
import '/utils/helpers.dart';
import 'package:flutter_html/flutter_html.dart';
import '/consts/consts.dart';

// class MovieDetailsScreen extends StatefulWidget {
//   final Movie item;
//   const MovieDetailsScreen(this.item, {Key? key}) : super(key: key);

//   @override
//   State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
// }

// class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
//   late final PodPlayerController controller;
//   late String title;
//   Video? trailer;
//   bool isLoading = true;
//   @override
//   void initState() {
//     super.initState();

//     title = removeAllHtmlTags(widget.item.title!.rendered!);

//     Future.delayed(1.seconds, () async {
//       List<dynamic> list = await YoutubeDataApi().fetchSearchVideo(
//         title,
//         AppConsts.ytApiKey,
//       );

//       trailer = list.firstWhereOrNull((element) => element is Video);
//       if (trailer != null) {
//         controller = PodPlayerController(
//           playVideoFrom: PlayVideoFrom.youtube(
//             "https://www.youtube.com/watch?v=${trailer!.videoId}",
//           ),
//           podPlayerConfig: const PodPlayerConfig(
//             autoPlay: true,
//             isLooping: true,
//           ),
//         )..initialise();
//       }
//       isLoading = false;
//       setState(() {});
//     });

//     Future.delayed(0.seconds, () async {
//       dd('object');
//       var t = title
//           .replaceAll(RegExp(r"\D"), "")
//           .replaceAll('-', ' ')
//           .replaceAll(RegExp(r"\p{P}", unicode: true), "");
//       var movies = await TMDBService.search(t);

//       for (var movie in movies) {
//         print("${movie.title} - ${movie.voteAverage}");
//       }
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();

//     controller.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         toolbarHeight: AppSizes.newSize(6),
//         centerTitle: false,
//         title: widget.item.title!.rendered!.length > 25
//             ? SizedBox(
//                 height: AppSizes.newSize(2),
//                 child: Marquee(
//                   text: removeAllHtmlTags(widget.item.title!.rendered!),
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: AppSizes.size14,
//                     color: AppColors.text2,
//                   ),
//                   scrollAxis: Axis.horizontal,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   blankSpace: 20.0,
//                   velocity: 100.0,
//                   pauseAfterRound: const Duration(seconds: 1),
//                   startPadding: 10.0,
//                   accelerationDuration: const Duration(seconds: 1),
//                   accelerationCurve: Curves.linear,
//                   decelerationDuration: const Duration(milliseconds: 500),
//                   decelerationCurve: Curves.easeOut,
//                 ),
//               )
//             : Text(
//                 removeAllHtmlTags(widget.item.title!.rendered!),
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: AppSizes.size14,
//                   color: AppColors.text2,
//                 ),
//               ),
//       ),
//       body: Container(
//         margin: const EdgeInsets.all(0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (!isLoading)
//                 if (trailer != null)
//                   AspectRatio(
//                     aspectRatio: 16 / 9,
//                     child: Stack(
//                       alignment: Alignment.bottomCenter,
//                       children: <Widget>[
//                         PodVideoPlayer(
//                           controller: controller,
//                           podProgressBarConfig: const PodProgressBarConfig(
//                             padding: EdgeInsets.only(
//                               bottom: 20,
//                               left: 20,
//                               right: 20,
//                             ),
//                             playingBarColor: Colors.blue,
//                             circleHandlerColor: Colors.blue,
//                             backgroundColor: Colors.blueGrey,
//                           ),
//                           videoThumbnail: DecorationImage(
//                             image: NetworkImage(
//                               widget.item.eEmbedded?.wpFeaturedmedia?[0]
//                                       .sourceUrl ??
//                                   '',
//                             ),
//                             fit: BoxFit.cover,
//                           ),
//                           videoTitle: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 15),
//                             child: Text(
//                               trailer!.title!,
//                               style: TextStyle(
//                                 color: AppColors.text2,
//                                 fontWeight: FontWeight.bold,
//                                 overflow: TextOverflow.ellipsis,
//                                 fontSize: AppSizes.size13,
//                               ),
//                               maxLines: 1,
//                               //textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 else
//                   ClipPath(
//                     //clipper: NewsContainerClipPath(),
//                     child: cachedNetworkImage(
//                       widget.item.eEmbedded!.wpFeaturedmedia![0].sourceUrl!,
//                       height: AppSizes.newSize(25),
//                       width: double.infinity,
//                       imageBuilder: (context, imageProvider) => Container(
//                         height: AppSizes.newSize(25),
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(5)),
//                           image: DecorationImage(
//                             image: imageProvider,
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                       placeholder: (context, url) => Container(
//                         alignment: Alignment.center,
//                         height: double.infinity,
//                         width: double.infinity,
//                         child: SizedBox(
//                           height: AppSizes.newSize(4),
//                           width: AppSizes.newSize(4),
//                           child: CircularProgressIndicator(),
//                         ),
//                       ),
//                     ),
//                   )
//               else
//                 AspectRatio(
//                   aspectRatio: 16 / 9,
//                   child: Center(
//                     child: CircularProgressIndicator(color: AppColors.primary),
//                   ),
//                 ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 width: Get.width,
//                 color: AppColors.background2,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 10),
//                     Container(
//                       margin: const EdgeInsets.symmetric(
//                           vertical: 4, horizontal: 4),
//                       child: Text(
//                         removeAllHtmlTags(widget.item.title!.rendered!),
//                         style: TextStyle(
//                           fontSize: AppSizes.size15,
//                           color: AppColors.text2.withOpacity(.8),
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.justify,
//                       ),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.symmetric(
//                           vertical: 4, horizontal: 4),
//                       child: Text(
//                         widget.item.modified!,
//                         style: TextStyle(
//                           fontSize: AppSizes.size13,
//                           color: AppColors.text2.withOpacity(.86),
//                           fontWeight: FontWeight.normal,
//                         ),
//                         textAlign: TextAlign.start,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Builder(builder: (context) {
//                   String data = widget.item.content!.rendered!;
//                   if (!settingController.enableDownload.value) {
//                     data = widget.item.content!.rendered!
//                         .replaceAll('Download', '')
//                         .replaceAll('DOWNLOAD LINKS', '');
//                   }

//                   return Html(
//                     data: data,
//                     style: {
//                       "*": Style(
//                         margin: Margins.all(0),
//                         padding: HtmlPaddings.all(0)
//                             .copyWith(bottom: HtmlPadding(10)),
//                         lineHeight: const LineHeight(1.3),
//                         color: AppColors.text2,
//                         fontSize: FontSize(AppSizes.size14),
//                         textAlign: TextAlign.justify,
//                       ),
//                       "a": Style(
//                         display: settingController.enableDownload.value
//                             ? Display.block
//                             : Display.none,
//                         margin: Margins.all(0),
//                         padding: HtmlPaddings.all(0)
//                             .copyWith(bottom: HtmlPadding(10)),
//                         lineHeight: const LineHeight(1.3),
//                         color: AppColors.primary,
//                         fontSize: FontSize(AppSizes.size14),
//                         textAlign: TextAlign.justify,
//                       ),
//                       'img': Style(
//                         display: Display.none,
//                         verticalAlign: VerticalAlign.baseline,
//                         width: Width(Get.width),
//                         height: Height(AppSizes.newSize(30)),
//                         textAlign: TextAlign.center,
//                         margin: Margins.all(0),
//                         padding: HtmlPaddings.all(0)
//                             .copyWith(bottom: HtmlPadding(10)),
//                         alignment: Alignment.center,
//                         lineHeight: const LineHeight(1.3),
//                       ),
//                     },
//                     onLinkTap: (url, attributes, element) async {
//                       await launchURL(url);
//                     },
//                   );
//                 }),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class MovieDetailsScreen extends StatefulWidget {
  final Movie item;
  const MovieDetailsScreen(this.item, {Key? key}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieController movieController = Get.find();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: AppSizes.newSize(45),
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Stack(
                      children: [
                        cachedNetworkImage(
                          widget.item.eEmbedded!.wpFeaturedmedia![0].sourceUrl!,
                          height: double.infinity,
                          width: double.infinity,
                          placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            height: double.infinity,
                            width: double.infinity,
                            child: SizedBox(
                              height: AppSizes.newSize(4),
                              width: AppSizes.newSize(4),
                              child: const CircularProgressIndicator(),
                            ),
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 4.0),
                        child: Container(
                          // the size where the blurring starts
                          height: AppSizes.newSize(5),
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.text,
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                size: AppSizes.size20,
                                color: AppColors.text2,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.text,
                            ),
                            child: FavouriteWidget(
                              item: widget.item,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 20,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        Get.to(() => Video2Screen(widget.item));
                      },
                      child: Container(
                        height: AppSizes.newSize(6),
                        width: AppSizes.newSize(6),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          size: AppSizes.size24,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: AppSizes.newSize(5),
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.item.title!.rendered!,
                            style: TextStyle(
                              fontSize: AppSizes.size16,
                              color: AppColors.text,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.oswald().fontFamily,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          10.0.spaceY,
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellowAccent.shade700,
                                size: AppSizes.size24,
                              ),
                              Text(
                                random(1.4, 10.0).toStringAsFixed(2),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.size14,
                                  color: AppColors.text,
                                  height: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              10.0.spaceX,
                              Text(
                                "(${NumberFormat.compact().format(random(1000.4, 20000.0))})",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: AppSizes.size14,
                                  color: AppColors.text,
                                  overflow: TextOverflow.ellipsis,
                                  height: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Story',
                      style: AppStyles.heading.copyWith(
                        fontSize: AppSizes.size24,
                        color: AppColors.text2,
                        height: 1,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 4,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                      ),
                      child: Builder(builder: (context) {
                        String data = widget.item.content!.rendered!;
                        if (!settingController.enableDownload.value) {
                          data = widget.item.content!.rendered!
                              .replaceAll('Download', '')
                              .replaceAll('DOWNLOAD LINKS', '');
                        }

                        return Html(
                          data: data.trim().replaceAll('  ', ''),
                          style: {
                            "*": Style(
                              margin: Margins.all(0),
                              padding: HtmlPaddings.all(0)
                                  .copyWith(bottom: HtmlPadding(10)),
                              lineHeight: const LineHeight(1.3),
                              color: AppColors.text2,
                              fontSize: FontSize(AppSizes.size14),
                              textAlign: TextAlign.justify,
                            ),
                            "a": Style(
                              display: settingController.enableDownload.value
                                  ? Display.block
                                  : Display.none,
                              margin: Margins.all(0),
                              padding: HtmlPaddings.all(0)
                                  .copyWith(bottom: HtmlPadding(10)),
                              lineHeight: const LineHeight(1.3),
                              color: AppColors.primary,
                              fontSize: FontSize(AppSizes.size14),
                              textAlign: TextAlign.justify,
                            ),
                            'img': Style(
                              display: Display.none,
                              verticalAlign: VerticalAlign.baseline,
                              width: Width(Get.width),
                              height: Height(AppSizes.newSize(30)),
                              textAlign: TextAlign.center,
                              margin: Margins.all(0),
                              padding: HtmlPaddings.all(0)
                                  .copyWith(bottom: HtmlPadding(10)),
                              alignment: Alignment.center,
                              lineHeight: const LineHeight(1.3),
                            ),
                            'table': Style(
                              display: Display.none,
                            ),
                            'tr': Style(
                              display: Display.none,
                            ),
                            'td': Style(
                              display: Display.none,
                            ),
                            'th': Style(
                              display: Display.none,
                            ),
                            'div': Style(
                              display: Display.none,
                            ),
                          },
                          onLinkTap: (url, attributes, element) async {
                            await launchURL(url);
                          },
                        );
                      }),
                    )
                  ],
                ),
              ),
              MovieSliderWidget(
                title: 'Nollywood',
                items: movieController.topNollywood.value,
              ),
              20.0.spaceY,
            ],
          ),
        ),
      ),
    );
  }
}
