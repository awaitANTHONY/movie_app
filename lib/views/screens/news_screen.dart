import 'dart:math';

import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/models/news.dart';
import 'package:movie_app/utils/helpers.dart';
import '/consts/consts.dart';
import '/controllers/news_controller.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsController newsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (newsController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (newsController.news.isEmpty) {
        return SizedBox(
          height: AppSizes.newSize(60),
          child: Center(
            child: Text(
              "No News Available".toUpperCase(),
              style: TextStyle(
                fontSize: AppSizes.size14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        );
      }
      return RefreshIndicator(
        onRefresh: () => newsController.loadNews(),
        child: ListView(
          children: [
            Builder(builder: (context) {
              var item = newsController.news.first;

              return InkWell(
                onTap: () {
                  //Get.to(() => NewsDetails2Screen(item));
                },
                child: Container(
                  color: AppColors.primary,
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      Stack(
                        children: [
                          ClipPath(
                            //clipper: NewsContainerClipPath(),
                            child: SizedBox(
                              child: cachedNetworkImage(
                                item.image ?? '',
                                height: AppSizes.newSize(22),
                                width: Get.width,
                                fit: BoxFit.fill,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: SizedBox(
                                    width: AppSizes.newSize(2.9),
                                    height: AppSizes.newSize(2.9),
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) {
                                  var item = newsController.news
                                      .where((element) => element.image != null)
                                      .lastOrNull;
                                  return Image.network(
                                    item?.image ?? '',
                                    height: AppSizes.newSize(22),
                                    width: Get.width,
                                    fit: BoxFit.fill,
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 30,
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(6),
                              child: BlinkText(
                                'EXCLUSIVE',
                                duration: 1.5.seconds,
                                beginColor: Colors.red,
                                endColor: Colors.red.withOpacity(.3),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: AppSizes.size16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          (item.title ?? '').toUpperCase(),
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withOpacity(.85),
                            fontSize: AppSizes.size14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          item.date ?? '',
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(.85),
                            fontSize: AppSizes.size12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Text(
                      "TOP STORIES",
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.text2,
                        fontSize: AppSizes.size14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ...newsController.news.skip(1).map(
                  (e) => Builder(
                    builder: (context) {
                      if (e.image == null) return const SizedBox();

                      return NewsBlock(e);
                    },
                  ),
                ),
          ],
        ),
        // child: ListView.builder(
        //   itemCount: newsController.news.length,
        //   itemBuilder: (context, index) {
        //     NewsData? newsItem = newsController.news[index];
        //     if ((newsItem.title ?? '').toLowerCase().contains("fifa")) {
        //       return const SizedBox();
        //     }
        //     if (index % 3 == 0) {
        //       if ((newsItem.description ?? '').toLowerCase().contains("fifa")) {
        //         return const SizedBox();
        //       } else {
        //         return NewsWidgetLarge(newsItem);
        //       }
        //     } else {
        //       return NewsWidget(newsItem);
        //     }
        //   },
        // ),
      );
    });
  }
}

class NewsBlock extends StatelessWidget {
  NewsBlock(this.newsItem, {super.key});
  final NewsData? newsItem;

  final NewsController newsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Get.to(() => NewsDetails2Screen(newsItem!));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: AppSizes.newSize(12),
                width: AppSizes.newSize(12),
                child: cachedNetworkImage(
                  newsItem!.image!,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Builder(builder: (context) {
                    return Center(
                      child: SizedBox(
                        width: AppSizes.newSize(2.3),
                        height: AppSizes.newSize(2.3),
                        child: CircularProgressIndicator(
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                          strokeWidth: 3,
                        ),
                      ),
                    );
                  }),
                  errorWidget: (context, url, error) {
                    var items = newsController.news;

                    var item = items[Random().nextInt(items.length)];

                    return Image.network(
                      item.image!,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    newsItem?.title ?? '',
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.text2,
                      fontSize: AppSizes.size14,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    newsItem?.date ?? '',
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: AppColors.text2,
                      fontSize: AppSizes.size12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
