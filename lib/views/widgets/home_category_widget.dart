import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/genre_controller.dart';
import 'package:movie_app/models/genre.dart';
import '/consts/consts.dart';
import '/utils/helpers.dart';

class HomeCategoryWidget extends StatelessWidget {
  HomeCategoryWidget({
    super.key,
  });

  final GenreController genreController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Genre> genres = genreController.genres.take(5).toList();

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
                  'Genres',
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
                    settingController.onItemTapped(0);
                  },
                  child: Text(
                    'See all',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: AppSizes.size14,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          10.0.spaceY,
          SizedBox(
            height: AppSizes.newSize(10),
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 10),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: genres.length,
              itemBuilder: (context, index) {
                var item = genres[index];
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
                                item.genreImage!,
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
                            top: 0,
                            child: Container(
                              height: AppSizes.size28,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.background.withOpacity(0.3),
                              ),
                              child: Text(
                                item.name!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.size13,
                                  color: Colors.white,
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
          ),
          10.0.spaceY,
        ],
      );
    });
  }
}
