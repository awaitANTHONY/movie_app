import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/consts/consts.dart';
import 'package:movie_app/controllers/movie_controller.dart';
import 'package:movie_app/utils/helpers.dart';
import 'package:movie_app/views/widgets/new_video_widget.dart';
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
                return NewVideoWidget(item: item);
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
