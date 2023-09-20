import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:movie_app/controllers/news_controller.dart';
import 'package:movie_app/models/news.dart';
import '/utils/helpers.dart';
import 'package:flutter_html/flutter_html.dart';
import '/consts/consts.dart';

class NewsDetailsScreen extends StatefulWidget {
  final NewsData item;
  const NewsDetailsScreen(this.item, {Key? key}) : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  NewsController newsController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
        centerTitle: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.background,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        title: widget.item.title!.length > 25
            ? SizedBox(
                height: AppSizes.newSize(2),
                child: Marquee(
                  text: widget.item.title!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.size14,
                    color: AppColors.text2,
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
                widget.item.title.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.size14,
                  color: AppColors.text2,
                ),
              ),
      ),
      body: Container(
        margin: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: widget.item.image ?? '',
                height: AppSizes.newSize(25),
                width: double.infinity,
                imageBuilder: (context, imageProvider) => Container(
                  height: AppSizes.newSize(25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    //borderRadius: const BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) {
                  var item = newsController.news!
                      .where((element) => element.image != null)
                      .lastOrNull;
                  return cachedNetworkImage(
                    item?.image ?? '',
                    height: AppSizes.newSize(22),
                    width: Get.width,
                    fit: BoxFit.fill,
                  );
                },
                placeholder: (context, url) => Container(
                  alignment: Alignment.center,
                  height: double.infinity,
                  width: double.infinity,
                  child: SizedBox(
                    height: AppSizes.newSize(4),
                    width: AppSizes.newSize(4),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: Get.width,
                color: AppColors.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 4),
                      child: Text(
                        removeAllHtmlTags(widget.item.title!),
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
                        widget.item.date!,
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
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Html(
                  data: widget.item.description!,
                  style: {
                    "*": Style(
                      margin: Margins.all(0),
                      padding:
                          HtmlPaddings.all(0).copyWith(bottom: HtmlPadding(10)),
                      lineHeight: const LineHeight(1.3),
                      color: AppColors.text2,
                      fontSize: FontSize(AppSizes.size14),
                      textAlign: TextAlign.justify,
                    ),
                    'img': Style(
                      display: Display.listItem,
                      verticalAlign: VerticalAlign.baseline,
                      width: Width(Get.width * .8),
                      textAlign: TextAlign.center,
                      margin: Margins.all(0),
                      padding:
                          HtmlPaddings.all(0).copyWith(bottom: HtmlPadding(10)),
                      alignment: Alignment.center,
                      lineHeight: const LineHeight(1.3),
                    ),
                  },
                  onLinkTap: (url, attributes, element) async {
                    await launchURL(url);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
