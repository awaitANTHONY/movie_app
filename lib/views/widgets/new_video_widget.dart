import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/consts/consts.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/utils/helpers.dart';
import 'package:movie_app/views/screens/movie_details_screen.dart';
import 'package:movie_app/views/widgets/favourite_widget.dart';

class NewVideoWidget extends StatelessWidget {
  const NewVideoWidget({
    super.key,
    required this.item,
  });

  final Movie item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
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
                      Stack(
                        children: [
                          cachedNetworkImage(
                            item.eEmbedded!.wpFeaturedmedia![0].sourceUrl!,
                            height: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ],
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
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              removeAllHtmlTags(item.excerpt!.rendered!).trim(),
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: AppSizes.size13,
                                color: AppColors.text2.withOpacity(0.8),
                                overflow: TextOverflow.ellipsis,
                                height: 1,
                              ),
                              textAlign: TextAlign.justify,
                              maxLines: 3,
                            ),
                          ),
                          10.0.spaceX,
                          FavouriteWidget(item: item),
                        ],
                      ),
                    ),

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBarIndicator(
                          rating: random(1.4, 10.0),
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
      ),
    );
  }
}
