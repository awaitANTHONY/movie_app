import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/consts/consts.dart';
import 'package:movie_app/controllers/movie_controller.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/utils/helpers.dart';
import 'package:movie_app/views/screens/more_screen.dart';
import 'package:movie_app/views/screens/movie_details_screen.dart';

class HomeSliderWidget extends StatelessWidget {
  HomeSliderWidget({
    super.key,
  });

  final MovieController movieController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          return MovieSliderWidget(
            title: 'Nollywood',
            items: movieController.topNollywood.value,
          );
        }),
        Obx(() {
          return MovieSliderWidget2(
            title: 'Series',
            items: movieController.topSeries.value,
          );
        }),
        Obx(() {
          return MovieSliderWidget2(
            title: 'Movies',
            items: movieController.topMovies.value,
          );
        }),
      ],
    );
  }
}

class MovieSliderWidget extends StatelessWidget {
  const MovieSliderWidget({
    super.key,
    required this.title,
    required this.items,
  });

  final String title;
  final List<Movie> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.size16,
                  color: AppColors.text2.withOpacity(.8),
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => MoreScreen(title, items));
                },
                child: Text(
                  'View all',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: AppSizes.size14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        10.0.spaceY,
        Builder(builder: (context) {
          List<Movie> movies = (items).take(5).toList();
          return SizedBox(
            height: AppSizes.newSize(22),
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 10),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                var item = movies[index];

                return SizedBox(
                  width: AppSizes.newSize(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        // AdsService.showInterstitialAd(() {
                        Get.to(() => MovieDetailsScreen(item));
                        // });
                      },
                      child: Stack(
                        children: [
                          Stack(
                            children: [
                              cachedNetworkImage(
                                item.eEmbedded!.wpFeaturedmedia![0].sourceUrl!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.fill,
                              ),
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              height: AppSizes.newSize(5),
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title!.rendered!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppSizes.size13,
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      height: 1,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RatingBarIndicator(
                                        rating: random(1.4, 5.0),
                                        itemCount: 5,
                                        itemSize: AppSizes.size13,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                      ),
                                      Text(
                                        NumberFormat.compact()
                                            .format(random(1000.4, 20000.0)),
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: AppSizes.size12,
                                          color: Colors.white,
                                          overflow: TextOverflow.ellipsis,
                                          height: 1,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => 10.0.spaceX,
            ),
          );
        }),
        10.0.spaceY,
      ],
    );
  }
}

class MovieSliderWidget2 extends StatelessWidget {
  const MovieSliderWidget2({
    super.key,
    required this.title,
    required this.items,
  });

  final String title;
  final List<Movie> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.size16,
                  color: AppColors.text2.withOpacity(.8),
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => MoreScreen(title, items));
                },
                child: Text(
                  'View all',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: AppSizes.size14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        10.0.spaceY,
        Builder(builder: (context) {
          List<Movie> movies = (items).take(3).toList();
          return SizedBox(
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 10, right: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(
                parent: RangeMaintainingScrollPhysics(),
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                var item = movies[index];

                return InkWell(
                  onTap: () {
                    Get.to(() => MovieDetailsScreen(item));
                  },
                  child: Container(
                    height: AppSizes.newSize(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.border,
                        width: 0.5,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                cachedNetworkImage(
                                  item.eEmbedded!.wpFeaturedmedia![0]
                                      .sourceUrl!,
                                  height: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ],
                            ),
                          ),
                        ),
                        15.0.spaceX,
                        Expanded(
                          flex: 7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title!.rendered!.trim(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.size15,
                                  color: AppColors.text2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                textAlign: TextAlign.left,
                                maxLines: 1,
                              ),
                              Text(
                                removeAllHtmlTags(item.excerpt!.rendered!)
                                    .trim(),
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: AppSizes.size13,
                                  color: AppColors.text2.withOpacity(0.8),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                textAlign: TextAlign.left,
                                maxLines: 2,
                              ),
                              const Spacer(),
                              // Text(
                              //   removeAllHtmlTags(item.modified!),
                              //   style: TextStyle(
                              //     fontWeight: FontWeight.bold,
                              //     fontSize: AppSizes.size13,
                              //     color: AppColors.text2.withOpacity(0.8),
                              //     overflow: TextOverflow.ellipsis,
                              //   ),
                              //   textAlign: TextAlign.left,
                              //   maxLines: 1,
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RatingBarIndicator(
                                    rating: random(1.4, 5.0),
                                    itemCount: 5,
                                    itemSize: AppSizes.size15,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                  ),
                                  10.0.spaceX,
                                  Text(
                                    "(${NumberFormat.compact().format(random(1000.4, 20000.0))})",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: AppSizes.size12,
                                      color: AppColors.text2,
                                      overflow: TextOverflow.ellipsis,
                                      height: 1,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => 10.0.spaceY,
            ),
          );
        }),
        10.0.spaceY,
      ],
    );
  }
}
