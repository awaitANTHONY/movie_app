import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/models/movie.dart';
import '/consts/consts.dart';
import '/controllers/favorite_controller.dart';

class FavouriteWidget extends StatelessWidget {
  FavouriteWidget({
    super.key,
    required this.item,
  });

  final FavouriteController favouriteController = Get.find();
  final Movie item;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Center(
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            favouriteController.favorite(item);
          },
          child: favouriteController.isLoading2.value &&
                  favouriteController.currentId.value == item.id
              ? SizedBox(
                  height: AppSizes.size20,
                  width: AppSizes.size20,
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                    strokeWidth: 1,
                  ),
                )
              : favouriteController.isSelected(item)
                  ? ImageIcon(
                      const AssetImage('assets/images/icons/heart2.png'),
                      size: AppSizes.size20,
                      color: Colors.red.shade600,
                    )
                  : ImageIcon(
                      const AssetImage('assets/images/icons/heart.png'),
                      size: AppSizes.size20,
                      color: Colors.red.shade600,
                    ),
        ),
      );
    });
  }
}
