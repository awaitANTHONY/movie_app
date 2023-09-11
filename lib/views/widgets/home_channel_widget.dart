import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          return MovieSliderWidget(
            title: 'Series',
            items: movieController.topSeries.value,
          );
        }),
        Obx(() {
          return MovieSliderWidget(
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
          ).copyWith(right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.size16,
                  color: AppColors.text.withOpacity(.8),
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => MoreScreen(title, items));
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        15.0.spaceY,
        Builder(builder: (context) {
          List<Movie> movies = (items).take(5).toList();
          return SizedBox(
            height: AppSizes.newSize(25),
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 10),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                var item = movies[index];

                return SizedBox(
                  width: AppSizes.newSize(18),
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
                              height: AppSizes.size28,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.background.withOpacity(0.3),
                              ),
                              child: Text(
                                item.title!.rendered!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.size13,
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
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
        30.0.spaceY,
      ],
    );
  }
}
