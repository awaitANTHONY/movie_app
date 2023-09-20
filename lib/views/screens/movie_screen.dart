import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:movie_app/consts/consts.dart';
import 'package:movie_app/controllers/movie_controller.dart';
import 'package:movie_app/views/widgets/new_video_widget.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  MovieController movieController = Get.find();

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            labelColor: AppColors.text2,
            unselectedLabelColor: AppColors.text2,
            indicatorColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.primary,
                  width: 3,
                ),
              ),
            ),
            tabs: const [
              Tab(
                text: 'Top Movies',
              ),
              Tab(
                text: 'Top Series',
              ),
            ],
          ),
          Obx(() {
            return Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    itemBuilder: (context, index) {
                      var item = movieController.topMovies[index];

                      return NewVideoWidget(item: item);
                    },
                    separatorBuilder: (context, index) {
                      return 0.0.spaceY;
                    },
                    itemCount: movieController.topMovies.length,
                  ).animate().fade().scaleX().move(
                        delay: 300.ms,
                        duration: 600.ms,
                      ),
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    itemBuilder: (context, index) {
                      var item = movieController.topSeries[index];

                      return NewVideoWidget(item: item);
                    },
                    separatorBuilder: (context, index) {
                      return 0.0.spaceY;
                    },
                    itemCount: movieController.topSeries.length,
                  ).animate().fade().scaleX().move(
                        delay: 300.ms,
                        duration: 600.ms,
                      ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
