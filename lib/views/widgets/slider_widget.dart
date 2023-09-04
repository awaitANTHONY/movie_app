import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/home_controller.dart';
import '/consts/consts.dart';
import '/utils/helpers.dart';

class SliderWidget extends StatelessWidget {
  SliderWidget({
    super.key,
  });

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          CarouselSlider.builder(
            itemCount: homeController.banners.length,
            itemBuilder: (context, index, realIndex) {
              var item = homeController.banners[index];
              return InkWell(
                onTap: () {
                  //
                },
                child: Stack(
                  children: [
                    cachedNetworkImage(
                      item.image!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: AppSizes.size30,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black,
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Text(
                          item.title!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.size16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              height: AppSizes.newSize(25),
              viewportFraction: 1.0,
              onPageChanged: (int page, CarouselPageChangedReason reason) {
                homeController.currentIndex.value = page;
              },
            ),
          ),
          if (homeController.banners.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(5),
              child: DotsIndicator(
                dotsCount: homeController.banners.length,
                position: homeController.currentIndex.value,
                decorator: DotsDecorator(
                  activeColor: AppColors.primary,
                  color: AppColors.primary.withOpacity(0.5),
                  spacing: const EdgeInsets.all(3),
                  size: const Size.square(4.0),
                  activeSize: const Size(20.0, 4.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            )
        ],
      );
    });
  }
}
