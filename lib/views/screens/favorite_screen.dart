import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:movie_app/consts/consts.dart';
import 'package:movie_app/controllers/favorite_controller.dart';
import 'package:movie_app/views/widgets/new_video_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FavouriteController favouriteController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (favouriteController.favorites.isEmpty) {
        return SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/document-not-found.png',
                  height: AppSizes.newSize(18),
                ),
                15.0.spaceY,
                Text(
                  'No favorites history',
                  style: TextStyle(
                    color: AppColors.text2,
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.size20,
                  ),
                )
              ],
            ),
          ),
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        itemBuilder: (context, index) {
          var item = favouriteController.favorites[index];

          return NewVideoWidget(item: item);
        },
        separatorBuilder: (context, index) {
          return 0.0.spaceY;
        },
        itemCount: favouriteController.favorites.length,
      ).animate().fade().scaleX().move(
            delay: 300.ms,
            duration: 600.ms,
          );
    });
  }
}
