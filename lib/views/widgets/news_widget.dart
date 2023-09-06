import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/helpers.dart';
import '/consts/consts.dart';
import '/models/news.dart';
import '/services/ads_service.dart';
import '/views/screens/news_details_screen.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget(this.newsItem, {Key? key}) : super(key: key);
  final News? newsItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var arguments = {
          'newsTitle': newsItem?.title ?? '',
          'newsImage': newsItem?.image ?? '',
          'newsTime': newsItem?.pubDate ?? '',
          'newsURL': newsItem?.link ?? '',
          'newsType': newsItem?.newsType ?? '',
        };
        // AdsService.showInterstitialAd(() {
        //   Get.to(() => NewsDetailsScreen(arguments));
        // });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 3,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.background2,
          // boxShadow: const [
          //   BoxShadow(
          //     color: Colors.grey,
          //     blurRadius: 0.1,
          //     spreadRadius: 0.0,
          //     offset: Offset(0, 0), // shadow direction: bottom right
          //   )
          // ],
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 5,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: cachedNetworkImage(
                  newsItem?.image ?? '',
                  hide: false,
                  placeholder: (context, url) => Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(AppAssets.loading),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.fill,
                  height: AppSizes.newSize(15),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: AppSizes.newSize(9.0),
                    child: Text(
                      newsItem?.title ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: AppSizes.size14,
                        color: AppColors.text,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 4,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    height: AppSizes.newSize(3.2),
                    child: Text(
                      newsItem?.pubDate ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: AppColors.text.withOpacity(.6),
                      ),
                      textAlign: TextAlign.start,
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

class NewsWidgetLarge extends StatelessWidget {
  const NewsWidgetLarge(this.newsItem, {Key? key}) : super(key: key);
  final News? newsItem;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var arguments = {
          'newsTitle': newsItem?.title ?? '',
          'newsImage': newsItem?.image ?? '',
          'newsTime': newsItem?.pubDate ?? '',
          'newsURL': newsItem?.link ?? '',
          'newsType': newsItem?.newsType ?? '',
        };
        // AdsService.showInterstitialAd(() {
        //   Get.to(() => NewsDetailsScreen(arguments));
        // });
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10),
        color: AppColors.background2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              child: cachedNetworkImage(
                newsItem?.image ?? '',
                hide: false,
                placeholder: (context, url) => Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: AppSizes.newSize(3),
                    height: AppSizes.newSize(3),
                    child: Image.asset(AppAssets.loading),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
                height: AppSizes.newSize(25),
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      newsItem?.title ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: AppSizes.size14,
                        color: AppColors.text,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      newsItem?.description ?? '',
                      maxLines: 3,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: AppColors.text,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    height: AppSizes.newSize(3.2),
                    child: Text(
                      newsItem?.pubDate ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: AppColors.text.withOpacity(.6),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
