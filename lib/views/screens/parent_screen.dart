import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/views/screens/home_screen.dart';
import '/consts/consts.dart';
import 'genre_screen.dart';

class ParentScreen extends StatefulWidget {
  const ParentScreen({
    Key? key,
    this.page = 0,
  }) : super(key: key);
  final int page;

  @override
  ParentScreenState createState() => ParentScreenState();
}

class ParentScreenState extends State<ParentScreen> {
  //AuthController authController = Get.find();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      settingController.selectedIndex.value = widget.page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        title: Text(
          AppTexts.appName,
          style: TextStyle(
              //fontFamily: GoogleFonts.carterOne().fontFamily,
              ),
        ),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.background,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: AppColors.background,
      body: Obx(() {
        return IndexedStack(
          index: settingController.selectedIndex.value,
          children: [
            GenreScreen(),
            Container(),
            Container(),
            Container(),
            HomeScreen(),
          ],
        );
      }),
      floatingActionButton: Obx(() {
        return FloatingActionButton(
          heroTag: 'home',
          backgroundColor: Colors.white,
          child: ImageIcon(
            const AssetImage('assets/images/icons/home1.png'),
            size: AppSizes.size20,
            color: settingController.selectedIndex.value == 4
                ? AppColors.primary
                : AppColors.text2,
          ),
          onPressed: () {
            settingController.onItemTapped(4);
          },
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(() {
        return Container(
          color: AppColors.background,
          child: AnimatedBottomNavigationBar(
            backgroundColor: AppColors.background2,
            icons: const [
              AssetImage('assets/images/icons/mozy.png'),
              AssetImage('assets/images/icons/menu.png'),
              AssetImage('assets/images/icons/news.png'),
              AssetImage('assets/images/icons/user.png'),
            ],
            iconSize: AppSizes.size20,
            activeIndex: settingController.selectedIndex.value,
            activeColor: AppColors.primary,
            gapLocation: GapLocation.center,
            inactiveColor: AppColors.text,
            notchSmoothness: NotchSmoothness.smoothEdge,
            onTap: settingController.onItemTapped,
          ),
        );
      }),
    );
  }
}
