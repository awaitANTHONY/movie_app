import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/consts/consts.dart';
import '/models/news.dart';
import '/views/widgets/news_widget.dart';
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
        child: ListView.builder(
          itemCount: newsController.news.length,
          itemBuilder: (context, index) {
            NewsData? newsItem = newsController.news[index];
            if ((newsItem.title ?? '').toLowerCase().contains("fifa")) {
              return const SizedBox();
            }
            if (index % 3 == 0) {
              if ((newsItem.description ?? '').toLowerCase().contains("fifa")) {
                return const SizedBox();
              } else {
                return NewsWidgetLarge(newsItem);
              }
            } else {
              return NewsWidget(newsItem);
            }
          },
        ),
      );
    });
  }
}
