import 'dart:ui';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:movie_app/controllers/home_controller.dart';
import 'package:movie_app/models/home.dart';
import 'package:movie_app/views/screens/all_screen.dart';
import 'package:movie_app/views/screens/video_screen.dart';

import '/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'webview_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: homeController.menus.length,
      padding: const EdgeInsets.only(
        top: 5,
        left: 10,
        right: 10,
      ),
      itemBuilder: (context, index) {
        var menu = homeController.menus[index];

        if ((menu.tabs?.length ?? 0) > 0 &&
            menu.tabs![0].provider == 'custom') {
          return SizedBox();
        }
        if ((menu.tabs?.length ?? 0) > 0 &&
            menu.tabs![0].provider == 'stream' &&
            !settingController.enableDownload.value) {
          return SizedBox();
        }

        return Container(
          decoration: BoxDecoration(
            color: AppColors.background2.withOpacity(0.0),
            borderRadius: BorderRadius.circular(10),
            // border: Border.all(
            //   color: AppColors.border,
            //   width: 0.5,
            // ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  //vertical: 12,
                ).copyWith(bottom: 5),
                child: Text(
                  menu.title!.toUpperCase(),
                  style: AppStyles.heading.copyWith(
                    fontSize: AppSizes.size16,
                    color: AppColors.text2,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              // Divider(
              //   color: AppColors.border,
              //   height: 0.5,
              // ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  children: menu.tabs!.map((e) {
                    int index = menu.tabs!.indexOf(e);
                    return CustomListTIle(
                      e: e,
                      menu: menu,
                      hasBorder: index != (menu.tabs!.length - 1),
                    );
                  }).toList(),
                ),
              ),
            ],
          ).animate().fade().scale().move(
                delay: 300.ms,
                duration: 600.ms,
              ),
        );
      },
      separatorBuilder: (context, index) => 10.0.spaceY,
    );
  }
}

class CustomListTIle extends StatelessWidget {
  const CustomListTIle(
      {Key? key, required this.e, required this.menu, required this.hasBorder})
      : super(key: key);

  final Tabs e;
  final Menu menu;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ClipPath(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
            tileMode: TileMode.clamp,
          ),
          child: InkWell(
            onTap: () {
              if (e.provider == 'wordpress') {
                Get.to(() => AllScreen(e.title!, e.arguments![0]));
              } else if (e.provider == 'stream') {
                Get.to(() => VideoScreen(e.arguments![0]));
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                // border: Border(
                //   bottom: hasBorder
                //       ? BorderSide(color: AppColors.border, width: 0.5)
                //       : BorderSide.none,
                // ),
                color: AppColors.background2.withOpacity(0.1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (e.title != '' ? e.title! : menu.title!).toUpperCase(),
                    style: AppStyles.text.copyWith(
                      fontSize: AppSizes.size14,
                      color: AppColors.text2.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: AppSizes.size18,
                    color: AppColors.primary,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
