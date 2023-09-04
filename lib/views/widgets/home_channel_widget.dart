import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/consts/consts.dart';
import 'package:movie_app/controllers/home_controller.dart';
import 'package:movie_app/models/home.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/utils/helpers.dart';

class HomeSliderWidget extends StatelessWidget {
  HomeSliderWidget({
    super.key,
  });

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: homeController.sliders.length,
          itemBuilder: (context, index) {
            var slider = homeController.sliders[index];
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
                        slider.title!,
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
                          //
                        },
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                10.0.spaceY,
                Builder(builder: (context) {
                  List<Movie> movies = (slider.data ?? []).take(5).toList();
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
                                //   Get.to(() => CategoryChannelScreen(item));
                                // });
                              },
                              child: Stack(
                                children: [
                                  Stack(
                                    children: [
                                      cachedNetworkImage(
                                        item.image!,
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
                                        color: AppColors.background
                                            .withOpacity(0.3),
                                      ),
                                      child: Text(
                                        item.title!,
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
                20.0.spaceY,
              ],
            );
          },
        ),
      );
    });
  }
}
