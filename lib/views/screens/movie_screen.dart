import 'package:flutter/material.dart';
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
          10.0.spaceY,
          Row(
            children: [
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: AppColors.primary,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: InkWell(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(100),
                            bottomLeft: Radius.circular(100),
                          ),
                          onTap: () {
                            tabController.animateTo(0);
                            setState(() {});
                          },
                          child: Container(
                            height: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(100),
                                bottomLeft: Radius.circular(100),
                              ),
                              color: tabController.index == 0
                                  ? AppColors.primary
                                  : Colors.transparent,
                            ),
                            child: Text(
                              'Movies',
                              style: TextStyle(
                                color: AppColors.text,
                                fontSize: AppSizes.size16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: InkWell(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(100),
                            topRight: Radius.circular(100),
                          ),
                          onTap: () {
                            tabController.animateTo(1);
                            setState(() {});
                          },
                          child: Container(
                            height: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(100),
                                topRight: Radius.circular(100),
                              ),
                              color: tabController.index == 1
                                  ? AppColors.primary
                                  : Colors.transparent,
                            ),
                            child: Text(
                              'Series',
                              style: TextStyle(
                                color: AppColors.text,
                                fontSize: AppSizes.size16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
            ],
          ),
          2.0.spaceY,
          Obx(() {
            return Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      var item = movieController.topMovies[index];
                      return NewVideoWidget(item: item);
                      // return index % 2 == 0
                      //     ? VideoWidget(item: item)
                      //     : VideoWidget2(item: item);
                    },
                    separatorBuilder: (context, index) {
                      return 10.0.spaceY;
                    },
                    itemCount: movieController.topMovies.length,
                  ),
                  ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      var item = movieController.topSeries[index];

                      return NewVideoWidget(item: item);
                      // return index % 2 == 0
                      //     ? VideoWidget(item: item)
                      //     : VideoWidget2(item: item);
                    },
                    separatorBuilder: (context, index) {
                      return 10.0.spaceY;
                    },
                    itemCount: movieController.topSeries.length,
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
