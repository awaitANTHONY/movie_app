import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/consts/consts.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/utils/helpers.dart';
import 'package:movie_app/views/screens/movie_details_screen.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({
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
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.background2,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: cachedNetworkImage(
                  item.eEmbedded?.wpFeaturedmedia?[0].sourceUrl ?? '',
                  width: double.infinity,
                  height: AppSizes.newSize(12),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            10.0.spaceX,
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      removeAllHtmlTags(item.title!.rendered!),
                      style: AppStyles.heading.copyWith(
                        color: AppColors.text,
                        fontSize: AppSizes.size14,
                        height: 1,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 3,
                    ),
                    8.0.spaceY,
                    Text(
                      item.modifiedGmt ?? '',
                      style: AppStyles.text.copyWith(
                        color: AppColors.text.withOpacity(0.7),
                        fontSize: AppSizes.size13,
                        height: 1,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoWidget2 extends StatelessWidget {
  const VideoWidget2({
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
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.background2,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      removeAllHtmlTags(item.title!.rendered!),
                      style: AppStyles.heading.copyWith(
                        color: AppColors.text,
                        fontSize: AppSizes.size14,
                        height: 1,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 3,
                    ),
                    8.0.spaceY,
                    Text(
                      item.modifiedGmt ?? '',
                      style: AppStyles.text.copyWith(
                        color: AppColors.text.withOpacity(0.7),
                        fontSize: AppSizes.size13,
                        height: 1,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            10.0.spaceX,
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: cachedNetworkImage(
                  item.eEmbedded?.wpFeaturedmedia?[0].sourceUrl ?? '',
                  width: double.infinity,
                  height: AppSizes.newSize(12),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
