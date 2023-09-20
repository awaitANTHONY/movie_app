import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/movie_controller.dart';
import 'package:movie_app/views/screens/movie_details_screen.dart';
import 'package:movie_app/views/screens/video2_screen.dart';
import '/consts/consts.dart';
import '/utils/helpers.dart';
import 'favourite_widget.dart';

class SliderWidget extends StatelessWidget {
  SliderWidget({
    super.key,
  });

  final MovieController movieController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var sliders = movieController.sliders;
      if (sliders.isEmpty) {
        return Container(
          height: AppSizes.newSize(28),
          width: double.infinity,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        );
      }

      return Column(
        children: [
          CarouselSlider.builder(
            itemCount: sliders.length,
            itemBuilder: (context, index, realIndex) {
              var item = sliders[index];
              return InkWell(
                onTap: () {
                  Get.to(() => MovieDetailsScreen(item));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        cachedNetworkImage(
                          item.eEmbedded?.wpFeaturedmedia?[0].sourceUrl ?? '',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.1),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: AppSizes.size30,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black54,
                                  Colors.black38,
                                ],
                              ),
                            ),
                            child: Text(
                              item.title!.rendered!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppSizes.size16,
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: FavouriteWidget(item: item),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: AppSizes.size30 + 10,
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                Get.to(() => Video2Screen(item));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.red.shade600,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Play Trailer',
                                  style: TextStyle(
                                    color: AppColors.text,
                                    fontSize: AppSizes.size15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              height: AppSizes.newSize(22),
              viewportFraction: 0.8,
              onPageChanged: (int page, CarouselPageChangedReason reason) {
                settingController.currentIndex.value = page;
              },
            ),
          ),
          if (sliders.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(5),
              child: DotsIndicator(
                dotsCount: sliders.length,
                position: settingController.currentIndex.value,
                decorator: DotsDecorator(
                  activeColor: AppColors.primary,
                  color: AppColors.primary.withOpacity(0.5),
                  spacing: const EdgeInsets.all(3),
                  size: const Size.square(4.0),
                  activeSize: const Size(20.0, 4.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
