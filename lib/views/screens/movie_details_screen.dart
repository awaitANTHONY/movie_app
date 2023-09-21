import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/controllers/movie_controller.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/views/screens/video2_screen.dart';
import 'package:movie_app/views/widgets/favourite_widget.dart';
import 'package:movie_app/views/widgets/home_channel_widget.dart';
import '/utils/helpers.dart';
import 'package:flutter_html/flutter_html.dart';
import '/consts/consts.dart';

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
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
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
                items: movieController.topNollywood,
              ),
              20.0.spaceY,
            ],
          ),
        ),
      ),
    );
  }
}
