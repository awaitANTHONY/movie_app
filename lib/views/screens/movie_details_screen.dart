import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:movie_app/models/movie.dart';
import '/utils/helpers.dart';
import 'package:flutter_html/flutter_html.dart';
import '/consts/consts.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie item;
  const MovieDetailsScreen(this.item, {Key? key}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: AppSizes.newSize(6),
        centerTitle: false,
        title: widget.item.title!.rendered!.length > 25
            ? SizedBox(
                height: AppSizes.newSize(2),
                child: Marquee(
                  text: widget.item.title!.rendered!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.size14,
                    color: AppColors.text,
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
                widget.item.title!.rendered.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.size14,
                  color: AppColors.text,
                ),
              ),
      ),
      body: Container(
        margin: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipPath(
                //clipper: NewsContainerClipPath(),
                child: cachedNetworkImage(
                  widget.item.eEmbedded!.wpFeaturedmedia![0].sourceUrl!,
                  height: AppSizes.newSize(25),
                  width: double.infinity,
                  imageBuilder: (context, imageProvider) => Container(
                    height: AppSizes.newSize(25),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
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
              ),
              Transform.rotate(
                angle: turnDegress(-1.5),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: Get.width,
                  color: AppColors.background2,
                  child: Transform.rotate(
                    angle: turnDegress(1.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 4),
                          child: Text(
                            removeAllHtmlTags(widget.item.title!.rendered!),
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
                            widget.item.modified!,
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
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Builder(builder: (context) {
                  String data = widget.item.content!.rendered!;

                  return Html(
                    data: widget.item.content!.rendered,
                    style: {
                      "*": Style(
                        margin: Margins.all(0),
                        padding: HtmlPaddings.all(0)
                            .copyWith(bottom: HtmlPadding(10)),
                        lineHeight: const LineHeight(1.3),
                        color: AppColors.text,
                        fontSize: FontSize(AppSizes.size14),
                        textAlign: TextAlign.justify,
                      ),
                      "a": Style(
                        display: settingController.enableDownload.value
                            ? Display.block
                            : Display.none,
                        margin: Margins.all(0),
                        padding: HtmlPaddings.all(0)
                            .copyWith(bottom: HtmlPadding(10)),
                        lineHeight: const LineHeight(1.3),
                        color: AppColors.primary,
                        fontSize: FontSize(AppSizes.size14),
                        textAlign: TextAlign.justify,
                      ),
                      'img': Style(
                        display: Display.none,
                        verticalAlign: VerticalAlign.baseline,
                        width: Width(Get.width * .8),
                        //height: ,
                        textAlign: TextAlign.center,
                        margin: Margins.all(0),
                        padding: HtmlPaddings.all(0)
                            .copyWith(bottom: HtmlPadding(10)),
                        alignment: Alignment.center,
                        lineHeight: const LineHeight(1.3),
                      ),
                    },
                    onLinkTap: (url, attributes, element) async {
                      await launchURL(url);
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
