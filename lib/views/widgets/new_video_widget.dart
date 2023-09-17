import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/consts/consts.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/utils/helpers.dart';
import 'package:movie_app/views/screens/movie_details_screen.dart';

class NewVideoWidget extends StatelessWidget {
  const NewVideoWidget({
    super.key,
    required this.item,
  });

  final Movie item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => MovieDetailsScreen(item));
      },
      child: Stack(
        children: [
          Container(
            height: AppSizes.newSize(22),
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  item.eEmbedded?.wpFeaturedmedia?[0].sourceUrl ?? '',
                ),
                fit: BoxFit.fitWidth,
                scale: 1,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
          Positioned(
            bottom: AppSizes.size15,
            left: AppSizes.size15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  removeAllHtmlTags(item.title!.rendered!),
                  style: AppStyles.heading.copyWith(
                    color: AppColors.text,
                    fontSize: AppSizes.size15,
                    height: 1,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 3,
                ),
                5.0.spaceY,
                Text(
                  item.modified ?? '',
                  style: AppStyles.text.copyWith(
                    color: AppColors.text.withOpacity(0.8),
                    fontSize: AppSizes.size13,
                    height: 1,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
