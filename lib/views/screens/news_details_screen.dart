import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

import '/services/ads_service.dart';
import '/utils/helpers.dart';
import '/consts/consts.dart';
import '/controllers/news_controller.dart';
import '/controllers/setting_controller.dart';

class NewsDetailsScreen extends StatefulWidget {
  final Map arguments;
  const NewsDetailsScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  NewsController newsController = Get.find();
  SettingController settingsController = Get.find();

  @override
  void initState() {
    super.initState();
    newsController.loadNewsDetails(
      widget.arguments['newsURL'],
      widget.arguments['newsType'],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
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
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: false,
        title: widget.arguments['newsTitle'].length > 25
            ? SizedBox(
                height: AppSizes.newSize(2),
                child: Marquee(
                  text: widget.arguments['newsTitle'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.size14,
                    color: Colors.white,
                  ),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 100.0,
                  pauseAfterRound: const Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
              )
            : Text(
                widget.arguments['newsTitle'].toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.size14,
                  color: Colors.white,
                ),
              ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Theme.of(context)
              .appBarTheme
              .systemOverlayStyle
              ?.statusBarIconBrightness,
          statusBarBrightness: Theme.of(context)
              .appBarTheme
              .systemOverlayStyle
              ?.statusBarBrightness,
        ),
      ),
      //  backgroundColor: AppColors.screenBg,
      body: Obx(
        () {
          return !newsController.isLoading2.value
              ? Container(
                  color: AppColors.background2,
                  margin: const EdgeInsets.all(0),
                  child: ListView(
                    children: [
                      cachedNetworkImage(
                        widget.arguments['newsImage'],
                        height: AppSizes.newSize(25),
                        width: double.infinity,
                        imageBuilder: (context, imageProvider) => Container(
                          height: AppSizes.newSize(25),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[300],
                            ),
                            child: Image.asset(AppAssets.team),
                          );
                        },
                        placeholder: (context, url) => Container(
                          alignment: Alignment.center,
                          height: double.infinity,
                          width: double.infinity,
                          child: SizedBox(
                            height: AppSizes.newSize(4),
                            width: AppSizes.newSize(4),
                            child: Image.asset(AppAssets.loading),
                          ),
                        ),
                        hide: false,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: Get.width,
                        color: Theme.of(context).cardTheme.color,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 4),
                              child: Text(
                                widget.arguments['newsTitle'],
                                style: TextStyle(
                                  fontSize: AppSizes.size15,
                                  color: AppColors.text.withOpacity(.8),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 4),
                              child: Text(
                                widget.arguments['newsTime'],
                                style: TextStyle(
                                  fontSize: AppSizes.size13,
                                  color: AppColors.text.withOpacity(.86),
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            newsController.newsDetails.value.desc?.length ?? 0,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              newsController
                                      .newsDetails.value.desc?[index].details ??
                                  '',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: AppSizes.size13,
                                height: 1.3,
                                color: AppColors.text.withOpacity(.7),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      //bottomNavigationBar: BannerAds(),
    );
  }
}
