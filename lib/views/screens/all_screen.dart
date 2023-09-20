import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/consts/consts.dart';
import 'package:movie_app/controllers/movie_controller.dart';
import 'package:movie_app/utils/helpers.dart';
import 'movie_details_screen.dart';

class AllScreen extends StatefulWidget {
  const AllScreen(this.title, this.url, {super.key});
  final String title;
  final String url;

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  MovieController movieController = Get.find();

  @override
  void initState() {
    super.initState();
    movieController.loadContent(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: AppSizes.newSize(6),
        leading: SizedBox(
          width: AppSizes.newSize(4),
          child: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.text2,
            ),
          ),
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            color: AppColors.text2,
          ),
        ),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.background,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: Obx(() {
        if (movieController.isLoading2.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }
        if (movieController.all.isEmpty) {
          return SizedBox(
            height: double.infinity,
            child: Center(
              child: Text(
                "No content Available".toUpperCase(),
                style: TextStyle(
                  fontSize: AppSizes.size14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
            ),
          );
        }
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              ...movieController.all.map((item) {
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
                                  cachedNetworkImage(
                                    item.eEmbedded!.wpFeaturedmedia![0]
                                        .sourceUrl!,
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
                                Text(
                                  removeAllHtmlTags(item.excerpt!.rendered!)
                                      .trim(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: AppSizes.size13,
                                    color: AppColors.text2.withOpacity(0.8),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                ),
                                const Spacer(),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RatingBarIndicator(
                                      rating: random(1.4, 5.0),
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
              }).toList()
            ].animate(interval: 200.ms).fadeIn(duration: 300.ms).scaleX(),
          ),
        );
        // return ListView.separated(
        //   padding: const EdgeInsets.all(10),
        //   itemBuilder: (context, index) {
        //     var item = movieController.all[index];
        //     return NewVideoWidget(item: item);
        //   },
        //   separatorBuilder: (context, index) {
        //     return 10.0.spaceY;
        //   },
        //   itemCount: movieController.all.length,
        // );
      }),
    );
  }
}
