import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/genre_controller.dart';
import '/utils/helpers.dart';
import '/consts/consts.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  GenreController genreController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (genreController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        );
      }
      if (genreController.genres.isEmpty) {
        return Center(
          child: Text(
            'No categories available.',
            style: AppStyles.heading.copyWith(
              fontSize: AppSizes.size15,
              color: AppColors.text.withOpacity(0.8),
            ),
          ),
        );
      }
      return Container(
        child: GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: List.generate(
            genreController.genres.length,
            (index) {
              var item = genreController.genres[index];
              return ClipRRect(
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
                              fontSize: AppSizes.size16,
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
              );
            },
          ),
        ),
      );
    });
  }
}
